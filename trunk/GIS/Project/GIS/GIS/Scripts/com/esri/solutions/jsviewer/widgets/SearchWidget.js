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

dojo.provide("com.esri.solutions.jsviewer.widgets.SearchWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "SearchWidgetStrings");

// for GUI purposes
dojo.require("dijit.form.Button");
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.FilteringSelect");
dojo.require("com.esri.solutions.jsviewer.ResultList");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.SearchWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
		constructor: function(/*Object*/ params) {
			this.layers = [];
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/SearchWidget.html"),
		
		_initialized: false,
		
		iconUrl: "",
		smallIconUrl: "",
		symbol: null,
		zoomScale: 100000,
		
		loaderNode: null,
		messageNode: null,
		
		i18nStrings: null,
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
	
				if (this.configData) {
					this.zoomScale = this.configData.search.zoomScale;
					// Layers are read from config in startup
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "SearchWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);

				dojo.parser.parse(this.domNode);
				
				// Init the icons on the toolbuttons
				var buttons = dojo.query(".toolbutton", this.domNode);
				buttons.forEach(function(item,idx,arr){
					var icon = dojo.moduleUrl("com.esri.solutions.jsviewer", dojo.attr(item, "buttonIcon"));
					dojo.style(item, "backgroundImage", "url(" + icon + ")");
				});

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
				
				// Attach events
				this.connects.push(dojo.connect(this.widgets.btnSearchText, "onClick", this, "onTextSearch"));
				this.connects.push(dojo.connect(this.widgets.btnClearText, "onClick", this, "onTextClear"));
				this.connects.push(dojo.connect(this.widgets.cboGraphicSearch, "onChange", this, "onGraphicSearchLayerChange"));
				this.connects.push(dojo.connect(this.widgets.cboTextSearch, "onChange", this, "onTextSearchLayerChange"));
				
				// Search Layers dropdowns
				var graphicSearchLayerData = {
					identifier: "name",
					label: "name",
					items: []
				};
				var textSearchLayerData = {
					identifier: "name",
					label: "name",
					items: []
				};
				
				var gInitValue = null;
				var tInitValue = null;
				
				dojo.forEach(this.configData.search.layers, dojo.hitch(this, function(layer) {
					if (layer.graphicalSearch) {
						graphicSearchLayerData.items.push(dojo.clone(layer));
						gInitValue = layer.name;
					}
					if (layer.expression) {
						textSearchLayerData.items.push(dojo.clone(layer));
						tInitValue = layer.name;
					}
					// Store the config for the layer
					this.layers[layer.name] = layer;
				}));
				
				var graphicSearchDataStore = new dojo.data.ItemFileReadStore({
					data: graphicSearchLayerData
				});
				var textSearchDataStore = new dojo.data.ItemFileReadStore({
					data: textSearchLayerData
				});
				
				// Apply datastores to widgets
				this.widgets.cboGraphicSearch.store = graphicSearchDataStore;
				this.widgets.cboGraphicSearch.searchAttr = "name";
				this.widgets.cboGraphicSearch.setValue(gInitValue);

				this.widgets.cboTextSearch.store = textSearchDataStore;
				this.widgets.cboTextSearch.searchAttr = "name";
				this.widgets.cboTextSearch.setValue(tInitValue);
				
				// Init the map graphic symbol
				this.iconUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", this.icon).path;
				this.smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(this.iconUrl);
				// Create map symbols
				this.symbols = {
					point: new esri.symbol.PictureMarkerSymbol(this.iconUrl, 40, 40),
					line: new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0,255,255]), 3),
					polygon: new esri.symbol.SimpleFillSymbol(
						esri.symbol.SimpleFillSymbol.STYLE_SOLID,
						new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0,255,255]), 2),
						new dojo.Color([0,255,255,0.5]))
				};
				
				// Grab the message node for future use
				this.messageNode = dojo.query(".resultsMsg", this.domNode)[0];
				this.setMessage(this.i18nStrings.msgReady);
				
				// Listen to result selection messages
				this.connects.push(dojo.connect(this.widgets.results, "onResultClick", this, "onResultClick"));
				this.connects.push(dojo.connect(this.widgets.results, "onResultHover", this, "onResultHover"));
				this.clearResults();

				this._initialized = true;
			}
			catch (err) {
				console.error("SearchWidget::startup", err);
			}
		},
		
		shutdown: function() {
			this.clearResults();
			dojo.publish("widgetHighlightEvent", [null]);
			this.inherited(arguments);
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
		
		clearResults: function() {
			this.widgets.results.clear();
			this.clearGraphics();
		},
		
		onToolButtonClick: function(evt) {
			if (evt && evt.target) {
				var params = {
					onDrawEnd: dojo.hitch(this, function(geometry) { this.searchGeometry(geometry); }),
					label: evt.target.title
				};
				
				switch (evt.target.title) {
					case (this.i18nStrings.msgSearchPoint):
						params.geometryType = esri.toolbars.Draw.POINT;
						break;
					case (this.i18nStrings.msgSearchLine):
						params.geometryType = esri.toolbars.Draw.POLYLINE;
						break;
					case (this.i18nStrings.msgSearchRect):
						params.geometryType = esri.toolbars.Draw.EXTENT;
						break;
					case (this.i18nStrings.msgSearchPolygon):
						params.geometryType = esri.toolbars.Draw.POLYGON;
						break;
					case (this.i18nStrings.msgSearchClear):
						this.clearResults();
						return;
					default:
						console.error("Unknown toolbutton pressed: " + evt.target.title);
						return;
				}
				dojo.publish("widgetDrawRequestEvent", [params]);
			}
		},
		
		onGraphicSearchLayerChange: function(newValue) {
			var msg = this.i18nStrings.promptGraphicSearch;
			msg = dojo.string.substitute(msg, [newValue]);
			this.graphicSearchPrompt.innerHTML = msg;
		},
		
		onTextSearchLayerChange: function(newValue) {
			var msg = this.i18nStrings.promptTextSearch;
			
			var store = this.widgets.cboGraphicSearch.store;
			store.fetchItemByIdentity({
				identity: newValue,
				onItem: dojo.hitch(this, function(item,request) {
					var textSearchField = store.getValue(item, "textSearchField");
					var textSearchSampleValue = store.getValue(item, "textSearchSampleValue");
					msg = dojo.string.substitute(msg, [newValue, textSearchField, textSearchSampleValue]);
					this.textSearchPrompt.innerHTML = msg;
				})
			});
		},

		onTextSearch: function(evt) {
			var layer = this.layers[this.widgets.cboTextSearch.getValue()];
			if (layer) {
				var url = layer.url;
				var task = new esri.tasks.QueryTask(url);
				
				var q = new esri.tasks.Query();
				q.returnGeometry = true;
				q.outFields = layer.fields;
				q.outSpatialReference = this.map.spatialReference;
				var expr = layer.expression;
				expr = expr.replace("[value]", this.widgets.textSearch.getValue());
				q.where = expr;
				
				try {
					task.execute(q, dojo.hitch(this, "searchCallback", layer.name));
					this.setMessage(this.i18nStrings.msgSearch, true);
					this.clearResults();
					this.onShowPanel(2);
				}
				catch (err) {
					console.error("onTextSearch", err);
				}
			}
		},
		
		onTextClear: function(evt) {
			this.widgets.textSearch.setValue("");
		},
		
		searchGeometry: function(geometry) {
			var layer = this.layers[this.widgets.cboGraphicSearch.getValue()];
			if (layer) {
				var url = layer.url;
				var task = new esri.tasks.QueryTask(url);
				
				var q = new esri.tasks.Query();
				q.returnGeometry = true;
				q.outFields = layer.fields;
				q.outSpatialReference = this.map.spatialReference;
				q.geometry = geometry;
				
				try {
					task.execute(q, dojo.hitch(this, "searchCallback", layer.name));
					this.setMessage(this.i18nStrings.msgSearch, true);
					this.clearResults();
					this.onShowPanel(2);
				}
				catch (err) {
					console.error("searchGeometry", err);
				}
			}
		},
		
		searchCallback: function(layerId, featureSet) {
			try {
				// Create graphics, list items
				var resultCountBeforeAddingThese = this.widgets.results.count;
				var isUrl = com.esri.solutions.jsviewer.util.isUrl;
				
				dojo.forEach(featureSet.features, dojo.hitch(this, function(f){
					var layer = this.layers[layerId];
					
					// Content
					var link = null;
					var content = "<table>";
					for (var fIdx in layer.fields) {
						var field = layer.fields[fIdx];
						if (field === layer.linkField) {
							link = f.attributes[field];
						}
						else if (field !== layer.titleField) {
							content += "<tr><td>" + field + ":</td><td>" + f.attributes[field] + "</td></tr>";
						}
					}
					content += "</table>";
					
		            var attrs = {
		                "title": f.attributes[layer.titleField],
		                "content": content,
		                "link": link
		            };
					
					var sym = null;
					var loc = null;
					switch (f.geometry.type) {
						case "point":
							sym = this.symbols.point;
							loc = f.geometry;
							break;
						case "multipoint":
							sym = this.symbols.point;
							loc = f.geometry.getExtent().getCenter();
							break;
						case "polyline":
							sym = this.symbols.line;
							var nPts = f.geometry.paths[0].length;
							var idx = Math.round(nPts / 2);
							loc = f.geometry.getPoint(0, idx);
							break;
						default:
							sym = this.symbols.polygon;
							// For multiring geometries, choose one
							if (f.geometry.rings && f.geometry.rings.length > 1) {
								var p = new esri.geometry.Polygon(f.geometry.spatialReference);
								p.addRing(f.geometry.rings[0]);
								var ext = p.getExtent();
								loc = ext.getCenter();
							}
							else {
								var ext = f.geometry.getExtent();
								loc = ext.getCenter();
							}
							break;
					}
					
					var g = new esri.Graphic(f.geometry, sym, attrs);
					var zoomScale = this.zoomScale;
					if (layer.zoomScale) {
						zoomScale = layer.zoomScale;
					}
					
					this.widgets.results.add({
						title: attrs.title,
						content: attrs.content,
						iconUrl: this.smallIconUrl,
						graphic: g,
						location: loc,
						link: attrs.link,
						zoomScale: zoomScale
					});
					this.addGraphic(g);
				}));
				
				var msg = this.i18nStrings.msgFound;
				msg = dojo.string.substitute(msg, [this.widgets.results.count]);
				this.setMessage(msg);
				
				if (resultCountBeforeAddingThese === 0) {
					this.widgets.results.selectFirstItem();
				}
			}
			catch (err) {
				console.error("SearchWidget::searchCallback", err);
			}
		},
		
		onResultClick: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				dojo.publish("widgetHighlightEvent", [evt.resultItem.graphic, evt.resultItem.location, true, evt.resultItem.zoomScale]);
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