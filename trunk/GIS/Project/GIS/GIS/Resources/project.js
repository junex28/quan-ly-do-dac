dojo.require("esri.map");

// layout
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");

// various Form elements
dojo.require("dijit.form.Button");
dojo.require("dijit.form.CheckBox");

dojo.require("dijit.Toolbar");


function init() {
         //svar initExtent = new esri.geometry.Extent({ "xmin": 5.049902, "ymin": 10.819129611, "xmax": 5.514951094, "ymax": 10.716265511, "spatialReference": { "wkid": 3406} });
    // map = new esri.Map("mapPanel", { extent: initExtent });
    map = new esri.Map("mapPanel");
    loadBaseMap();
    
     }

     function loadBaseMap() {
         var basemapURL = "http://localhost/ArcGIS/rest/services/final/MapServer"
         var basemap = new esri.layers.ArcGISTiledMapServiceLayer(basemapURL);
         map.addLayer(basemap);

        // Load Moc
         var mocURL = 'http://localhost/ArcGIS/rest/services/Moc/MapServer';
         var moc = new esri.layers.ArcGISDynamicMapServiceLayer(mocURL, {opacity:0.5});
         map.addLayer(moc);
         resizeBrowser();
     
     }
     
     function resizeBrowser() {
         dojo.connect(map, 'onLoad', function(theMap) {
             //resize the map when the browser resizes
             dojo.connect(dijit.byId('map'), 'resize', map, map.resize);
         });
     }

//     function resizeLeftPanel() {
//         dojo.connect(map, 'onLoad', function(theMap) {
//             //resize the map when the browser resizes
//             dojo.connect(dijit.byId('map'), 'resize', map, map.resize);
//         });
//     }
//        
dojo.addOnLoad(init);