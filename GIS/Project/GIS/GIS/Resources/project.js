// layout
dojo.require("dijit.dijit"); 
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");

// various Form elements
dojo.require("dijit.form.Button");
dojo.require("dijit.form.CheckBox");

dojo.require("dijit.Toolbar");

dojo.require("esri.toolbars.draw");
dojo.require("esri.map");
dojo.require("esri.tasks.query");
dojo.require("esri.layers.FeatureLayer");

var resizeTimer;
var map;    // main map
var basemap; 
var enableFeatureLayers= [], visible = [];
var toolbar, toolSymbol;

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
        map.graphics.add(graphic);
    }
    /////////////////////////END TOOLBAR/////////////////////////////
    
     dojo.addOnLoad(init);

     ///////////////////// IDENTIFY /////////////////////////

        /*
     // Build query task
     var queryClickTask, queryClick;
     var symbolClick, infoClickTemplate;

     function queryClickIdentityInit() {
               
        //Listen for click event on the map, when the user clicks on the map call executeQueryTask function.
        dojo.connect(map, "onClick", executeQueryClickTask);
        //Listent for infoWindow onHide event
        dojo.connect(map.infoWindow, "onHide", function() { map.graphics.clear(); });

        queryClickTask = new esri.tasks.QueryTask("http://localhost/ArcGIS/rest/services/Moc/MapServer/0");


        //build query filter
        
        queryClick = new esri.tasks.Query();
        queryClick.outSpatialReference = { "wkid": 4756 };        
        queryClick.returnGeometry = true;
        //queryClick.outFields = ["LOAIMOC","SOHIEU", "CAPHANG", "HEQUYCHIEU", "NAMTHANHLAP", "TINHTRANG"];
        queryClick.outFields = [];
     }


     function executeQueryClickTask(evt) {
         map.infoWindow.hide();
         map.graphics.clear();
         featureSet = null;

         //onClick event returns the evt point where the user clicked on the map.
         //This is contains the mapPoint (esri.geometry.point) and the screenPoint (pixel xy where the user clicked).
         //set query geometry = to evt.mapPoint Geometry
         queryClick.geometry = evt.mapPoint;
          
         //Execute task and call showResults on completion
         queryClickTask.execute(queryClick, function(fset) {
             alert(dojo.toJson(fset.features));
             if (fset.features.length === 1) {
                 showFeature(fset.features[0], evt);
             } else if (fset.features.length !== 0) {
                 showFeatureSet(fset, evt);
             }
         });
     }

     function showFeature(feature, evt) {
         map.graphics.clear();

         alert("ok yeah");   
         //set symbol
         var symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_NULL, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));

         feature.setSymbol(symbol);

         //construct infowindow title and content
         var attr = feature.attributes;
//         var title = attr.FIELD_NAME;
//         var content = "Field ID : " + attr.FIELD_KID
//                    + "<br />Produces Gas : " + attr.PROD_GAS
//                    + "<br />Produces Oil : " + attr.PROD_OIL
//                    + "<br />Status : " + attr.STATUS;

         var title = "title here";
         var content = "Content here";
         map.graphics.add(feature);

         map.infoWindow.setTitle(title);
         map.infoWindow.setContent(content);

         (evt) ? map.infoWindow.show(evt.screenPoint, map.getInfoWindowAnchor(evt.screenPoint)) : null;
     }*/
     /*

     function showFeatureSet(fset, evt) {
         //remove all graphics on the maps graphics layer
         map.graphics.clear();
         var screenPoint = evt.screenPoint;

         featureSet = fset;

         var numFeatures = featureSet.features.length;

         //QueryTask returns a featureSet.  Loop through features in the featureSet and add them to the infowindow.
         var title = "You have selected " + numFeatures + " fields.";
         var content = "Please select desired field from the list below.<br />";

         for (var i = 0; i < numFeatures; i++) {
             var graphic = featureSet.features[i];
             content = content + " Field (<A href='#' onclick='showFeature(featureSet.features[" + i + "]);'>show</A>)<br/>";
         }

         map.infoWindow.setTitle(title);
         map.infoWindow.setContent(content);
         map.infoWindow.show(screenPoint, map.getInfoWindowAnchor(evt.screenPoint));
     }
     */
     // Load multiple list layer
     /*
     function loadFeatureLayers() {
     defLayers = esri.layers.ArcGISDynamicMapServiceLayer(appConfig.service.layerServices.url); 

        if (defLayers.loaded) {
     buildLayerList(defLayers);
     }
     else {
     dojo.connect(defLayers, "onLoad", buildLayerList);
     }
     }

     function buildLayerList(defLayers) {
     var featureLayer;
     dojo.forEach(defLayers.layerInfos, function(defLayer) {
     if (dojo.indexOf(appConfig.service.layerServices.enableLayers, defLayer.id) > -1) {
     var url = appConfig.service.featureLayers[defLayer.id].url;
     //var mode = appConfig.service.featureLayers[defLayer.id].mode;
     //var outFields ;
     //dojo.foreach(appConfig.service.featureLayers[defLayer.id].outFields, function(field) { outFields += "[" + field + "]"; });
     var templateTitle = appConfig.service.featureLayers[defLayer.id].infoTemplate.title;
     var templateContent = appConfig.service.featureLayers[defLayer.id].infoTemplate.content;
     var infoTemplate = new esri.InfoTemplate(templateTitle, templateContent);

                 featureLayer = new esri.layers.FeatureLayer(url, { mode: esri.layers.FeatureLayer.MODE_ONDEMAND, outFields: ["*"], infoTemplate: infoTemplate });
     //                 featureLayer = new esri.layers.FeatureLayer("http://localhost/ArcGIS/rest/services/Moc/MapServer/0",
     //                 { mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
     //                    outFields: ["*"], 
     //                    infoTemplate: infoTemplate });
                 
     map.addLayer(featureLayer);
     map.infoWindow.resize(150, 105);
     enableFeatureLayers.push(featureLayer);
     }

         });
         
     // Get list layer enable in config and set visible on default    
     //         var items = dojo.map(layer.layerInfos, function(info, index) {
     //             if (appConfig.Services.mocMapService.enableLayer.indexOf(index)) {
     //                 if (info.defaultVisibility) {
     //                     visible.push(info.id);
     //                 }
     //                 return "<input type='checkbox' dojotype='dijit.form.CheckBox' class='list_item' checked='" + (info.defaultVisibility ? "checked" : "") + "' id='" + info.id + "' onclick='updateLayerVisibility();' />" + "<label for='" + info.id + "'>" + info.name + "</label> <br/>";

//             }
     //             return "";
     //         });

//        dojo.forEach(items, function(item) {
     //            if (appConfig.Services.mocMapService.enableLayer.indexOf(item.id)) {
     //                dojo.byId("layer_list").innerHTML += item;
     //            }
     //        }
     //        ); 
     //        
     //        layers.setVisibleLayers(visible);
     //        map.addLayer(layers);

      } */

     /*function updateLayerVisibility() {
     var inputs = dojo.query(".list_item"), input;
       
     visible = [];

            dojo.forEach(inputs,function(input){
     if (input.checked) {
     visible.push(input.id);
     }
     });
     //if there aren't any layers visible set the array to be -1
     if(visible.length === 0){
     visible.push(-1);
     }
     layers.setVisibleLayers(visible);
     }*/

     ///////////////////////// END IDENTITY ////////////////////////////////////
     
