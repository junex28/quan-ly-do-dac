// layout
dojo.require("dijit.dijit"); 
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");

// various Form elements
dojo.require("dijit.form.Button");
dojo.require("dijit.form.CheckBox");
dojo.require("dijit.Toolbar");
dojo.require("dijit.Tree");
dojo.require("dijit.Menu");
dojo.require("dijit.MenuItem");
dojo.require("dijit.Toolbar");
dojo.require("dojo.data.ItemFileReadStore");

dojo.require("esri.toolbars.draw");
dojo.require("esri.map");
dojo.require("esri.tasks.query");
dojo.require("esri.layers.FeatureLayer");
dojo.require("esri.tasks.geometry");

var resizeTimer;
var map;    // main map
var basemap; 
var enableFeatureLayers= [], visible = [];
var toolbar, toolSymbol;
var result;
var queryGraphics = [];

    // Initialiazation
    function init() {
        var initExtent = new esri.geometry.Extent({ "xmin": appConfig.service.initialExtent.xmin, "ymin": appConfig.service.initialExtent.ymin, "xmax": appConfig.service.initialExtent.xmax, "ymax": appConfig.service.initialExtent.ymax, "spatialReference": { "wkid": appConfig.service.initialExtent.spatialReference.wkid} });
        map = new esri.Map("mapPanel", { extent: initExtent });
        
        loadBaseMap();
        
        dojo.connect(map, "onLoad", loadFeatureLayers);
        dojo.connect(map, "onLoad", createToolbar); 
        
        dojo.connect(map, 'onLoad', function(map) {
                // MAP RESIZE EVENT
                //dojo.connect(dijit.byId("mapPanel"), "resize", resizeBrowser);
            dojo.connect(dijit.byId('mapPanel'), 'resize', map, map.resize);
        });

     }

     function loadBaseMap() {
         
         basemap = new esri.layers.ArcGISTiledMapServiceLayer(appConfig.service.baseMapService.url);
         map.addLayer(basemap);
         map.infoWindow.resize(appConfig.service.infoWindow.width, appConfig.service.infoWindow.height);
     
     }

     //////////////////// LOAD FEATURE LAYER ////////////////////////
     function loadFeatureLayers() { 
            var featureLayer;
            var i = 0;      
         // Add Info Window to Feature Layer
            dojo.forEach(appConfig.service.layerServices.enableLayers, function(id) {
                var url = appConfig.service.featureLayers[id].url;
                var mode = appConfig.service.featureLayers[id].mode;
                //var outFields ;
                //dojo.foreach(appConfig.service.featureLayers[defLayer.id].outFields, function(field) { outFields += "[" + field + "]"; });
                var templateTitle = appConfig.service.featureLayers[id].infoTemplate.title;
                var templateContent = appConfig.service.featureLayers[id].infoTemplate.content;
                var infoTemplate = new esri.InfoTemplate(appConfig.service.featureLayers[id].infoTemplate);
                // init symbol
                var symbol = new esri.symbol.PictureMarkerSymbol(appConfig.service.featureLayers[id].symbol.url, appConfig.service.featureLayers[id].symbol.width, appConfig.service.featureLayers[id].symbol.height);
                featureLayer = new esri.layers.FeatureLayer(url, { mode: mode, outFields: ["*"], infoTemplate: infoTemplate });
                featureLayer.setRenderer(new esri.renderer.SimpleRenderer(symbol));
                map.addLayer(featureLayer);
                enableFeatureLayers.push(featureLayer);

                // All layer hide when initilized
                enableFeatureLayers[i].hide();
                // Initialize GUI checkbox
                dojo.place("<br/><input type='checkbox' dojotype='dijit.form.Checkbox' class='list_item' id='" + i + "' onClick='updateLayerVisibility(" + i + ");' /><label for='" + i + "'> " + appConfig.service.featureLayers[id].title + "</label>", "layer_list", "last");

                i++;
            });
    }

    
    function updateLayerVisibility(layerIndex) {
        var inputs = dojo.query(".list_item"), input;

        visible = [];

        dojo.forEach(inputs, function(input) {
            if (input.checked) {
                visible.push(input.id);
            }
        });
        //if there aren't any layers visible set the array to be -1
        if (visible.length === 0) {
            visible.push(-1);
        }
        
        (enableFeatureLayers[layerIndex].visible) ? enableFeatureLayers[layerIndex].hide() : enableFeatureLayers[layerIndex].show();
    }

    //////////////////// END LOAD FEATURE LAYER ////////////////////////

    //////////////////////////TOOLBAR/////////////////////////////////

    function createToolbar(themap) {
        toolbar = new esri.toolbars.Draw(map);
        dojo.connect(toolbar, "onDrawEnd", addToMap);
    }

    function addToMap(geometry) {
        toolbar.deactivate();
        map.showZoomSlider();
        switch (geometry.type) {
            case "point":
                var toolSymbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE, 10, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255, 0, 0]), 1), new dojo.Color([0, 255, 0, 0.25]));
                break;
            case "polyline":
                var toolSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASH, new dojo.Color([255, 0, 0]), 1);
                break;
            case "polygon":
                var toolSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
                break;
            case "extent":
                var toolSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
                break;
            case "multipoint":
                var toolSymbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_DIAMOND, 20, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0, 0, 0]), 1), new dojo.Color([255, 255, 0, 0.5]));
                break;
        }
        var graphic = new esri.Graphic(geometry, toolSymbol);
        queryGraphics.push(graphic);
        map.graphics.add(graphic);

        selectFeature();
        //todo: begin query task here
    }
            
    /////////////////////////END TOOLBAR/////////////////////////////

    ////////////////////////TREE VIEW RESULT ///////////////////////

    function createTree() {
        result = {
            label: 'name',
            identifier: 'sohieu',
            items: [
            { name: 'Mốc toạ độ', sohieu: '0', type: 'directory', children: [
            { type: 'kq', name: 'XAZ', sohieu: 'XAZ', tinhtrang: 'con tot', year: '1996' },
            { type: 'kq', name: 'XBZ', sohieu: 'XBZ', tinhtrang: 'con tot', year: '2000' }
            ]
            },
            { name: 'Mốc độ cao', sohieu: '1', 'children': [
            { type: 'kq', name: 'YAZ', sohieu: 'YAZ', tinhtrang: 'con tot', year: '1996' },
            { type: 'kq', name: 'YBZ', sohieu: 'YBZ', tinhtrang: 'con tot', year: '2000' }
            ]}]
            }

            var store = new dojo.data.ItemFileReadStore({
                id: "treeStore",
                data: result
            });

            var treeModel = new dijit.tree.ForestStoreModel({
                id: "treeModel",
                store: store
            });

            var tree = new dijit.Tree({
                id: "resultTree",
                model: treeModel,
                showRoot: false,
                onClick: function(item, node, evt) {
                    if (store.getValue(item, 'type') == 'kq') {
                        //                    var grid = dijit.byId('resDetailTable');                    
                        //                    grid.setStore(store);
                        //add info in thong tin table
                        var data = store.getAttributes(item);
                        alert(treeModel.getIdentity(item));
                    }
                },
                _createTreeNode: function(
                args) {
                    var tnode = new dijit._TreeNode(args);
                    tnode.labelNode.innerHTML = args.label;
                    return tnode;
                }
            },
        "resultDiv");
        }

        //////////////////////////QUERY TASK /////////////////////////////

        var queryTask, query;
        function selectFeature() {
            var token = "7fmuCGAyVpoegLNpUF8JrLGH5_UBZQu-Ixjid4uJAOsQF0HpP3AEegdP8z18RHI9";
            
            queryTask = new esri.tasks.QueryTask("http://localhost/ArcGIS/rest/services/Moc/MapServer/0");

            query = new esri.tasks.Query();
            //query.text = "1";
            query.spatialRelationship = esri.tasks.Query.SPATIAL_REL_INTERSECTS;
            //queryGraphics[0].spatialReference = { "wkid": 4756 };
            query.geometry = queryGraphics[0].geometry;            
            query.outSpatialReference = {"wkid": 4756};
            query.returnGeometry = true;
            query.outFields = ['*'];

            queryTask.execute(query, showResults);
                                   
            dojo.connect(queryTask, "onComplete", function(fset) {
                var symbol = new esri.symbol.SimpleMarkerSymbol();
                symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE;
                symbol.setSize(8);
                symbol.setColor(new dojo.Color([255, 255, 0, 0.5]));

                var infoTemplate = new esri.InfoTemplate("title", "${*}");

                var resultFeatures = fset.features;
                for (var i = 0, il = resultFeatures.length; i < il; i++) {
                    var graphic = resultFeatures[i];
                    graphic.setSymbol(symbol);
                    graphic.setInfoTemplate(infoTemplate);
                    map.graphics.add(graphic);
                }
            });
            // Query
            
//            query.geometry = esri.geometry.webMercatorToGeographic(queryGraphics[0]);
//            query.outSpatialReference = appConfig.service.initialExtent.spatialReference.wkid;
//            try {
//                queryTask.execute(query);
//            } catch (err) {
//            alert(err);
//            }
            dojo.byId('debug').innerHTML = "<b>Executing Query with Result Buffer Geometry...</b>";
//

        }

        function showResults(results) {
            var s = "";
            alert("sdf");
            for (var i = 0, il = results.features.length; i < il; i++) {
                var featureAttributes = results.features[i].attributes;
                for (att in featureAttributes) {
                    s = s + "<b>" + att + ":</b>  " + featureAttributes[att] + "<br />";
                }
            }
            dojo.byId("debug").innerHTML = s;
        }
        //////////////////////////END QUERY TASK /////////////////////////////
    
        
    //////////////////// END TREE RESULT //////////////////////////
        dojo.addOnLoad(init);
        dojo.addOnLoad(createTree);

     ///////////////////// IDENTIFY ///////////////////keejchayj 