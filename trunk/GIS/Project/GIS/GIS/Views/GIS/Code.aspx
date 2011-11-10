<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=7, IE=9" />
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="fragment" content="!" />
    <title> WEB GIS</title>
    <script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=2.5"></script>
    <link href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dijit/themes/soria/soria.css" rel="stylesheet" type="text/css" />    
    <link rel="stylesheet" type="text/css" href="../../Content/map.css" />

    <script type="text/javascript">
        dojo.require("esri.map");
        var map;
        function init() {
            map = new esri.Map("mapDiv");
            /* Cached map */
            var basemapURL = "http://localhost/ArcGIS/rest/services/tilebando/MapServer"
            var basemap = new esri.layers.ArcGISTiledMapServiceLayer(basemapURL);
            map.addLayer(basemap);
           
            
            /*
           var basemapURL = "http://localhost/ArcGIS/rest/services/bando/MapServer";
           // var basemapURL = "http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Population_World/MapServer";
            var imageParameters = new esri.layers.ImageParameters();
            imageParameters.format = "jpeg";  //set the image type to PNG24, note default is PNG8.
            //Takes a URL to a non cached map service.
            var dynamicMapServiceLayer = new esri.layers.ArcGISDynamicMapServiceLayer
            (basemapURL, { "opacity": 0.5, "imageParameters": imageParameters });
            map.addLayer(dynamicMapServiceLayer);
            */
        }
        dojo.addOnLoad(init);

    </script>

    <style type="text/css">
      html, body {
        height: 100%;
        width: 100%;
        margin: 0;
        padding: 0;
        overflow: hidden;
      }
      
      body #page-border {
        min-width: 1050px;
        overflow: hidden;
      }
      
      #appLayout {
        height: 100%;
        }
        
    #leftCol {
        width: 14em;
    }
</style>
</head>

<body class="soria">
    <div id="mapDiv" style="width:900px; height:600px; border:1px solid #000;"></div> 
</body>
</html>
 
 