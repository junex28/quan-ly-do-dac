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

dojo.provide("com.esri.solutions.jsviewer.widgets.ServiceAreaWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "ServiceAreaWidgetStrings");

// for GUI purposes
dojo.require("dijit.form.Button");
dojo.require("dijit.form.NumberSpinner");
dojo.require("com.esri.solutions.jsviewer.ResultList");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.ServiceAreaWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
		constructor: function(/*Object*/ params) {
			this.symbols = [];
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/ServiceAreaWidget.html"),
		
		url: "",
		gp: null,
		urlGeometry: "",
		geom: null,
		outlineSymbol: null,
		clickPointSymbol: null,
		
		_initialized: false,
		
		i18nStrings: null,
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
				
				this.outlineSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0,0,0,0.5]), 1);
				var mrkOutline = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,255,255]), 2);
				this.clickPointSymbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 10, mrkOutline, new dojo.Color([0,255,0]));
				this.symbols[0] = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, this.outlineSymbol, new dojo.Color([255,255,0,0.3]));
				this.symbols[1] = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, this.outlineSymbol, new dojo.Color([255,140,0,0.3]));
				this.symbols[2] = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, this.outlineSymbol, new dojo.Color([255,0,0,0.3]));

				if (this.configData) {
					this.url = this.configData.serviceArea.url;
					this.urlGeometry = this.configData.serviceArea.geometryService;
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "ServiceAreaWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);

				dojo.parser.parse(this.domNode);
				
				// Init the loader animation
				this.spinnerNodes = dojo.query(".loader", this.domNode);
				var src = dojo.moduleUrl("com.esri.solutions.jsviewer", "assets/images/loader.gif");
				this.spinnerNodes.forEach(function(x) {
					x.src = src;
				});
				
				// Init the icon on the toolbuttons
				var buttons = dojo.query(".toolbutton", this.domNode);
				buttons.forEach(function(item,idx,arr){
					var icon = dojo.moduleUrl("com.esri.solutions.jsviewer", dojo.attr(item, "buttonIcon"));
					dojo.style(item, "backgroundImage", "url(" + icon + ")");
				});
			}
			catch (err) { console.error(err); }
		},
		
		startup: function() {
			this.inherited(arguments);
			dojo.subscribe("knownLocationsChangedEvent", this, "onKnownLocationsChanged");
			
			if (!this._initialized) {
			
				try {
					this.getAllNamedChildDijits();
					
					this.gp = new esri.tasks.Geoprocessor(this.url);
					this.geom = new esri.tasks.GeometryService(this.urlGeometry);
					
					// Attach button click events
					this.connects.push(dojo.connect(this.widgets.btnSubmit, "onClick", this, "onSubmitClick"));
					
					// Grab the message node for future use
					this.messageNode = dojo.query(".resultsMsg", this.domNode)[0];
					this.showSpinner(false);
				
					// The known location list isn't in this.widgets, b/c getNamedChildDigits can't find it
					var item = this.widgets.locationDropDown.dropDown;
					this.widgets["knownLocations"] = item;
					
					// Listen to known location selection messages
					this.connects.push(dojo.connect(this.widgets.knownLocations, "onResultClick", this, "onKnownLocationClick"));
					
					this._initialized = true;
				} 
				catch (err) {
					console.error(err);
				}
			}
			
			// Request the known locations
			dojo.publish("locationsRequestEvent", [{callback: dojo.hitch(this, "onKnownLocationsChanged")}]);
		},
		
		shutdown: function() {
			this.widgets.knownLocations.clear();
			this.clearGraphics();
			dojo.unsubscribe("knownLocationsChangedEvent");
			dojo.publish("widgetDrawRequestEvent", [null]);
			this.inherited(arguments);
		},
		
		showSpinner: function(/*boolean*/ showAnimation) {
			if (showAnimation) {
				this.spinnerNodes.style("visibility", "visible");
			}
			else {
				this.spinnerNodes.style("visibility", "hidden");
			}
		},

		onSubmitClick: function(evt) {
			var params = {
				geometryType: esri.toolbars.Draw.POINT,
				onDrawEnd: dojo.hitch(this, function(geometry) { this.calcServiceArea(geometry); }),
				label: this.i18nStrings.btnSubmit
			};
			dojo.publish("widgetDrawRequestEvent", [params]);
		},
		
		onKnownLocationsChanged: function(resultItems) {
			this.widgets.knownLocations.clear();
			
			var count = 0;
			var rList = this.widgets.knownLocations;
			for (var source in resultItems) {
				dojo.forEach(resultItems[source], function(item){
					item.content = "";
					item.link = "";
					rList.add(item);
					count++;
				});
			}
			
			if (count === 0) {
				this.widgets.locationDropDown.setDisabled(true);
			}
			else {
				this.widgets.locationDropDown.setDisabled(false);
			}
			
			if (dojo.isIE) {
				dojo.style(this.widgets.knownLocations.domNode, "width", "400px");
			}
		},
		
		onKnownLocationClick: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				this.widgets.driveTime1.focus();//closes the dropdownbutton
				this.calcServiceArea(evt.resultItem.location);
			}
		},
		
		calcServiceArea: function(geometry) {
			try {
				this.clearGraphics();
				geometry.setSpatialReference(this.map.spatialReference);
				var g = new esri.Graphic(geometry, this.clickPointSymbol);
				this.addGraphic(g);
				
				var features = [];
				features.push(g);
				var featureSet = new esri.tasks.FeatureSet();
				featureSet.features = features;
				
				var dtInput = [this.widgets.driveTime1.getValue(), this.widgets.driveTime2.getValue(), this.widgets.driveTime3.getValue()];
				var driveTimes = dtInput.join(" ");
				var params = {
					"Input_Location": featureSet,
					"Drive_Times": driveTimes
				};
				this.gp.execute(params, dojo.hitch(this, "gpCallback"));
				this.showSpinner(true);
			}
			catch (err) {
				console.error("ServiceAreaWidget::calcServiceArea", err);
			}
		},
		
		gpCallback: function(results, messages) {
			var features = results[0].value.features;
			
			if (features.length > 0 && features[0].geometry.spatialReference !== this.map.spatialReference) {
				this.geom.project(features, this.map.spatialReference, dojo.hitch(this, "projectCallback"));
			}
			else {
				this.projectCallback(features);
			}
		},
		
		projectCallback: function(features) {
			try {
				var ext = null;
				
				for (var f=0, fl=features.length; f<fl; f++) {
					var feature = features[f];
					feature.setSymbol(this.symbols[f]);
					this.addGraphic(feature);
					if (ext) {
						ext = ext.union(feature.geometry.getExtent());
					}
					else {
						ext = feature.geometry.getExtent();
					}
				}
				
				// Zoom so we can see the full extent of the drive times
				if (ext) {
					this.map.setExtent(ext.expand(2));
				}
			}
			catch (err) {
				console.error("projectCallback", err);
			}
			
			this.showSpinner(false);
		},
		
		onMapClick: function(evt) {
			// override to do nothing
		}
	}
);