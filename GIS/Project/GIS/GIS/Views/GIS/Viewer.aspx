<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MapSite.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	GIS 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

		<div dojoType="com.esri.solutions.jsviewer.ConfigManager"></div>
		<div dojoType="com.esri.solutions.jsviewer.DataManager"></div>
		<div dojoType="com.esri.solutions.jsviewer.MapManager"></div>
		<div dojoType="com.esri.solutions.jsviewer.WidgetManager"></div>
		
		<div id="map">
			<div dojoType="com.esri.solutions.jsviewer.Controller"></div>
			<div dojoType="com.esri.solutions.jsviewer.WidgetContainer"></div>
		</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
		<style type="text/css">
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/1.4/js/dojo/dijit/themes/tundra/tundra.css";
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/1.4/js/dojo/dojo/resources/dojo.css";
			@import "/Scripts/com/esri/solutions/jsviewer/themes/darkangel/darkangel.css";
			@import "/Scripts/com/esri/solutions/jsviewer/themes/darkangel/override.css";
			@import "/Content/jsviewer.css";
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/1.4/js/dojo/dojox/grid/resources/Grid.css";
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/1.4/js/dojo/dojox/grid/resources/tundraGrid.css";
		    @import "/Scripts/com/dijits/identify/css/identify.css";
		</style>
		
		<!-- Fix for PNG transparency with IE6 -->
		<style type="text/css">
			div { behavior: url(iepngfix.htc) }
		</style>
		
		<!-- bootstrap the ArcGIS Server Javascript API -->
		<script type="text/javascript">
			djConfig = {
				parseOnLoad: true,
				baseUrl:'./',
				modulePaths:{'com.esri.solutions.jsviewer':'/Scripts/com/esri/solutions/jsviewer', 'dijits.identify': '/Scripts/com/dijits/identify'},
				isDebug: false,
				usePlainJson: true//,
				//locale: 'fr'
			};
		</script>
		<script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=1.4">
		</script>
		<script type="text/javascript" src="/Scripts/com/dijits/identify/libraries/DD_roundies_0.0.2a-min.js">
		</script>
		
		<script type="text/javascript">
			dojo.require("dojo.parser");
			
			dojo.require("esri.map");
			esriConfig.defaults.io.proxyUrl = "proxy.ashx";
			
			// Site Starter classes
			dojo.require("com.esri.solutions.jsviewer.WidgetContainer");
			dojo.require("com.esri.solutions.jsviewer.Controller");
			dojo.require("com.esri.solutions.jsviewer.ConfigManager");
			dojo.require("com.esri.solutions.jsviewer.DataManager");
			dojo.require("com.esri.solutions.jsviewer.MapManager");
			dojo.require("com.esri.solutions.jsviewer.WidgetManager");
			dojo.require("com.esri.solutions.jsviewer.util");
			
			function onPageResizeHandler() {
				// Comment out these lines, and the onresize on body
				// if you don't want full-screen
				if (com.esri.solutions.jsviewer.util) {
				    var screen = com.esri.solutions.jsviewer.util.pageBox();
				    // remove the height of the banner 52px + 2 px for margin 
				    screen.h = screen.h - 54; 
					dojo.publish("mapResizeRequestEvent", [screen])
				}
			};
			
			dojo.addOnLoad(onPageResizeHandler);
		</script>
</asp:Content>
