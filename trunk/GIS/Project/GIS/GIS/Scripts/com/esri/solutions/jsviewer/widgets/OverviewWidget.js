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

dojo.provide("com.esri.solutions.jsviewer.widgets.OverviewWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.OverviewWidget",
	com.esri.solutions.jsviewer._BaseWidget,
	{
		mapService: "",
		serviceType: "",
		overviewMap: null,
		extentSymbol: null,
		
		tool: null,
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/OverviewWidget.html"),
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
	
				if (this.configData) {
					this.mapService = this.configData.overview.mapservice;
					this.serviceType = this.configData.overview.servicetype;
				}
			}
			catch (err) { console.error(err); }		
		},

		postCreate: function() {
			this.inherited(arguments);

			// Assign an id to the map div
			dojo.attr(this.mapNode, "id", "ov_map_" + Math.floor(Math.random() * 100000));
			
			// Create the map and load the mapService
			setTimeout(dojo.hitch(this, function() { this.initMap(); } ), 100);
			
			this.extentSymbol = new esri.symbol.SimpleFillSymbol(
				esri.symbol.SimpleFillSymbol.STYLE_SOLID,
				new esri.symbol.SimpleLineSymbol(
					esri.symbol.SimpleLineSymbol.STYLE_SOLID,
					new dojo.Color([255,0,0]),
					2),
				new dojo.Color([0,0,0,0.1])
			);
		},
		
		startup: function() {
			this.inherited(arguments);
			
			// listen to extent changes on the main map
			this.connects.push(dojo.connect(this.map, "onExtentChange", this, "extentChangeHandler"));
		},
		
		shutdown: function() {
			
			this.inherited(arguments);
		},
		
		initMap: function() {
			this.overviewMap = new esri.Map(this.mapNode.id);
			
			this.tool = new com.esri.solutions.jsviewer.OverviewWidgetTool();
			this.tool.activate(this.overviewMap);
			dojo.connect(this.tool, "onSetExtent", this, "setExtentHandler");
			
			// Map Service
			var layer = null;
			if (this.serviceType === "tiled") {
				layer = new esri.layers.ArcGISTiledMapServiceLayer(this.mapService, {
					opacity: 1,
					visible: true
				});
			}
			else {
				layer = new esri.layers.ArcGISDynamicMapServiceLayer(this.mapService, {
					opacity: 1,
					visible: true
				});
			}
			
			if (layer) {
				var layerLoadHandle = dojo.connect(layer, "onLoad", dojo.hitch(this, function(layer) {
					this.overviewMap.addLayer(layer);
			
					this.overviewMap.hidePanArrows();
					this.overviewMap.hideZoomSlider();
					this.overviewMap.disableMapNavigation();
					
					this.extentChangeHandler(this.map.extent);
					
					// Disconnect event handler after it fires once
					dojo.disconnect(layerLoadHandle);
				}));
			}
		},
		
		extentChangeHandler: function(extent, delta, levelChange, lod) {
			//draw boundary on map
			//console.debug("overview widget extentChangeHandler start");
			if (this.overviewMap) {
				var gBounds = null;
				for (var idx in this.overviewMap.graphics.graphics) {
					gBounds = this.overviewMap.graphics.graphics[idx];
					gBounds.setGeometry(extent);
					break;
				}
				
				if (gBounds == null) {
					gBounds = new esri.Graphic(extent, this.extentSymbol);
					this.overviewMap.graphics.add(gBounds);
				}
				
				// Adjust the extent of the overview map so that
				// 1) it contains the extent of the main map and
				// 2) it is approx 3-6x the extent of the main map
				var ovExtent = this.overviewMap.extent;
				var wRatio = ovExtent.getWidth() / extent.getWidth();
				var hRatio = ovExtent.getHeight() / extent.getHeight();
				
				if (extent.xmin < ovExtent.xmin || extent.ymin < ovExtent.ymin ||
				extent.xmax > ovExtent.xmax ||
				extent.ymax > ovExtent.ymax ||
				wRatio < 3 ||
				wRatio > 6 ||
				hRatio < 3 ||
				hRatio > 6) {
					this.overviewMap.setExtent(extent.expand(4));
				}
			}
			//console.debug("overview widget extentChangeHandler end");
		},
		
		setExtentHandler: function(extent) {
			this.map.setExtent(extent);
		}
	}
);

dojo.declare(
	"com.esri.solutions.jsviewer.OverviewWidgetTool",
	null,
	{
		constructor: function() {
			this.dragEventConnections = {
				start: null,
				drag: null,
				end: null
			};
			this.points = {
				mapFrom: null,
				mapTo: null,
				screenFrom: null,
				screenTo: null
			};
		},

		map: null,
		startDragExtent: null,
				
		activate: function(map) {
			this.map = map;
			this.dragEventConnections.start = dojo.connect(map, "onMouseDragStart", dojo.hitch(this, "processDragStart"));
			this.dragEventConnections.drag = dojo.connect(map, "onMouseDrag", dojo.hitch(this, "processDrag"));
			this.dragEventConnections.end = dojo.connect(map, "onMouseDragEnd", dojo.hitch(this, "processDragEnd"));
		},
		
		deactivate: function() {
			for (var conn in this.dragEventConnections) {
				if (this.dragEventConnections[conn] != null) {
					dojo.disconnect(this.dragEventConnections[conn]);
					this.dragEventConnections[conn] = null;
				}
			}
		},
		
		getGraphic: function() {
			for (var idx in this.map.graphics.graphics) {
				var g = this.map.graphics.graphics[idx];
				if (g) {
					return g;
				}
			}
			return null;
		},
		
		processDragStart: function(event) {
			//console.log("overview drag start);
			this.points.mapFrom = event.mapPoint;
			this.points.mapTo = null;
			this.points.screenFrom = event.screenPoint;
			this.points.screenTo = null;
			
			var g = this.getGraphic();
			this.startDragExtent = g.geometry;
		},
		
		processDrag: function(event) {
			//console.log("overview drag");
			this.points.mapTo = event.mapPoint;
			this.points.screenTo = event.screenPoint;
			
			var dx = this.points.mapTo.x - this.points.mapFrom.x;
			var dy = this.points.mapTo.y - this.points.mapFrom.y;
			
			var ext = this.startDragExtent.offset(dx, dy);
			var g = this.getGraphic();
			g.setGeometry(ext);
		},
		
		processDragEnd: function(event) {
			//console.log("overview drag end");
			this.points.mapTo = event.mapPoint;
			this.points.screenTo = event.screenPoint;
			
			var dx = this.points.mapTo.x - this.points.mapFrom.x;
			var dy = this.points.mapTo.y - this.points.mapFrom.y;
			
			var ext = this.startDragExtent.offset(dx, dy);
			this.onSetExtent(ext);
	
			this.startDragExtent = null;
		},
			
		onSetExtent: function(/*esri.geometry.Extent*/ extent) {
			// for events
		}
	}
);