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

dojo.provide("com.esri.solutions.jsviewer.WidgetManager");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");

dojo.declare("com.esri.solutions.jsviewer.WidgetManager",
	[dijit._Widget, dijit._Templated],
	{
		constructor: function() {
			this.widgetDefinitions = {};
			this.widgets = {};
		},
		
		templateString: "<div style='display: none;'></div>",
		
		map: null,
		configData: null,
		
		postMixInProperties: function() {
			//console.log("WidgetManager postMixInProperties");
		},
		
		postCreate: function() {
			//console.log("WidgetManager postCreate");
			try{
				dojo.subscribe("configLoadedEvent", this, "onConfig");
				dojo.subscribe("mapLoadedEvent", this, "onMapLoad");
				dojo.subscribe("menuItemClickedEvent", this, "onMenuClick");				
			}catch(err){
				console.error("WidgetManager::postCreate " +err);
			}
		},
		
		startup: function() {
			//console.log("WidgetManager startup");
		},
		
		onConfig: function(configData){
			//console.log("WidgetManager::onConfig");
			this.configData = configData;
			
			// Unsubscribe from the event
			dojo.unsubscribe("configLoadedEvent");
			
			// Make note of the defined widgets
			// and dojo.require them
			dojo.forEach(configData.widgets, dojo.hitch(this, function(defn) {
				this.widgetDefinitions[defn.label] = defn;
				this.requireWidget(defn.label);
			}));
		},
		
		onMapLoad: function(map){
			//console.log("WidgetManager::onMapLoad");
			this.map = map;
			
			// For testing purposes
			//setTimeout(dojo.hitch(this, function(){
			//	var w = this.getWidget("KML Widget");
			//	dojo.publish("showWidget", [w]);
			//	for (var label in this.widgetDefinitions) {
			//		//console.log("getWidget(" + label + ")");
			//		var w = this.getWidget(label);
			//		dojo.publish("showWidget", [w]);
			//	}				
			//}), 1000);
		},
		
		onMenuClick: function(data) {
			if (data && data.value && data.menuCode && data.menuCode === "widgets.widget") {
				//console.log("onMenuClick for widget '" + data.value + "'");
				try {
					if (this.widgetDefinitions[data.value]) {
						var w = this.getWidget(data.value);
						dojo.publish("showWidget", [w]);
					}
				}
				catch (err) { console.error(err); }
			}
		},
		
		getWidget: function(label) {
			if (!this.widgets[label]) {
				this.loadWidget(label);
			}
			return this.widgets[label];
		},
		
		requireWidget: function(label) {
			var defn = this.widgetDefinitions[label];
			var reqStr = "dojo." + "require('" + defn.widgetType + "')"; // breaking up dojo. and require necessary to fool the dojo parser!
			eval(reqStr);
		},
		
		loadWidget: function(label) {
			var defn = this.widgetDefinitions[label];
			var paramStr = "";
			if (defn.config) {
				paramStr = "{ config: '" + defn.config + "'}";
			}
			
			var loadStr = "var w = new " + defn.widgetType + "(" + paramStr + ")";
			eval(loadStr);
			
			w.setTitle(defn.label);
			w.setIcon(defn.icon);
			w.setConfig(defn.config);
			w.setMap(this.map);
			
			this.widgets[label] = w;
		}
	}
);
