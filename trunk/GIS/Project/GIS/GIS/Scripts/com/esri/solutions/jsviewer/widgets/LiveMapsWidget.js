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

dojo.provide("com.esri.solutions.jsviewer.widgets.LiveMapsWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "LiveMapsWidgetStrings");

// for GUI purposes
dojo.require("dijit.Tree");
dojo.require("dijit.layout.ContentPane");
dojo.require("dojo.data.ItemFileReadStore");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dijit.form.Button");
dojo.require("dijit.form.Slider");


dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.LiveMapsWidget",
	[com.esri.solutions.jsviewer._BaseWidget],
	{
	    constructor: function(/*Object*/ params) {
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/LiveMapsWidget.html"),
		
		_initialized: false,
		
		tree: null,
		treeStore: null,
		
		i18nStrings: null,
		
		postMixInProperties: function() {
		    try {
				this.inherited(arguments);
	
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "LiveMapsWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
		    this.inherited(arguments);
		    dojo.parser.parse(this.domNode);
		},
		
		startup: function() {
			this.inherited(arguments);
			this.getAllNamedChildDijits();
			
			// Populate the TOC tree ----------------------------------------
		    var treeDiv = document.createElement("div");
		    //can reference "tocPanel" directly as we applied a dojoAttachpoint to this Div element
		    this.tocPanel.appendChild(treeDiv);
			
			//empty data store structure
			//var argData = {items: [ ], identifier: "id", label: "name"};
			this.treeStore = new dojo.data.ItemFileWriteStore({
			    data: this.getLiveLayers()
			});
			
			//parent node for TOC will be invisible if using forestStoreModel and setting showRoot=false in the tree
			//var parentNode = this.treestore.newItem({id: "1", name:"services", type: "services"});	
			
			var model = new dijit.tree.ForestStoreModel({
                                store: this.treeStore,
                                childrenAttr: "children" });

			this.tree = new dijit.Tree({
			    id:'TOC', 
			    model: model, 
			    showRoot: false,
				getIconClass: dojo.hitch(this, "getIconClass")
			}, treeDiv);
			
			this.tree.onClick = dojo.hitch(this, "treeClickHandler");
			this.tree.startup();
			
			// Populate the list of visibility sliders ----------------------------------
			this.createVisibilitySliders();
		},
		
		shutdown: function() {
			this.tree.destroyRecursive();
			this.tree = null;
			this.destroyVisibilitySliders();
		    this.inherited(arguments);
		},
		
		createVisibilitySliders: function() {
		    for (var i = this.map.layerIds.length - 1; i >= 0; i--) {
				var layerId = this.map.layerIds[i];
				var layer = this.map.getLayer(layerId);
				
				if (layer && layer.layerCategory && layer.layerCategory === "LIVE") {
					var opacityValue = Math.round(layer.opacity * 100);
					
					// Create label div
					var labelDiv = document.createElement("div");
					dojo.style(labelDiv, "margin", "8px 0 5px 0");
					labelDiv.innerHTML = layerId + " - " + opacityValue + "%";
					this.visibilityPanel.appendChild(labelDiv);
					
					// Create slider
					var sliderDiv = document.createElement("div");
					this.visibilityPanel.appendChild(sliderDiv);
					var slider = new dijit.form.HorizontalSlider({
						value: opacityValue,
						maximum: 100,
						minimum: 0,
						showButtons: false,
						pageIncrement: 10,
						style: "width:90%"
					}, sliderDiv);
					
					// Connect up the event handler
					(dojo.hitch(this, function() {
						var closureLayer = layer;
						var closureDiv = labelDiv;
						this.connects.push(dojo.connect(slider, "onChange", function(newValue) {
							newValue = Math.round(newValue);
							closureDiv.innerHTML = closureLayer.id + " - " + newValue + "%";
							closureLayer.setOpacity(newValue / 100);
						}));
					}))();
				}
			}
		},
		
		destroyVisibilitySliders: function() {
			var nodeList = dojo.query("*", this.visibilityPanel);
			nodeList.forEach(function(x) {
				var d = dijit.byId(x);
				if (d && d.destroyRecursive) {
					d.destroyRecursive();
				}
				else {
					x.parentNode.removeChild(x);
				}
			});
		},
		
		getLiveLayers: function() {
		    var data = {
		        identifier: "id",
		        label: "name",
		        items: []
		    };
		         
		    for(var i = this.map.layerIds.length - 1; i >= 0; i--){
				var layerId = this.map.layerIds[i];
		        var layer = this.map.getLayer(layerId);
		        
		        if(layer && layer.layerCategory && layer.layerCategory === "LIVE") {
		            var isTiled = layer.hasOwnProperty('tileInfo');
		            
		            var layerItem = {
		                id: layerId,
		                name: layerId,
		                style: "tocLayer",
		                visibleSubLayerIds: [],
		                children: []
		            };
					
		            //get layer information for each service layer
		            var layerInfos = layer.layerInfos;
		            for(var j = 0; j < layerInfos.length; j++){
		                
		                var info = layerInfos[j];
		                var id = info.id;
		                var name = info.name;
		                var parentId = info.parentLayerId;
				
		                if(info.defaultVisibility){
		                    layerItem.visibleSubLayerIds.push(id);
		                }
		                
						var tclass = (isTiled) ? "tocTiledSubLayer" : "tocDynamicSubLayer";
		                if(parentId == -1){
		                    var sublayeritem = {
		                        id: layerId + "." + id,
		                        name: name,
		                        subId: id,
		                        rootLayerId: layerId,
		                        style: tclass,
		                        parentId: parentId,
		                        children: []
		                    };
		                    layerItem.children.push(sublayeritem);    
		                }
		                else{
		                    //find parent item in the children
		                    var parentitem = this.findParentDataItem(layerItem.children, parentId);
		                    var subLayerItem = {
		                        id: parentId + "." + id,
		                        name: name,
		                        subId: id,
		                        rootLayerId: layerId,
		                        style: tclass,
		                        parentId: parentId,
		                        children: []
		                    };
		                    parentitem.children.push(subLayerItem);
		                }
		            }
		            
		            data.items.push(layerItem);
		        }      
		    }
		    return data;
		},
		
		findParentDataItem: function(sublayerArray, parentId){
		    if (sublayerArray && dojo.isArray(sublayerArray)) {
			    for (var i = 0; i < sublayerArray.length; i++) {
				    var subLayer = sublayerArray[i];
				    if (subLayer.children.length > 0) {
					    var result = this.findParentDataItem(subLayer.children, parentId);
					    if (result) {
							return result;
						}
				    }
				    if (subLayer.subId == parentId) {
						return subLayer;
					}
			    }
		    }
		    return null;
	    },
	
		treeClickHandler: function(item, node, event){
			if (item !== null) {
			
				var style = this.treeStore.getValue(item, "style");
				
				if (style == 'tocLayer') {
					dojo.removeClass(node.iconNode, this.getIconClass(item));
					
					var layerId = this.treeStore.getValue(item, 'id');
					var layer = this.map.getLayer(layerId);
					
					if (layer.visible) {
						layer.hide();
					}
					else {
						layer.show();
					}
					
					dojo.addClass(node.iconNode, this.getIconClass(item));
				}
				
				else 
					if (style == 'tocDynamicSubLayer') {
						dojo.removeClass(node.iconNode, this.getIconClass(item));
						
						var subId = this.treeStore.getValue(item, 'subId');
						var rootLayerId = item.rootLayerId[0];
						var rootLayer = this.map.getLayer(rootLayerId);
						
						//var visibleLayers = rootLayer.
						var rootItem = this.treeStore._getItemByIdentity(rootLayerId);
						
						if (rootItem.visibleSubLayerIds !== null) {
							var idIdx = dojo.indexOf(rootItem.visibleSubLayerIds, subId);
							if (idIdx >= 0) {
								rootItem.visibleSubLayerIds.splice(idIdx, 1);
							}
							else {
								rootItem.visibleSubLayerIds.push(subId);
							}
							
							// Need to turn this list (which includes group layers) into
							// a flat list of which non-group layers are visible.
							// This appears to be a strangeness of the JS API at 1.1
							var visLayers = this.processVisibleLayers(rootLayer, rootItem.visibleSubLayerIds);
							
							rootLayer.setVisibleLayers(visLayers);
						}
						
						dojo.addClass(node.iconNode, this.getIconClass(item));
					}
			}
		},
	    
		processVisibleLayers: function(dynLayer, visibilityList) {
			var visLayers = [];
			
			// Special case: an array with -1 in it for no layers visible
			if (visibilityList.length == 1 && visibilityList[0] == -1) {
				return visibilityList;
			}
			
			// Sort ids
			visibilityList.sort(function(a,b){
				return a - b;
			});
			
			if (dynLayer && dynLayer.layerInfos) {
				var visGroups = [];
				dojo.forEach(dynLayer.layerInfos, function(info) {
					var bIsGroup = (dojo.isArray(info.subLayerIds) && info.subLayerIds.length > 0);
					var bParentIsVisible = (info.parentLayerId === -1) || (dojo.indexOf(visGroups, info.parentLayerId) >= 0);
					
					// Keep track of visible groups
					if (bIsGroup) {
						if (bParentIsVisible && dojo.indexOf(visibilityList, info.id) >= 0) {
							visGroups.push(info.id);
						}
					}
					else {
						if (bParentIsVisible && dojo.indexOf(visibilityList, info.id) >= 0) {
							// include if not a group layer and is in visibilityList
							visLayers.push(info.id);
						}
					}
				});
			}
				
			// Special case: an array with -1 in it for no layers visible
			if (visLayers.length === 0) {
				visLayers.push(-1);
			}
			return visLayers;
		},
		
	    getIconClass: function(item, opened){
		    var iconClass = "tocLayerIcon";
		    if (item) {
			    if (item.style) {
				    if (item.style == "tocLayer") {
					    var theLayer = this.map.getLayer(item.id);
					    if (theLayer) {
						    iconClass = (theLayer.visible) ? "tocLayerCheckedIcon" : "tocLayerUncheckedIcon";
					    }
				    }
				    else 
					    if (item.style == "tocDynamicSubLayer") {
						   
						    var subId = this.treeStore.getValue(item, "subId");
						    var rootLayerId = item.rootLayerId[0];
						    var rootItem = this.treeStore._getItemByIdentity(rootLayerId);
    						
						    if (rootItem.visibleSubLayerIds !== null) {
							    iconClass = (dojo.indexOf(rootItem.visibleSubLayerIds, subId) >= 0) ? "tocLayerCheckedIcon" : "tocLayerUncheckedIcon";
						    }
					    }
			    }
		    }
    		
		    return iconClass;
	    }
	}
);