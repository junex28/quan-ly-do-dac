dojo.require("esri.map");

// layout
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");

// various Form elements
dojo.require("dijit.form.Button");
dojo.require("dijit.form.CheckBox");

dojo.require("dijit.Toolbar");

var map;    // main map
var basemap; 
var layers, visible = [];

    // Initialiazation
    function init() {
        //var initExtent = new esri.geometry.Extent({ "xmin": 5.049902, "ymin": 10.819129611, "xmax": 5.514951094, "ymax": 10.716265511, "spatialReference": { "wkid": 3406} });
        // map = new esri.Map("mapPanel", { extent: initExtent });
        map = new esri.Map("mapPanel");
        loadBaseMap();
        loadLayers();
        resizeBrowser();    
     }

     function loadBaseMap() {
         basemap = new esri.layers.ArcGISTiledMapServiceLayer(appConfig.Services.baseMapService.url);
         map.addLayer(basemap);
     
     }
     
     // Load multiple list layer
     function loadLayers(){
        layers = new esri.layers.ArcGISDynamicMapServiceLayer("http://localhost/ArcGIS/rest/services/Moc/MapServer");

        if (layer.loaded) {
          buildLayerList(layer);
        }
        else {
          dojo.connect(layer, "onLoad", buildLayerList);
        }
     }
     
     function buildLayerList(layer) {
        var items = dojo.map(layer.layerInfos,function(info,index){
          if (info.defaultVisibility) {
            visible.push(info.id);
          }
          return "<input type='checkbox' dojotype='dijit.form.CheckBox' class='list_item' checked='" + (info.defaultVisibility ? "checked" : "") + "' id='" + info.id + "' onclick='updateLayerVisibility();' />" + "<label for='" + info.id + "'>" + info.name + "</label>";
        });

        dojo.byId("layer_list").innerHTML = items.join();

        layer.setVisibleLayers(visible);
        map.addLayer(layer);

      }
     
      function updateLayerVisibility() {
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
            layer.setVisibleLayers(visible);
          }
     //End laod multiple layer 
     
     function resizeBrowser() {
         dojo.connect(map, 'onLoad', function(theMap) {
             //resize the map when the browser resizes
             dojo.connect(dijit.byId('map'), 'resize', map, map.resize);
         });
     }

//     function addLayer(visible) {
//         if (moctoado) {
//             if (visible) {
//                 moctoado.show();
//             } else {
//             moctoado.hide();
//             }
//         } else { 
//                var mocURL = 'http://localhost/ArcGIS/rest/services/Moc/MapServer';
//                moctoado = new esri.layers.ArcGISDynamicMapServiceLayer(mocURL, {id:"moctoado", visible:visible, opacity: 0.5 });

//                var loadHandler = function() {
//                    map.addLayer(moctoado);
//                }

//                if (moctoado.loaded) {
//                    loadHandler();
//                }
//                                
//                else {
//                    dojo.connect(moctoado, "onLoad", loadHandler);
//                }
//             
//         }
//         
//     }
       
dojo.addOnLoad(init);