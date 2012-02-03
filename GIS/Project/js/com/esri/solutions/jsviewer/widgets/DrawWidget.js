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

dojo.provide("com.esri.solutions.jsviewer.widgets.DrawWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "DrawWidgetStrings");

// for GUI purposes
dojo.require("dijit.form.Button");
dojo.require("dijit.form.CheckBox");
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.FilteringSelect");
dojo.require("dijit.form.NumberSpinner");
dojo.require("dijit.ColorPalette");

// for FilteringSelect
dojo.require("dojo.data.ItemFileReadStore");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.DrawWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
		constructor: function(/*Object*/ params) {
			this.rounding = {};
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/DrawWidget.html"),
		
		i18nStrings: null,
		
		geometryUrl: "",
		geometryService: null,
		
		_lastDrawToolText: "",
		
		drawColor: null,
		drawSize: 8,
		fontFace: "Arial",
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
	
				if (this.configData) {
					// Init the geometry service
					this.geometryUrl = this.configData.draw.geometryService;
					this.geometryService = new esri.tasks.GeometryService(this.geometryUrl);
					
					this.symbols = this.configData.draw.symbols;
					this.drawColor = new dojo.Color(this.configData.draw.color);
					this.drawSize = this.configData.draw.size;
					this.fontFace = this.configData.draw.font;
					this.measureSize = this.configData.draw.measureSize;
					
					// Set the rounding functions for point, line, area labels
					var gTypes = [];
					for (var gType in this.configData.draw.labelRounding) {
						gTypes.push(gType);
					}
					dojo.forEach(gTypes, dojo.hitch(this, function(gType){
						var digits = this.configData.draw.labelRounding[gType].digits;
						if (this.configData.draw.labelRounding[gType].mode === "round") {
							this.rounding[gType] = function(value){
								return com.esri.solutions.jsviewer.util.round(value, digits);
							};
						}
						else {
							this.rounding[gType] = function(value){
								return com.esri.solutions.jsviewer.util.significantDigits(value, digits);
							};
						}
					}));
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "DrawWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);
				
				// IE does not render the dijit checkbox properly. Rip out the dojoType before it's parsed
				if (dojo.isIE) {
					console.log("removing dojoType='dijit.form.CheckBox'");
					dojo.query('[dojoType="dijit.form.CheckBox"]', this.domNode).forEach(function(x){
						x.removeAttribute("dojoType");
					});
				}
				
				// Init the icons on the toolbuttons,
				// set button names
				var buttons = dojo.query(".toolbutton", this.domNode);
				buttons.forEach(function(item,idx,arr){
					var icon = dojo.moduleUrl("com.esri.solutions.jsviewer", dojo.attr(item, "buttonIcon"));
					dojo.style(item, "backgroundImage", "url(" + icon + ")");
					item.toolType = item.id;
					item.id = null;
				});

				dojo.parser.parse(this.domNode);
			}
			catch (err) { console.error(err); }
		},
		
		startup: function() {
			this.inherited(arguments);
			if (this._initialized) { return; }

			try {
				this.getAllNamedChildDijits();
				
				// Linear units dropdown
				var distUnitData = {
					identifier: "unit",
					label: "unitName",
					items: []
				};
				dojo.forEach(com.esri.solutions.jsviewer.util.measure.knownDistanceUnits, dojo.hitch(this, function(unit) {
					if (this.i18nStrings["distUnit" + unit]) {
						var item = {
							"unit": unit,
							"unitName": this.i18nStrings["distUnit" + unit],
							"abbr": this.i18nStrings["abbrDistUnit" + unit]
						};
						distUnitData.items.push(item);
					}
				}));
				
				var dataStoreD = new dojo.data.ItemFileReadStore({
					data: distUnitData
				});
				
				// Apply datastore to cboDistance widget
				this.widgets.cboDistance.store = dataStoreD;
				this.widgets.cboDistance.searchAttr = "unitName";
				this.widgets.cboDistance.setDisplayedValue('');
				
				// Area units dropdown
				var areaUnitData = {
					identifier: "unit",
					label: "unitName",
					items: []
				};
				dojo.forEach(com.esri.solutions.jsviewer.util.measure.knownAreaUnits, dojo.hitch(this, function(unit) {
					if (this.i18nStrings["areaUnit" + unit]) {
						var item = {
							"unit": unit,
							"unitName": this.i18nStrings["areaUnit" + unit],
							"abbr": this.i18nStrings["abbrAreaUnit" + unit]
						};
						areaUnitData.items.push(item);
					}
				}));
				
				var dataStoreA = new dojo.data.ItemFileReadStore({
					data: areaUnitData
				});
				
				// Apply datastore to cboArea widget
				this.widgets.cboArea.store = dataStoreA;
				this.widgets.cboArea.searchAttr = "unitName";
				this.widgets.cboArea.setDisplayedValue('');
				
				// Set the size NumberSpinner
				this.widgets.sizeInput.setValue(this.drawSize);
				
				// The colorPalette isn't in this.widgets, b/c getNamedChildDigits can't find it
				var item = this.widgets.colorDropDown.dropDown;
				this.widgets["colorPalette"] = item;
				this.widgets.colorPalette.value = this.drawColor;
				
				// Connect other dijits
				var swatch = this.widgets.colorDropDown.containerNode;
				dojo.style(swatch, "backgroundColor", this.widgets.colorPalette.value);
				this.connects.push(dojo.connect(this.widgets.colorPalette, "onChange", function(selColor) {
					dojo.style(swatch, "backgroundColor", selColor);
				}));
			}
			catch (err) {
				console.error(err);
			}
		},
		
		shutdown: function() {
			this.clearGraphics();
			dojo.publish("widgetDrawRequestEvent", [null]);
			this.inherited(arguments);
		},
		
		onToolButtonClick: function(evt) {
			//console.dir(evt);
			if (evt && evt.target) {
				var params = {
					onDrawEnd: dojo.hitch(this, function(geometry){
						this.addGeometry(geometry);
					}),
					label: evt.target.title
				};
				
				switch (evt.target.toolType) {
					case ("btnPoint"):
						params.geometryType = esri.toolbars.Draw.POINT;
						break;
					case ("btnPolyline"):
						params.geometryType = esri.toolbars.Draw.POLYLINE;
						break;
					case ("btnFreehandLine"):
						params.geometryType = esri.toolbars.Draw.FREEHAND_POLYLINE;
						break;
					case ("btnPolygon"):
						params.geometryType = esri.toolbars.Draw.POLYGON;
						break;
					case ("btnFreehandPoly"):
						params.geometryType = esri.toolbars.Draw.FREEHAND_POLYGON;
						break;
					case ("btnText"):
						params.geometryType = esri.toolbars.Draw.POINT;
						break;
					case ("btnClear"):
						this.clearGraphics();
						return;
					default:
						console.error("Unknown toolbutton pressed: " + evt.target.title);
						return;
				}
				this._lastDrawToolText = evt.target.title;
				dojo.publish("widgetDrawRequestEvent", [params]);
			}
		},
		
		addGeometry: function(geometry) {
			if (geometry) {
				try {
					// Handle placing text
					if (geometry.declaredClass === "esri.geometry.Point" && this._lastDrawToolText === this.i18nStrings.btnText) {
						var gText = this.placeText(this.widgets.textInput.getValue(), geometry);
						this.addGraphic(gText);
						return;
					}
					
					// Don't draw or label freehand lines or polygons that are zero-sized
					if (geometry.declaredClass === "esri.geometry.Polyline") {
						if (geometry.paths.length === 1 && geometry.paths[0].length == 2) {
							var p = geometry.paths[0];
							var len = esri.geometry.getLength(p[0], p[1]);
							if (isNaN(len) || len === 0) { return; }
						}
					}
					if (geometry.declaredClass === "esri.geometry.Polygon") {
						if (geometry.rings.length === 1 && geometry.rings[0].length == 3) {
							var r = geometry.rings[0];
							var len01 = esri.geometry.getLength(r[0], r[1]);
							var len02 = esri.geometry.getLength(r[0], r[2]);
							if (isNaN(len01) || isNaN(len02) || len02 === 0 || len02 === 0) { return; }
						}
					}
										
					// Get symbol
					var symbol = this.getSymbol(geometry.type);
					if (!symbol) {
						console.error("DrawWidget does not support geometry of type " + geometry.type);
						return;
					}
					
					// Add geometry graphic
					var graphic = new esri.Graphic(geometry, symbol);
					this.addGraphic(graphic);
					
					// Add labels
					var bAddMeasures;
					if (dojo.isIE) {
						var cbox = dojo.query('[name="chkMeasure"]')[0];
						bAddMeasures = cbox.checked;
					} else {
						bAddMeasures = this.widgets.chkMeasure.checked;
					}
					
					if (bAddMeasures) {
						// Get map units
						var mapLayer = this.map.getLayer(this.map.layerIds[0]);
						var mapUnits = mapLayer.units.substring(4);
						var bMapIsDegrees = mapUnits.indexOf("Degrees") >= 0;
						
						// Get label units. item is an object, with the unit code "unit", i18n name "unitName" and i18n abbreviation "abbr"
						var displayDistUnits = this.widgets.cboDistance.item;
						var displayAreaUnits = this.widgets.cboArea.item;
						
						var x, y, g;
						switch (geometry.type) {
							case "point":
								x = this.rounding.point(geometry.x);
								y = this.rounding.point(geometry.y);
								g = this.getPointLabel(x + ", " + y, geometry);
								this.addGraphic(g);
								break;
								
							case "multipoint":
								for (var i in geometry.points) {
									var coords = geometry.points[i];
									x = this.rounding.point(coords[0]);
									y = this.rounding.point(coords[1]);
									g = this.getPointLabel(x + ", " + y, new esri.geometry.Point(coords, geometry.spatialReference));
									this.addGraphic(g);
								}
								break;
								
							case "polyline":
								if (displayDistUnits) {
									// If geographic, measures return in meters
									var length = com.esri.solutions.jsviewer.util.measure.calculateLength(geometry, bMapIsDegrees);
									for (var i in geometry.paths) {
										if (bMapIsDegrees) {
											mapUnits = "Meters";
										}
										var len = com.esri.solutions.jsviewer.util.measure.convertDistanceUnits(length[i], mapUnits, displayDistUnits.unit);
										var text = this.rounding.line(len) + " " + displayDistUnits.abbr;
										g = this.getPathLabel(text, geometry, i);
										this.addGraphic(g);
									}
								}
								break;
								
							case "polygon":
								if (displayDistUnits || displayAreaUnits) {
									var measureFunc = dojo.hitch(this, function(result){
										for (var i in result.areas) {
											var perimeter = result.lengths[i];
											var area = result.areas[i];
											// perimeter label
											if (displayDistUnits) {
												var peri = com.esri.solutions.jsviewer.util.measure.convertDistanceUnits(perimeter, mapUnits, displayDistUnits.unit);
												var text = this.rounding.line(peri) + " " + displayDistUnits.abbr;
												this.addGraphic(this.getPathLabel(text, geometry, i));
											}
											// area label
											if (displayAreaUnits) {
												var a = com.esri.solutions.jsviewer.util.measure.convertAreaUnits(area, mapUnits, displayAreaUnits.unit);
												text = this.rounding.area(a) + " " + displayAreaUnits.abbr;
												this.addGraphic(this.getAreaLabel(text, geometry, i));
											}
										}
									});
									
									var polyGraphic = new esri.Graphic(geometry);
									if (bMapIsDegrees) {
										// Project to an equal-area projection
										// Shape will be in meters
										mapUnits = "Meters";
										var outSR = new esri.SpatialReference({
											wkid: 54034 //World_Cylindrical_Equal_Area
										});
										this.geometryService.project([polyGraphic], outSR, dojo.hitch(this, function(graphics){
											this.geometryService.areasAndLengths(graphics, measureFunc);
										}));
									}
									else {
										this.geometryService.areasAndLengths([polyGraphic], measureFunc);
									}
								}
								break;
								
							case "extent":
								break;
						}
					}
				}
				catch (err) {
					console.error("DrawWidget::addGeometry", err);
				}
			}
		},
		
		getSymbol: function(/*String*/ geometryType) {
			var sym = null;
			var c = this.widgets.colorPalette.value;
			if (dojo.isString(c)) {
				c = new dojo.Color(c);
			}
			var rgba = c.toRgb();
			rgba.push(0.3);
			var s = this.widgets.sizeInput.getValue();
			
			var outline;
			var fill;
			
			switch (geometryType) {
				case "point":
				case "multipoint":
					outline = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, c, 1);
					fill = new dojo.Color(rgba);
					sym = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, s, outline, fill);
					break;
				case "polyline":
					sym = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, c, s);
					break;
				case "polygon":
				case "extent":
					outline = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, c, 1);
					fill = new dojo.Color(rgba);
					sym = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, outline, fill);
					break;
			}
			
			return sym;
		},
		
		getFont: function(size) {
			if (!size) {
				size = this.widgets.sizeInput.getValue();
			}
			var f = new esri.symbol.Font(size+"pt", esri.symbol.Font.STYLE_NORMAL, esri.symbol.Font.VARIANT_NORMAL, esri.symbol.Font.WEIGHT_BOLD, this.fontFace);
			return f;
		},
		
		placeText: function(text, point) {
			var sym = new esri.symbol.TextSymbol(text, this.getFont(), this.widgets.colorPalette.value);
			sym.setAlign(esri.symbol.TextSymbol.ALIGN_MIDDLE);
			var g = new esri.Graphic(point, sym);
			return g;
		},
		
		getPointLabel: function(text, point) {
			var sym = new esri.symbol.TextSymbol(text, this.getFont(this.measureSize), this.widgets.colorPalette.value);
			sym.setAlign(esri.symbol.TextSymbol.ALIGN_START);
			var g = new esri.Graphic(point, sym);
			return g;
		},

		getPathLabel: function(text, polyline, pathIndex) {
			try {
				var sym = new esri.symbol.TextSymbol(text, this.getFont(this.measureSize), this.widgets.colorPalette.value);
				if (polyline.paths) {
					var path = polyline.paths[pathIndex];
				}
				else { // (polyline.rings)
					var path = polyline.rings[pathIndex];
				}
				var idx = Math.floor(path.length / 2);
				var p1 = polyline.getPoint(pathIndex, idx - 1);
				var p2 = polyline.getPoint(pathIndex, idx);
				var point = com.esri.solutions.jsviewer.util.measure.getMidPoint(p1, p2);
				var angle = com.esri.solutions.jsviewer.util.measure.getAngle(p1, p2);
				sym.setAngle(angle);
				sym.setOffset(0, 2);
				//console.debug("Creating line label text: " + text + " at " + point.x + ", " + point.y);
				var g = new esri.Graphic(point, sym);
				return g;
			}
			catch (err) {
				console.error("Error creating path label", err);
			}
		},
		
		getAreaLabel: function(text, polygon, ringIndex) {
			try {
				var sym = new esri.symbol.TextSymbol(text, this.getFont(this.measureSize), this.widgets.colorPalette.value);
				var point = com.esri.solutions.jsviewer.util.measure.getRingExtent(polygon, ringIndex).getCenter();
				//console.debug("Creating area label text: " + text + " at " + point.x + ", " + point.y);
				var g = new esri.Graphic(point, sym);
				return g;
			}
			catch (err) {
				console.error("Error creating area label", err);
			}
		},
		
		onMapClick: function(evt){
			// override, do nothing
		}
	}
);
