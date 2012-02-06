<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MapSite.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	WEBGIS
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MapCenter" runat="server">
        <div id="mapViewer" dojotype="dijit.layout.BorderContainer" gutters="false" design="sidebar"
            region="center">
             <div id="mapPanel" class="soria ui-widget ui-widget-content ui-corner-all" dojotype="dijit.layout.ContentPane" region="center">
                             <!--Loanding icon-->
                <img id="loadingImg" src="../../Content/images/loading.gif" style="position: absolute;
                    right: 512px; top: 256px; z-index: 100;visibility: hidden"  />
            </div>
            <div id="leftPanel" dojotype="dijit.layout.TabContainer" region="left" splitter="true"
                tabstrip="true">
                <div id="map-tabs">
	                <ul>
		                <li><a href="#map-tabs-1">Tìm kiếm</a></li>
		                <li><a href="#map-tabs-2">Kết quả</a></li>
		            </ul>
	                <div id="map-tabs-1">
		                <p>Thong Tin.</p>
	                </div>
	                <div id="map-tabs-2">
		                <p>Thong Tin.</p>
	                </div>
	            </div>
            </div>
        </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
   <script type="text/javascript">
       $(function() {
            $(".contentRight").remove();
            $("#map-tabs").tabs();

        });      
    </script>
     
    <link rel="stylesheet" type="text/css" href="../../Content/nmap.css" />
    <link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dijit/themes/soria/soria.css" />
    <script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=2.6"></script>
    <script type="text/javascript">
        dojo.require("esri.map");
        var map;

        function init() {

            map = new esri.Map("mapPanel");
            var basemapURL = "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"
            var basemap = new esri.layers.ArcGISTiledMapServiceLayer(basemapURL);
            map.addLayer(basemap);

        }
        dojo.addOnLoad(init);

    </script>
</asp:Content>
