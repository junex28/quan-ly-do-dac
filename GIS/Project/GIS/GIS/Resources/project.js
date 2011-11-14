dojo.require("esri.map");
dojo.require("esri.layers.KMLLayer");

dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("dijit.form.Button");
dojo.require("dijit.Toolbar");


function init() {
    var map;
         var initExtent = new esri.geometry.Extent({ "xmin": 5.049902, "ymin": 10.819129611, "xmax": 5.514951094, "ymax": 10.716265511, "spatialReference": { "wkid": 3406} });
         map = new esri.Map("mapPanel", { extent: initExtent });
         /* Cached map */
         var basemapURL = "http://localhost/ArcGIS/rest/services/final/MapServer"
         var basemap = new esri.layers.ArcGISTiledMapServiceLayer(basemapURL);
         map.addLayer(basemap);


         var kmlUrl = 'http://ntt-pc/ArcGIS/kml/moc.kmz';
         var kml = new esri.layers.KMLLayer(kmlUrl);
         map.addLayer(kml);
     }
     
          
dojo.addOnLoad(init);