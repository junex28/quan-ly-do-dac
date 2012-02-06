<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Language" content="vi" />
		<title>Hệ thống quản lý Đo đạc và Bản đồ</title>
		<style type="text/css">
			/*
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/2.6/js/dojo/dijit/themes/tundra/tundra.css";
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/2.6/js/dojo/dojo/resources/dojo.css";
			@import "js/com/esri/solutions/jsviewer/themes/darkangel/darkangel.css";
			@import "js/com/esri/solutions/jsviewer/themes/darkangel/override.css";
			@import "jsviewer.css";
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/2.6/js/dojo/dojox/grid/resources/Grid.css";
			@import "http://serverapi.arcgisonline.com/jsapi/arcgis/2.6/js/dojo/dojox/grid/resources/tundraGrid.css";
		    @import "js/com/dijits/identify/css/identify.css";
			*/
			@import "http://127.0.0.1/arcgis_js_api/library/2.6/arcgis/js/dojo/dijit/themes/tundra/tundra.css";
			@import "http://127.0.0.1/arcgis_js_api/library/2.6/arcgis/js/dojo/dojo/resources/dojo.css";
			@import "webgis/js/com/esri/solutions/jsviewer/themes/darkangel/darkangel.css";
			@import "webgis/js/com/esri/solutions/jsviewer/themes/darkangel/override.css";
			@import "webgis/jsviewer.css";
			@import "http://127.0.0.1/arcgis_js_api/library/2.6/arcgis/js/dojo/dojox/grid/resources/Grid.css";
			@import "http://127.0.0.1/arcgis_js_api/library/2.6/arcgis/js/dojo/dojox/grid/resources/tundraGrid.css";
		    @import "webgis/js/com/dijits/identify/css/identify.css";
		</style>
		
		<!-- Fix for PNG transparency with IE6 -->
		<style type="text/css">
			div { behavior: url(iepngfix.htc) }
		</style>
		
		<!-- bootstrap the ArcGIS Server Javascript API -->
		<script type="text/javascript">
		    djConfig = {
		        parseOnLoad: true,
		        baseUrl: './',
		        modulePaths: { 'com.esri.solutions.jsviewer': 'webgis/js/com/esri/solutions/jsviewer', 'dijits.identify': 'webgis/js/com/dijits/identify' },
		        isDebug: true,
		        usePlainJson: true,
		        locale: 'vi'//,				
		        //locale: 'fr'
		    };
		</script>
		<!--<script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=2.6">
		</script>-->
		<script type="text/javascript" src="http://127.0.0.1/arcgis_js_api/library/2.6/arcgis/">
		</script>
		
		<script type="text/javascript" src="webgis/js/com/dijits/identify/libraries/DD_roundies_0.0.2a-min.js">
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
		            dojo.publish("mapResizeRequestEvent", [screen])
		        }
		    };

		    dojo.addOnLoad(onPageResizeHandler);
		</script>
		
	</head>
	<body class="tundra" onresize="onPageResizeHandler()">
		<!-- Markup to create faceless Site Starter manager objects -->
		<div dojoType="com.esri.solutions.jsviewer.ConfigManager"></div>
		<div dojoType="com.esri.solutions.jsviewer.DataManager"></div>
		<div dojoType="com.esri.solutions.jsviewer.MapManager"></div>
		<div dojoType="com.esri.solutions.jsviewer.WidgetManager"></div>
		
		<div id="map">
			<div dojoType="com.esri.solutions.jsviewer.Controller"></div>
			<div dojoType="com.esri.solutions.jsviewer.WidgetContainer"></div>
		</div>
	</body>
</html>
