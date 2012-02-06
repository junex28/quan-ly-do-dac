////////////////////////////////////////////////////////////////////////////////
//
// Copyright © 2008 ESRI
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/JSViewer/License.txt
//
////////////////////////////////////////////////////////////////////////////////

dojo.provide("com.esri.solutions.jsviewer.widgets.LocateWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "LocateWidgetStrings");

// for GUI purposes
dojo.require("dijit.form.Button");
dojo.require("dijit.form.NumberTextBox");
dojo.require("dijit.form.FilteringSelect");
dojo.require("com.esri.solutions.jsviewer.ResultList");

// for FilteringSelect
dojo.require("dojo.data.ItemFileReadStore");

// for Locating
dojo.require("esri.tasks.locator");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.LocateWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
		constructor: function(/*Object*/ params) {
			this.locatorFields = [];
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/LocateWidget.html"),
		
		_initialized: false,
		
		locatorUrl: "",
		locator: null,
		
		geometryUrl: "",
		geometry: null,
		
		iconUrl: "",
		smallIconUrl: "",
		symbol: null,
		
		loaderNode: null,
		messageNode: null,
		
		i18nStrings: null,
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
	
				if (this.configData) {
					this.geometryUrl = this.configData.locate.geometry;
					this.locatorUrl = this.configData.locate.locator;
					this.minGeocodeScore = parseInt(this.configData.locate.minGeocodeScore, 10);
					
					// Init the locator
					this.locator = new esri.tasks.Locator(this.locatorUrl);
					dojo.connect(this.locator, "onAddressToLocationsComplete", dojo.hitch(this, "geocodeCallback"));
					
					// Init the geometry service
					this.geometry = new esri.tasks.GeometryService(this.geometryUrl);
					dojo.connect(this.geometry, "onProjectComplete", dojo.hitch(this, "projectCallback"));
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "LocateWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);

				// Populate locator fields
				var params = {
					url: this.locatorUrl + "?f=pjson",
					handleAs: "json",
					load: dojo.hitch(this, "onGeocodeDescLoad"),
					error: dojo.hitch(this, "onGeocodeDescError"),
					sync: true
				};
				dojo.publish("dataRequestEvent", [params]);

				dojo.parser.parse(this.domNode);
				
				// Init the loader animation
				this.loaderNode = dojo.query(".loader", this.domNode)[0];
				this.loaderNode.src = dojo.moduleUrl("com.esri.solutions.jsviewer", "assets/images/loader.gif");
			}
			catch (err) { console.error(err); }
		},
		
		startup: function() {
			this.inherited(arguments);
			if (this._initialized) { return; }

			try {
				this.getAllNamedChildDijits();
				
				// Projections dropdown
				var projData = {
					identifier: "wkid",
					label: "name",
					items: []
				};
				dojo.forEach(this.configData.locate.projections, dojo.hitch(this, function(info) {
					if (info.wkid === -1) {
						info.name = this.i18nStrings.defaultProjectionName;
					}
					projData.items.push(info);
				}));
				
				var dataStore = new dojo.data.ItemFileReadStore({
					data: projData
				});
				
				// Apply datastore to projection widget
				this.widgets.projection.store = dataStore;
				this.widgets.projection.searchAttr = "name";
				this.widgets.projection.setValue(this.configData.locate.projections[0].wkid);
				
				this.setupConstrainedFields();
				
				// Init the map graphic symbol
				this.iconUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", this.icon).path;
				this.smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(this.iconUrl);
				this.symbol = new esri.symbol.PictureMarkerSymbol(this.iconUrl, 40, 40);
				
				// Attach button click events
				this.connects.push(dojo.connect(this.widgets.btnLocateAddress, "onClick", this, "onAddressLocate"));
				this.connects.push(dojo.connect(this.widgets.btnClearAddress, "onClick", this, "onAddressClear"));
				this.connects.push(dojo.connect(this.widgets.btnLocateCoords, "onClick", this, "onCoordLocate"));
				this.connects.push(dojo.connect(this.widgets.btnClearCoords, "onClick", this, "onCoordClear"));
				
				// Grab the message node for future use
				this.messageNode = dojo.query(".resultsMsg", this.domNode)[0];
				this.setMessage(this.i18nStrings.msgReady);
				
				// Listen to result selection messages
				this.connects.push(dojo.connect(this.widgets.results, "onResultClick", this, "onResultClick"));
				this.connects.push(dojo.connect(this.widgets.results, "onResultHover", this, "onResultHover"));
				this.clearResults();
				
				this._initialized = true;
				// Testing
				//setTimeout(dojo.hitch(this, function() {
				//	this.onAddressLocate();
				//}), 500);
			}
			catch (err) {
				console.error(err);
			}
		},
		
		shutdown: function() {
			this.clearResults();
			dojo.publish("widgetHighlightEvent", [null]);
			this.inherited(arguments);
		},
		
		setupConstrainedFields: function() {
			try {
				// Create the DataStores for dropdowns
				dojo.forEach(this.configData.locate.constrainedFields, dojo.hitch(this, function(name) {
					if (!this.widgets[name]) {
						this.getAllNamedChildDijits();
					}
					if (this.widgets[name]) {
						var data = {
							identifier: "value",
							items: []
						};
						
						dojo.forEach(this.configData.locate.constraintValues[name], function(item){
							data.items.push({
								value: item
							});
						});
						
						var dataStore = new dojo.data.ItemFileReadStore({
							data: data
						});
						
						// Apply datastore to widget
						this.widgets[name].store = dataStore;
						this.widgets[name].searchAttr = "value";
						this.widgets[name].setValue(this.configData.locate.constraintValues[name][0]);
					}
					else {
						console.log("LocateWidget::setupConstrainedFields could not find dropdown " + name);
					}
				}));
			}
			catch (err) {
				console.error("Error configuring constrained fields: ", err);
			}
		},
		
		setMessage: function(/*String*/ message, /*boolean*/ showLoading) {
			this.messageNode.innerHTML = message;
			
			if (showLoading) {
				dojo.style(this.loaderNode, "visibility", "visible");
			}
			else {
				dojo.style(this.loaderNode, "visibility", "hidden");
			}
		},
		
		onGeocodeDescLoad: function(response, ioArgs) {
			// Names of geocoding input fields are in addressFields[idx].name
			if (response.addressFields) {
				for (var idx = 0; idx < response.addressFields.length; idx++) {
					var name = response.addressFields[idx].name;
					
					var tr = document.createElement("TR");
					var th = document.createElement("TH");
					dojo.addClass(th, "rowHeader");
					tr.appendChild(th);
					th.innerHTML = name + ":";
					var td = document.createElement("TD");
					tr.appendChild(td);
					
					// WARNING: creating input/select the W3C way createElement, setAttribute(name)) does not work in IE
					// when the dojo.parser creates the Widgets. The name attribute is not passed.
					// This is why the following code uses innerHTML
					if (dojo.indexOf(this.configData.locate.constrainedFields, name) >= 0) {
						// Create a dijit.form.FilteringSelect
						td.innerHTML = "<select name='" + name + "' dojoType='dijit.form.FilteringSelect'></div>";
					}
					else {
						// Create a dijit.form.TextBox
						td.innerHTML = "<input type='text' name='" + name + "' dojoType='dijit.form.TextBox'></div>";
					}
					
					this.locatorFields.push(name);
					this.geocodingInputTable.insertBefore(tr, this.geocodingButtonRow);
				}
				this.setupConstrainedFields();
			}
			else {
				console.error("Could not find addressFields in geocoder definition", response, ioArgs);
			}
			
			// Always return response object for Deferreds
			return response;
		},
		
		onGeocodeDescError: function(response, ioArgs) {
			console.error("Error reading geocoding description", response, ioArgs);
			
			// Always return response object for Deferreds
			return response;
		},
			
		onAddressLocate: function(evt) {
			try {
				var address = {};
				dojo.forEach(this.locatorFields, dojo.hitch(this, function(name) {
					address[name] = this.widgets[name].getValue();
				}));

				this.locator.addressToLocations(address);
	
				this.setMessage(this.i18nStrings["msgLocate"], true);
				this.clearResults();
				this.onShowPanel(2);
			}
			catch (err) {
				console.error("Error requesting address locations", err);
			}
		},
		
		onAddressClear: function(evt) {
			this.widgets.address.setValue("");
			this.widgets.city.setValue("");
			this.widgets.state.setValue(this.listValues[0]);
			this.widgets.zip.setValue("");
		},
		
		onCoordLocate: function(evt) {
			try {
				this.setMessage(this.i18nStrings["msgLocate"], true);
				this.clearResults();
				this.onShowPanel(2);
				
				var x = this.widgets.longitude.getValue();
				var y = this.widgets.latitude.getValue();
				var pt = new esri.geometry.Point(x, y, this.map.spatialReference);
				
				var attrs = {
					"title": this.i18nStrings["resultTitle"],
					"content": "X: " + x + ", Y: " + y
				};
				
				var p = this.widgets.projection.getValue();
				if (p !== "-1") {
					// User has specified a wkid other than the "special" one for the map projection
					sr = new esri.SpatialReference({
						wkid: p
					});
					// Need to project coords
					pt.setSpatialReference(sr);
					var g = new esri.Graphic(pt);
					g.attributes = attrs;
					this.geometry.project([g], this.map.spatialReference, this.projectCallback);
					return;
				}
				
				// No projection required
				var g = new esri.Graphic(pt, this.symbol, attrs);
				var params = {
					title: attrs.title,
					content: attrs.content,
					iconUrl: this.smallIconUrl,
					graphic: g,
					location: pt
				};
				this.widgets.results.add(params);

				var msg = this.i18nStrings["msgFound"];
				msg = dojo.string.substitute(msg, ["1"]);
				this.setMessage(msg);
				
				this.addGraphic(g);
				this.widgets.results.selectFirstItem();
				
				dojo.publish("widgetLocationsChangedEvent", [{
					source: this.title,
					locations: [params]
				}]);
			}
			catch (err) {
				console.error(err);
				dojo.publish("widgetHighlightEvent", [null]);
			}
		},
		
		onCoordClear: function(evt) {
			this.widgets.latitude.setValue("");
			this.widgets.longitude.setValue("");
		},
		
		clearResults: function() {
			this.widgets.results.clear();
				
			dojo.publish("widgetLocationsChangedEvent", [{
				source: this.title,
				locations: []
			}]);
			this.clearGraphics();
		},
		
		// Callback when a geocode is complete
		geocodeCallback: function(candidates) {
			// Create graphics, list items
			var locations = [];
			dojo.forEach(candidates, dojo.hitch(this, function(c) {
				if ((!this.minGeocodeScore) || (this.minGeocodeScore && c.score >= this.minGeocodeScore)) {
					var attrs = {
						"title": c.address,
						"content": this.i18nStrings["resultScore"] + ": " + c.score
					};
					
					if (!c.location.spatialReference) {
						c.location.spatialReference = this.map.spatialReference;
					}
					var g = new esri.Graphic(c.location, this.symbol, attrs);
					
					var params = {
						title: attrs.title,
						content: attrs.content,
						iconUrl: this.smallIconUrl,
						graphic: g,
						location: c.location
					};
					this.widgets.results.add(params);
					this.addGraphic(g);
					locations.push(params);
				}
			}));
			
			var msg = this.i18nStrings["msgFound"];
			msg = dojo.string.substitute(msg, [locations.length]);
			this.setMessage(msg);
			
			this.widgets.results.selectFirstItem();
			
			dojo.publish("widgetLocationsChangedEvent", [{
				source: this.title,
				locations: locations
			}]);
		},
		
		projectCallback: function(/*esri.Graphic[]*/ graphics) {
			var g = graphics[0];
			if (g && this.projectCallback) {
				g.setSymbol(this.symbol);
				
				this.widgets.results.add({
					title: g.attributes.title,
					content: g.attributes.content,
					iconUrl: this.smallIconUrl,
					graphic: g,
					location: g.geometry
				});

				var msg = this.i18nStrings["msgFound"];
				msg = dojo.string.substitute(msg, [1]);
				this.setMessage(msg);
				
				this.addGraphic(g);
				this.widgets.results.selectFirstItem();
			}
		},
				
		onResultClick: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				dojo.publish("widgetHighlightEvent", [evt.resultItem.graphic, evt.resultItem.location, true]);
			}
			else {
				dojo.publish("widgetHighlightEvent", [null]);
			}
		},
		
		onResultHover: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				dojo.publish("widgetHighlightEvent", [evt.resultItem.graphic, evt.resultItem.location, false]);
			}
			else {
				dojo.publish("widgetHighlightEvent", [null]);
			}
		}
	}
);