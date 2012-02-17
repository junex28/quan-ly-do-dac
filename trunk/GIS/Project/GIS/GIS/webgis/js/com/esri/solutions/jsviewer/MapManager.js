////////////////////////////////////////////////////////////////////////////////
//
// Copyright © 2008 ESRI
// Edited 2012 - NguyenTanThuong UIT 01223830793 
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/JSViewer/License.txt
//
////////////////////////////////////////////////////////////////////////////////

dojo.provide("com.esri.solutions.jsviewer.MapManager");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");

// I18N
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer", "MapManagerStrings");

dojo.require("esri.map");
dojo.require("esri.toolbars.navigation");
dojo.require("esri.toolbars.draw");
dojo.require("esri.toolbars.edit");

dojo.require("com.esri.solutions.jsviewer.Highlight");
dojo.require("com.esri.solutions.jsviewer.InfoPopup");
dojo.require("com.esri.solutions.jsviewer.EditPopup");
dojo.require("dijits.identify.Identify");
dojo.require("dijits.identify.InfoWindowConnector");



dojo.declare("com.esri.solutions.jsviewer.MapManager",
	[dijit._Widget, dijit._Templated],
	{
	    constructor: function(/*Object*/params) {
	        this.pinnedInfoPopups = [];
			this.pinnedEditPopups = [];
	        this.toolNames = {};
	    },

	    templateString: "<div style='display: none;'></div>",

	    i18nStrings: null,
	    toolNames: null,

	    configData: null,
	    mapId: "",
	    map: null,

	    navToolbar: null,
	    drawToolbar: null,
		editToolbar: null,
		//identify: null, 

	    _drawEventHandle: null,
		_indentifyHandle: null ,

	    infoPopup: null,
		editPopup: null,
	    highlight: null,

	    postMixInProperties: function() {
	        //console.log("MapManager postMixInProperties");
	        // If no "mapId" attr has been set, assume the id of the
	        // div to create the esri.Map with is "map"
	        if (this.mapId === "") {
	            this.mapId = "map";
	        }

	        // Init i18n
	        this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer", "MapManagerStrings");
	        this.toolNames[esri.toolbars.Navigation.PAN] = this.i18nStrings.navPanTool;
	        this.toolNames[esri.toolbars.Navigation.ZOOM_IN] = this.i18nStrings.navZoomInTool;
	        this.toolNames[esri.toolbars.Navigation.ZOOM_OUT] = this.i18nStrings.navZoomOutTool;
			//this.toolNames[esri.toolbars.Edit.MOVE] = this.i18nStrings.editMoveTool;
			//this.toolNames[esri.toolbars.Edit.EDIT_VERTICES] = this.i18nStrings.editEditVerticesTool;
			//this.toolNames[esri.toolbars.Edit.ROTATE] = this.i18nStrings.editEditVerticesTool;
			//this.toolNames[esri.toolbars.Edit.SCALE] = this.i18nStrings.editEditVerticesTool;
	    },

	    postCreate: function() {
	        //console.log("MapManager postCreate");
	        dojo.subscribe("configLoadedEvent", this, "onConfig");
	        dojo.subscribe("menuItemClickedEvent", this, "onMenuClick");
	        dojo.subscribe("widgetHighlightEvent", this, "onWidgetHighlight");
			dojo.subscribe("widgetEditAttributeEvent", this, "onEditAttribute");
	        dojo.subscribe("widgetNavRequestEvent", this, "onNavRequest");
	        dojo.subscribe("widgetDrawRequestEvent", this, "onDrawRequest");
	        dojo.subscribe("mapResizeRequestEvent", this, "onResizeRequest");
	        dojo.subscribe("identifyRequestEvent", this, "onIdentifyRequest");
			dojo.subscribe("widgetEditRequestEvent", this,"onEditRequest");
			dojo.subscribe("DeletedGraphicEvent",this,"onDeletedGraphic");
	    },

	    startup: function() {
	        //console.log("MapManager startup");
	        if (this.highlight === null) {
	            var theDiv = document.createElement("div");
	            var mapDiv = dojo.byId(this.map.id);
	            mapDiv.appendChild(theDiv);
	            this.highlight = new com.esri.solutions.jsviewer.Highlight({ map: this.map }, theDiv);
	        }
	    },

	    onConfig: function(configData) {
	        //console.log("MapManager::onConfig");
	        this.configData = configData;

	        // Unsubscribe from the event
	        dojo.unsubscribe("configLoadedEvent");

	        var params = {
	            isZoomSlider: true,
	            isPanArrows: false
	        };

	        // Initial extent defined?
	        if (configData.map.initialExtent) {
	            var ext = configData.map.initialExtent;
	            params.extent = new esri.geometry.Extent(ext[0], ext[1], ext[2], ext[3], null);
	        }
			

	        this.map = new esri.Map(this.mapId, params);

	        var mapLoadHandle = dojo.connect(this.map, "onLoad", dojo.hitch(this, function(map) {
	            // Ensure that the extent is what we asked for
	            setTimeout(dojo.hitch(this, function() {
	                if (this.map.extent !== params.extent) {
	                    this.map.setExtent(params.extent);
	                }
	            }), 1000);

	            // Move the zoom slider down
	            if (!this.map._slider) {
	                console.error("Possible JS API change, private member _slider not available");
	            }
	            else {
	                dojo.style(this.map._slider.domNode, {
	                    top: "100px",
	                    left: "25px"
	                });
	            }

	            // Init toolbars
	            this.navToolbar = new esri.toolbars.Navigation(this.map);
	            this.drawToolbar = new esri.toolbars.Draw(this.map);
				this.editToolbar = new esri.toolbars.Edit(this.map);

	            // Connect layer change events
	            dojo.connect(map, "onLayerAdd", function(layer) {
	                dojo.publish("layerAddedEvent", [layer]);
	            });
	            dojo.connect(map, "onLayerReorder", function(layer, index) {
	                dojo.publish("layerReorderedEvent", [layer, index]);
	            });

	            // Listen to shift-esc combination to deactivate the toolbars
	            dojo.connect(map, "onKeyDown", dojo.hitch(this, function(evt) {
	                if (evt.keyCode === 27 && evt.shiftKey === true) {
	                    this.onNavRequest(null);
	                }
	            }));

	            dojo.publish("mapLoadedEvent", [this.map]);

	            // Disconnect event handler after it fires once
	            dojo.disconnect(mapLoadHandle);
	        }));

	        // Base Map Layers (when first base map is loaded, live maps follow
	        for (var i = 0; i < this.configData.map.baseMaps.length; i++) {
	            this.loadMapService(this.configData.map.baseMaps[i], true);
	        }
	    },

	    loadMapService: function(mapServiceInfo, /*boolean*/isBaseMap) {
	        try {
	            var layer = null;
	            if (mapServiceInfo.type === "tiled") {
	                layer = new esri.layers.ArcGISTiledMapServiceLayer(mapServiceInfo.url, {
	                    id: mapServiceInfo.label,
	                    opacity: parseFloat(mapServiceInfo.alpha),
	                    visible: mapServiceInfo.visible
	                });
	            }
	            else
	                if (mapServiceInfo.type === "dynamic") {
	                layer = new esri.layers.ArcGISDynamicMapServiceLayer(mapServiceInfo.url, {
	                    id: mapServiceInfo.label,
	                    opacity: parseFloat(mapServiceInfo.alpha),
	                    visible: mapServiceInfo.visible
	                });
	            }

	            if (layer) {
	                // Assign a "BASE" or "LIVE" tag to each layer
	                // This allows the LiveMapsWidget to manage the LIVE maps
	                layer.layerCategory = (isBaseMap) ? "BASE" : "LIVE";

	                if (layer.loaded) {
	                    // IE caching behavior, loaded is true right away.
	                    this._layerLoadHander(layer);
	                }
	                else {
	                    dojo.connect(layer, "onLoad", dojo.hitch(this, "_layerLoadHandler", layer));
	                }
	            }
	        }
	        catch (err) {
	            console.error("Loading map service at url: " + mapServiceInfo.url);
	        }
	    },

	    _layerLoadHandler: function(layer) {
	        this.map.addLayer(layer);

	        if (layer.layerCategory === "BASE" && this.map.layerIds.length === 1) {
	            // this is the first Base map to load, start adding Live maps
	            for (var i = 0; i < this.configData.map.liveMaps.length; i++) {
	                this.loadMapService(this.configData.map.liveMaps[i], false);
	            }
	        }
	    },

	    onMenuClick: function(data) {
	        if (data && data.value && data.menuCode) {
	            if (data.menuCode === "basemaps.mapservice") {
	                // User has chosen a basemap

	                // Make it visible
	                // Make other basemaps hidden
	                dojo.forEach(this.map.layerIds, dojo.hitch(this, function(id) {
	                    var layer = this.map.getLayer(id);

	                    // Only change vis of base maps
	                    if (layer.layerCategory && layer.layerCategory === "BASE") {
	                        if (id === data.value) {
	                            layer.show();
	                        }
	                        else {
	                            layer.hide();
	                        }
	                    }
	                }));
	            }

	            if (data.menuCode === "navtools.navtool") {
	                switch (data.value) {
	                    case "pan":
	                        this.onNavRequest(esri.toolbars.Navigation.PAN, this.toolNames[esri.toolbars.Navigation.PAN]);
	                        break;
	                    case "zoomin":
	                        this.onNavRequest(esri.toolbars.Navigation.ZOOM_IN, this.toolNames[esri.toolbars.Navigation.ZOOM_IN]);
	                        break;
	                    case "zoomout":
	                        this.onNavRequest(esri.toolbars.Navigation.ZOOM_OUT, this.toolNames[esri.toolbars.Navigation.ZOOM_OUT]);
	                        break;
	                    case "zoomfull":
	                        this.zoomToFullExtent();
	                        break;
						case "quan1":
							this.zoomToDistrict("quan1");
							break;	
	                }
	            }
	        }
	    },

	    onWidgetHighlight: function(/*esri.Graphic*/g, /*esri.geometry.Point*/location, /*boolean*/forceNav, /*Number*/zoomScale) {
	       	// g is the graphic in the map that the widget wants highlighted and infoboxed
	        if (g && location) {
	            try {
	                // Pan & zoom map if the location isn't in the center of the map
	                if (forceNav) {
	                    var zoomToExt = null;
	                    if (zoomScale) {
	                        if (dojo.isString(zoomScale)) {
	                            zoomScale = parseInt(zoomScale);
	                        }
	                        if (zoomScale > 1) {
	                            var currentScale = com.esri.solutions.jsviewer.util.scale.calculateScale(this.map);
	                            // expand/shrink the scale to match zoomScale
	                            if (zoomScale / currentScale > 2 || zoomScale / currentScale < 0.5) {
	                                zoomToExt = this.map.extent.expand(zoomScale / currentScale);
	                                zoomToExt = zoomToExt.centerAt(location);
	                            }
	                        }
	                    }
	                    if (!zoomToExt) {
	                        var ext = this.map.extent.expand(0.5);
	                        if (!ext.contains(location)) {
	                            zoomToExt = this.map.extent;
	                            zoomToExt = zoomToExt.centerAt(location);
	                        }
	                    }

	                    if (zoomToExt) {
	                        this.map.setExtent(zoomToExt);
	                    }
	                }
	                else {
	                    if (!this.map.extent.contains(location)) {
	                        return;
	                    }
	                }

	                // Highlight Result
	                this.highlight.setCoords(location);
	                this.highlight.setMode("flashing");

	                // Show EditPopup
	                if (this.infoPopup === null) {
	                    var theDiv = document.createElement("div");
	                    var mapDiv = dojo.byId(this.map.id);
	                    mapDiv.appendChild(theDiv);
	                    var popup = new com.esri.solutions.jsviewer.InfoPopup({ map: this.map }, theDiv);
	                    this.infoPopup = popup

	                    // Connect Close and Pin events
	                    // Use of closures to ensure handles are disconnected
	                    // and to maintain a link to the correct infoPopup
	                    var closeHandle = dojo.connect(popup, "onClose", dojo.hitch(this, function() {
	                        dojo.disconnect(closeHandle);
	                        if (this.infoPopup === popup) {
	                            this.infoPopup = null;
	                            if (this.highlight) {
	                                this.highlight.setMode("off");
	                            }
	                        }
	                        else {
	                            for (var i = 0; i < this.pinnedInfoPopups.length; i++) {
	                                if (this.pinnedInfoPopups[i] === popup) {
	                                    this.pinnedInfoPopups.splice(i, 1);
	                                    break;
	                                }
	                            }
	                        }
	                        popup.destroyRecursive();
	                    }));

	                    var pinHandle = dojo.connect(popup, "onPin", dojo.hitch(this, function() {
	                        dojo.disconnect(pinHandle);
	                        if (this.infoPopup === popup) {
	                            this.infoPopup = null;
	                            this.pinnedInfoPopups.push(popup);
	                            if (this.highlight) {
	                                this.highlight.setMode("off");
	                            }
	                        }
	                    }));
	                }

	                this.infoPopup.setInfo(g.attributes);
	                this.infoPopup.setCoords(location);
	                if (this.infoPopup.visible === false) {
	                    this.infoPopup.show();
	                }
	            }
	            catch (err) { console.error("Error highlighting widget result", err); }
	        }
	        else {
	            if (this.highlight) {
	                this.highlight.setMode("off");
	            }
	            if (this.infoPopup) {
	                this.infoPopup.hide();
	            }
	        }
	    },

	    onNavRequest: function(/*esri.toolbars.Navigation.navType*/navType, /*String*/label) {
	        // Deactivate drawing toolbar for starters
	        try {
	            if (this._drawEventHandle) {
	                dojo.disconnect(this._drawEventHandle);
	                this._drawEventHandle = null;
	            }
				
				if (this._indentifyHandle) {
					dojo.disconnect(this._identifyHandle)
	                this._identifyHandle = null;
	            }

	            this.drawToolbar.deactivate();
				this.editToolbar.deactivate();

	            // Activate the navigation toolbar
	            if (navType) {
	                this.navToolbar.activate(navType);
	                dojo.publish("mapToolChangedEvent", [label]);
	            }
	            else {
	                this.navToolbar.deactivate();
	                dojo.publish("mapToolChangedEvent", []);
	            }
	        }
	        catch (err) {
	            console.error("MapManager::onNavRequest", err);
	        }
	    },

	    onDrawRequest: function(/*Object*/params) {
	        // params should contain the geometryType (see esri.toolbars.Draw constants)
	        // and a callback function for onDrawEnd,
	        // and the label to display in the status area

	        try {
	            // Deactivate navigation toolbars for starters
	            this.navToolbar.deactivate();
				this.editToolbar.deactivate();
	            this.drawToolbar.deactivate();

	            // Disconnect any previous drawing listener
	            if (this._drawEventHandle) {
	                dojo.disconnect(this._drawEventHandle);
	                this._drawEventHandle = null;
	            }

	            //Kill the identify Tool
	            if (this._indentifyHandle) {
					dojo.disconnect(this._identifyHandle)
	                this._identifyHandle = null;
	            }



	            // Activate the draw toolbar
	            if (params) {
	                this._drawEventHandle = dojo.connect(this.drawToolbar, "onDrawEnd", params.onDrawEnd);
	                this.drawToolbar.activate(params.geometryType);
	                dojo.publish("mapToolChangedEvent", [params.label]);
	            }
	            else {
	                this.drawToolbar.deactivate();
	                dojo.publish("mapToolChangedEvent", []);
	            }
	        }
	        catch (err) {
	            console.error("MapManager::onDrawRequest", err);
	        }
	    },

	    zoomToFullExtent: function() {
	        if (this.configData.map.fullExtent) {
	            var coords = this.configData.map.fullExtent;
	            var extent = new esri.geometry.Extent(coords[0], coords[1], coords[2], coords[3], null);
	            this.map.setExtent(extent);
	        }
	        else {
	            this.navToolbar.zoomToFullExtent();
	        }
	    },

	    onResizeRequest: function(/*Object*/box) {
	       try{
		   	var mapDiv = dojo.byId(this.map.id);
	        dojo.style(mapDiv, {
	            position: "absolute",
	            left: box.l + "px",
	            top: box.t + "px",
	            width: box.w + "px",
	            height: box.h + "px"
	        });
	        this.map.resize();
	        dojo.publish("mapResizedEvent", [box]);

		   }catch(err){
		   		console.error("MapManager::onResizeRequest "+ err);
		   }
		    	    },


	    onIdentifyRequest: function(params) {
	        // Deactivate drawing and Navigation toolbars for starters
	        try {	
			
				console.log("MapManager::onIdentifyRequest ");
				console.log(params);
				this.navToolbar.deactivate();
	            this.drawToolbar.deactivate();
				this.editToolbar.deactivate();
								            
	            if (this._drawEventHandle) {
	                dojo.disconnect(this._drawEventHandle);
	                this._drawEventHandle = null;
	            }
				
				
				if(params){
					this._identifyHandle = dojo.connect(this.map, "onClick", params.onClick);
					dojo.publish("mapToolChangedEvent", params.label);				
				}
				else{
					dojo.publish("mapToolChangedEvent", []);
				}
					            
	        }
	        catch (err) {
	            console.error("MapManager::Identify Tool", err);
	        }

	    },
		
		onEditRequest: function(/*Object*/params) {

	        try {
	            // Deactivate navigation toolbars for starters
				console.log("Map Manager::onEditRequest");
	            this.navToolbar.deactivate();
	            this.drawToolbar.deactivate();
				this.editToolbar.deactivate();

	            // Disconnect any previous drawing listener
	            if (this._drawEventHandle) {
	                dojo.disconnect(this._drawEventHandle);
	                this._drawEventHandle = null;
	            }
				
				if (this._indentifyHandle) {
					dojo.disconnect(this._identifyHandle)
	                this._identifyHandle = null;
	            }


	            // Activate the edit toolbar
	            if (params) {	                
	                this.editToolbar.activate(params.tool, params.graphic, params.options);
	                dojo.publish("mapToolChangedEvent", [params.label]);
				 }
	            else {
	                this.editToolbar.deactivate();
	                dojo.publish("mapToolChangedEvent", []);
	            }
	        }
	        catch (err) {
	            console.error("MapManager::onEditRequest", err);
	        }
	    },
		
		onEditAttribute: function( /*ResultItem*/res,/*esri.Graphic*/g, /*esri.geometry.Point*/ location, /*boolean*/ forceNav, /*Number*/ zoomScale){
			// g is the graphic in the map that the widget wants highlighted and infoboxed
			console.log("onEditAttribute is startup")
			console.log(g);
			console.log(location);
			if (g && location) {
				try {
					// Pan & zoom map if the location isn't in the center of the map
					if (forceNav) {
						var zoomToExt = null;
						if (zoomScale) {
							if (dojo.isString(zoomScale)) {
								zoomScale = parseInt(zoomScale);
							}
							if (zoomScale > 1) {
								var currentScale = com.esri.solutions.jsviewer.util.scale.calculateScale(this.map);
								// expand/shrink the scale to match zoomScale
								if (zoomScale / currentScale > 2 || zoomScale / currentScale < 0.5) {
									zoomToExt = this.map.extent.expand(zoomScale / currentScale);
									zoomToExt = zoomToExt.centerAt(location);
								}
							}
						}
						if (!zoomToExt) {
							var ext = this.map.extent.expand(0.5);
							if (!ext.contains(location)) {
								zoomToExt = this.map.extent;
								zoomToExt = zoomToExt.centerAt(location);
							}
						}
						
						if (zoomToExt) {
							this.map.setExtent(zoomToExt);
						}
					}
					else {
						if (!this.map.extent.contains(location)) {
							return;
						}
					}
					
					// Highlight Result
					this.highlight.setCoords(location);
					this.highlight.setMode("flashing");
					
					// Show EditPopup
					if (this.editPopup === null) {
						var theDiv = document.createElement("div");
						var mapDiv = dojo.byId(this.map.id);
						mapDiv.appendChild(theDiv);
						var epopup = new com.esri.solutions.jsviewer.EditPopup({
							map: this.map
						}, theDiv);
						this.editPopup = epopup
						
						// Connect Close and Pin events
						// Use of closures to ensure handles are disconnected
						// and to maintain a link to the correct infoPopup
						var closeHandle = dojo.connect(epopup, "onClose", dojo.hitch(this, function(){
							dojo.disconnect(closeHandle);
							if (this.editPopup === epopup) {
								this.editPopup = null;
								if (this.highlight) {
									this.highlight.setMode("off");
								}
							}
							else {
								for (var i = 0; i < this.pinnedEditPopups.length; i++) {
									if (this.pinnedEditPopups[i] === epopup) {
										this.pinnedEditPopups.splice(i, 1);
										break;
									}
								}
							}
							epopup.destroyRecursive();
						}));
						
						var pinHandle = dojo.connect(epopup, "onPin", dojo.hitch(this, function(){
							dojo.disconnect(pinHandle);
							if (this.editPopup === epopup) {
								this.editPopup = null;
								this.pinnedEditPopups.push(epopup);
								if (this.highlight) {
									this.highlight.setMode("off");
								}
							}
						}));
					}
					
					//console.log("DAY LA g.Attributes" );
					//console.log(g.attributes);
					
					this.editPopup.setInfo(g.attributes);
					this.editPopup.setResultItem(res);
					this.editPopup.setCoords(location);
					if (this.editPopup.visible === false) {
						this.editPopup.show();
					}
				} 
				catch (err) {
					console.error("Error highlighting widget result", err);
				}
			}
			else {
				if (this.highlight) {
					this.highlight.setMode("off");
				}
				if (this.editPopup) {
					this.editPopup.hide();
				}
			}
		},
		
		zoomToDistrict : function(district){
			console.log("go to zoomtodistrict");
			console.log(this.configData);
	       var coords = this.configData.map.fullExtent;
		   
	       var extents = this.configData.map.extents;
		   
		   extents.forEach(dojo.hitch(this,function(extent,idx,arr){
				if(extent.id == district){
					coords = extent.value;
				}		   	
		   }));  	
			console.log(coords);				
			var extent = new esri.geometry.Extent(coords[0], coords[1], coords[2], coords[3], null);
			this.map.setExtent(extent);
		},
		
		onDeletedGraphic : function(evt){
			console.log("onDeleteGraphic");
			console.log(evt);
			if(evt){
				if (this.highlight) {
					this.highlight.setMode("off");
				}
				if (this.editPopup) {
					this.editPopup.hide();
				}
				evt.destroyRecursive();
			}
		}
		
	}
);
