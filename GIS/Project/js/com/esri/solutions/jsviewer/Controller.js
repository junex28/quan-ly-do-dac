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

dojo.provide("com.esri.solutions.jsviewer.Controller");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");
dojo.require("dijit._Container");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer", "ControllerStrings");

dojo.require("com.esri.solutions.jsviewer.ControllerMenu");

dojo.declare("com.esri.solutions.jsviewer.Controller",
	[dijit._Widget, dijit._Templated, dijit._Container],
	{
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "templates/Controller.html"),
		
		i18nStrings: null,
		
		map: null,
		configData: null,
		menuItemData: null,
				
		postMixInProperties: function() {
			//console.log("Controller postMixInProperties");
			
			// Init i18n
			this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer", "ControllerStrings");
		},
		
		postCreate: function() {
			//console.log("Controller postCreate");
			dojo.subscribe("configLoadedEvent", this, "onConfig");
			dojo.subscribe("mapLoadedEvent", this, "onMapLoad");
			dojo.subscribe("mapToolChangedEvent", this, "onMapToolChange");
			dojo.subscribe("statusChangedEvent", this, "onStatusChange");
		},
		
		startup: function() {
			if(this._started){ return; }
			//console.log("Controller startup");
			
			// Pass to children
			var children = this.getChildren();
			dojo.forEach(children, function(child){child.startup(); });
		},
		
		onConfig: function(configData) {
			this.configData = configData;
			
			// Unsubscribe from the event
			dojo.unsubscribe("configLoadedEvent");

			this._organizeMenuItems();
			//console.dir(configData);
			
			if (configData.ui.showBanner === false) {
				dojo.style(this.controllerBoxNode, "display", "none");
				dojo.addClass(this.containerNode, "controllerMenuBoxNoBanner");
			}
			this.setTitle(configData.ui.title);
			this.setSubtitle(configData.ui.subtitle);
			var logoUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", configData.ui.logo);
			this.setLogo(logoUrl);
			this.setStatus("");
			
			this.createMenus();
		},
		
		onMapLoad: function(map) {
			this.map = map;
		},
		
		setTitle: function(/*String*/ title) {
			var element = dojo.query(".controllerTitle", this.domNode)[0];
			element.innerHTML = title;
		},
		
		setSubtitle: function(/*String*/ subtitle) {
			var element = dojo.query(".controllerSubtitle", this.domNode)[0];
			element.innerHTML = subtitle;
		},
		
		setStatus: function(/*String*/ status) {
			var element = dojo.query(".controllerStatus", this.domNode)[0];
			element.innerHTML = status;
		},
		
		setToolText: function(/*String*/ toolText) {
			var msg = "";
			if (toolText) {
				msg = dojo.string.substitute(this.i18nStrings.msgCurrentTool, [toolText]);
			}
			this.setStatus(msg);
		},
		
		setLogo: function(/*URL*/ logoUrl) {
			var element = dojo.query(".controllerIcon", this.domNode)[0];
			dojo.style(element, "backgroundImage", "url(" + logoUrl + ")");
		},
		
		createMenus: function() {
			if (this.configData) {
				var nMenus = this.configData.ui.menus.length;
				var stepPct = 100 / (nMenus + 1);
				
				for (var i = 0; i < nMenus; i++) {
					var menuConfig = this.configData.ui.menus[i];
					menuConfig.positionAsPct = (i+1) * stepPct;
					var menu = new com.esri.solutions.jsviewer.ControllerMenu(menuConfig);
					dojo.connect(menu, "onMenuItemClick", this, "onMenuItemClick");
					
					// Add menu items
					dojo.forEach(this.menuItemData[menuConfig.id], dojo.hitch(this, function(item) {
						menu.addMenuItem(item);
					}));
					
					this.addChild(menu);
				}
			}
		},
		
		_organizeMenuItems: function() {
			this.menuItemData = {};
			
			// Note the ids of the menus
			for (var i = 0; i < this.configData.ui.menus.length; i++) {
				var menuConfig = this.configData.ui.menus[i];
				this.menuItemData[menuConfig.id] = [];
			}
			
			// Find items which have a "menu" attribute
			var itemSources = [
				this.configData.map.baseMaps,
				this.configData.map.liveMaps,
				this.configData.map.extents,
				this.configData.navTools,
				this.configData.widgets,
				this.configData.links
			];
			
			dojo.forEach(itemSources, dojo.hitch(this, function(source){
				dojo.forEach(source, dojo.hitch(this, function(item) {
					if (item.menu && this.menuItemData[item.menu]) {
						this.menuItemData[item.menu].push(item);
					}
				}));
			}));
		},
		
		onMenuItemClick: function(data) {
			//console.log("User clicked on menu item", data);
			if (data && data.menuCode && data.menuCode === "links.link") {
				// Controller handles link events
				for (var idx in this.configData.links) {
					if (this.configData.links[idx].label === data.value) {
						var linkInfo = this.configData.links[idx];
						var wId = linkInfo.label.replace(/\W/g, "");
						window.open(linkInfo.url, wId);
						break;
					}
				}
			}
			else {
				dojo.publish("menuItemClickedEvent", [data]);
			}
		},
		
		onMapToolChange: function(/*String*/ toolName) {
			this.setToolText(toolName);
		},
		
		onStatusChange: function(/* String */ status) {
			this.setStatus(status);
		}
	}
);
