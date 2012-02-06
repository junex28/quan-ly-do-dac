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

dojo.provide("com.esri.solutions.jsviewer.ConfigManager");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");

dojo.declare("com.esri.solutions.jsviewer.ConfigManager",
	[dijit._Widget, dijit._Templated],
	{
		templateString: "<div style='display: none;'></div>",
		configData: null,
		
		// Grab functions from util. Just for conciseness.
		getAttribute: com.esri.solutions.jsviewer.util.xml.getAttribute,
		getValue: com.esri.solutions.jsviewer.util.xml.getValue,
		getNodes: com.esri.solutions.jsviewer.util.xml.getNodes,
		
		postMixInProperties: function() {
			//console.log("ConfigManager postMixInProperties");
		},
		
		postCreate: function() {
			//console.log("ConfigManager postCreate");
		},
		
		startup: function() {
			//console.log("ConfigManager startup");
			this.configLoad();
		},
		
		configLoad: function() {
			var params = {
				url: "config.xml",
				handleAs: "xml",
				load: dojo.hitch(this, "onLoad"),
				error: dojo.hitch(this, "onError"),
				sync: true
			};
			dojo.xhrGet(params);
		},
		
		onLoad: function(response, ioArgs) {
			//console.log("ConfigManager::onLoad");

			// Read config.xml object to create config data object
			// Using dojo.query to extract data
			this.configData = {
				ui: {
					title: "",
					subtitle: "",
					logo: "",
					stylesheet: "",
					menus: [],
					showBanner: true
				},
				map: {
					baseMaps: [],
					liveMaps: [],
					fullExtent: null,
					initialExtent: null
				},
				navTools: [],
				widgets: [],
				links: [],
				proxyType: ""
			};
			
			// User interface elements
			//console.log("configData.ui loading...");
			this.configData.ui.title = this.getValue("userinterface > title", response);
			this.configData.ui.subtitle = this.getValue("userinterface > subtitle", response);
			this.configData.ui.logo = this.getValue("userinterface > logo", response);
			this.configData.ui.stylesheet = this.getValue("userinterface > stylesheet", response);
			if (this.getValue("userinterface > banner", response) !== "visible") {
				this.configData.ui.showBanner = false;
			}
			
			//console.log("configData.ui.menus loading...");
			var menuNodes = this.getNodes("menus", "menu", response);// dojo.query("menus > menu", response);
			menuNodes.forEach(dojo.hitch(this, function(node, idx, arr) {
				var menu = {
					label: this.getValue(node),
					id: this.getAttribute(node, "id"),
					visible: this.getAttribute(node, "visible") === "true",
					icon: this.getAttribute(node, "icon")
				};
				this.configData.ui.menus.push(menu);
			}));
			
			// Base Maps
			//console.log("configData.map.baseMaps loading...");
			var baseMapsNode = this.getNodes("map", "basemaps", response)[0];
			var menuId = this.getAttribute(baseMapsNode, "menu");
			var baseMapNodes = this.getNodes("basemaps", "mapservice", response);// dojo.query("basemaps > mapservice", response);
			var menuCode = "basemaps.mapservice";
			baseMapNodes.forEach(dojo.hitch(this, function(node, idx, arr) {
				var map = {
					label: this.getAttribute(node, "label"),
					type: this.getAttribute(node, "type"),
					visible: this.getAttribute(node, "visible") === "true",
					alpha: this.getAttribute(node, "alpha"),
					icon: this.getAttribute(node, "icon"),
					url: this.getValue(node),
					menu: menuId,
					menuCode: menuCode
				};
				this.configData.map.baseMaps.push(map);
			}));
			
			// Live Maps
			//console.log("configData.maps.liveMaps loading...");
			var liveMapsNode = this.getNodes("map", "livemaps", response)[0];
			var menuId = this.getAttribute(liveMapsNode, "menu");
			var liveMapNodes = this.getNodes("livemaps", "mapservice", response);// dojo.query("livemaps > mapservice", response);
			var menuCode = "livemaps.mapservice";
			liveMapNodes.forEach(dojo.hitch(this, function(node, idx, arr) {
				var map = {
					label: this.getAttribute(node, "label"),
					type: this.getAttribute(node, "type"),
					visible: this.getAttribute(node, "visible") === "true",
					alpha: this.getAttribute(node, "alpha"),
					icon: this.getAttribute(node, "icon"),
					url: this.getValue(node),
					menu: menuId,
					menuCode: menuCode
				};
				this.configData.map.liveMaps.push(map);
			}));
			
			// Extents
			//console.log("configData.map extents loading...");
			var mapNode = this.getNodes("configuration", "map", response)[0];
			
			var boxToCoords = function(str, idx, arr) {
				arr[idx] = parseFloat(str);
			};
			
			var box = this.getAttribute(mapNode, "initialExtent");
			var coords = box.split(" ", 4);
			dojo.forEach(coords, boxToCoords);
			this.configData.map.initialExtent = coords;
			box = this.getAttribute(mapNode, "fullExtent");
			coords = box.split(" ", 4);
			dojo.forEach(coords, boxToCoords);
			this.configData.map.fullExtent = coords;
			
			// Nav Tools
			//console.log("configData.navTools loading...");
			var navToolNodes = this.getNodes("navtools", "navtool", response);// dojo.query("navtools > navtool", response);
			var menuCode = "navtools.navtool";
			navToolNodes.forEach(dojo.hitch(this, function(node, idx, arr) {
				var tool = {
					label: this.getAttribute(node, "label"),
					menu: this.getAttribute(node, "menu"),
					menuCode: menuCode,
					icon: this.getAttribute(node, "icon"),
					value: this.getValue(node)
				};
				this.configData.navTools.push(tool);
			}));
			
			// Widgets
			//console.log("configData.widgets loading...");
			var widgetNodes = this.getNodes("widgets", "widget", response);// dojo.query("widgets > widget", response);
			var menuCode = "widgets.widget";
			widgetNodes.forEach(dojo.hitch(this, function(node, idx, arr) {
				var widget = {
					label: this.getAttribute(node, "label"),
					menu: this.getAttribute(node, "menu"),
					menuCode: menuCode,
					icon: this.getAttribute(node, "icon"),
					config: this.getAttribute(node, "config"),
					widgetType: this.getValue(node)
				};
				this.configData.widgets.push(widget);
			}));
			
			// Links
			//console.log("configData.links loading...");
			var linkNodes = this.getNodes("links", "link", response);// dojo.query("links > link", response);
			var menuCode = "links.link";
			linkNodes.forEach(dojo.hitch(this, function(node, idx, arr) {
				var link = {
					label: this.getAttribute(node, "label"),
					menu: this.getAttribute(node, "menu"),
					menuCode: menuCode,
					icon: this.getAttribute(node, "icon"),
					url: this.getValue(node)
				};
				this.configData.links.push(link);
			}));
			
			// Proxy type
			//console.log("configData.proxyType loading...");
			var proxyNode = this.getNodes("configuration", "proxytype", response)[0];
			this.configData.proxyType = this.getValue(proxyNode);
			
			// Publish configuration object
			//console.log("publishing configData...");
			dojo.publish("configLoadedEvent", [this.configData]);
			//console.dir(this.configData);
			
			// Always return response object for Deferreds
			return response;
		},
		
		onError: function(response, ioArgs) {
			console.error("Error reading config.xml", response, ioArgs);
			
			// Always return response object for Deferreds
			return response;
		}
	}
);
