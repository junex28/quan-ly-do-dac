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

dojo.provide("com.esri.solutions.jsviewer.DataManager");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare("com.esri.solutions.jsviewer.DataManager",
	[dijit._Widget, dijit._Templated],
	{
		constructor: function(/*Object*/ params) {
			this.knownLocations = {};
		},
		
		templateString: "<div style='display: none;'></div>",

		configData: null,
		proxyUrlProc: null,
		
		postMixInProperties: function() {
			//console.log("DataManager postMixInProperties");
		},
		
		postCreate: function() {
			//console.log("DataManager postCreate");
			dojo.subscribe("configLoadedEvent", this, "onConfig");
			dojo.subscribe("dataRequestEvent", this, "onDataRequest");
			dojo.subscribe("widgetLocationsChangedEvent", this, "onWidgetLocationsChanged");
			dojo.subscribe("locationsRequestEvent", this, "onLocationsRequest");
		},
		
		startup: function() {
			//console.log("DataManager startup");
		},
		
		setProxyType: function(/*String*/ value) {
			if (value && dojo.isString(value)) {
				value = value.toLowerCase();
				switch (value) {
					case ("apache"):
						console.log("DataManager proxy type apache");
						this.proxyUrlProc = function(url) {
							// Replace the host and port
							var req = com.esri.solutions.jsviewer.util.parseUrl(url);
							var page = com.esri.solutions.jsviewer.util.parseUrl(document.URL);
							var result = req.protocol + "://" + page.host;
							if (page.port) {
								result += page.port;
							}
							if (req.path) {
								result += req.path;
							}
							return result;
						};
						esriConfig.defaults.io.proxyUrl = null;
						break;
					case ("jsp"):
						console.log("DataManager proxy type jsp");
						this.proxyUrlProc = function(url) {
							// Prefix url with proxy url
							return "proxy.jsp?" + url;
						};
						esriConfig.defaults.io.proxyUrl = "proxy.jsp";
						break;
					case ("asp"):
						console.log("DataManager proxy type asp");
						this.proxyUrlProc = function(url) {
							// Prefix url with proxy url
							return "proxy.ashx?uri=" + url;
						};
						esriConfig.defaults.io.proxyUrl = "proxy.ashx";
						break;
					case ("php"):
						console.log("DataManager proxy type php");
						this.proxyUrlProc = function(url) {
							// Prefix url with proxy url
							return "proxy.php?uri=" + url;
						};
						esriConfig.defaults.io.proxyUrl = "proxy.php";
						break;
					default:
						console.error("DataManager::setProxyType unknown type: " + value);
						esriConfig.defaults.io.proxyUrl = null;
						break;
				}
			}
		},

		onConfig: function(configData) {
			this.configData = configData;
			
			// Unsubscribe from the event
			dojo.unsubscribe("configLoadedEvent");

			this.setProxyType(configData.proxyType);
		},
		
		onDataRequest: function(/*Object*/ request) {
			if (request) {
				//console.dir(request);
				request.url = this.proxyUrlProc(request.url);
				//console.debug("munged url: " + request.url);
				dojo.xhrGet(request);
			}
		},
		
		onWidgetLocationsChanged: function(/*Object*/ msg) {
			try {
				if (msg && msg.source && msg.locations) {
					this.knownLocations[msg.source] = msg.locations;
					dojo.publish("knownLocationsChangedEvent", [this.knownLocations]);
				}
			}
			catch (err) {
				console.error("DataManager::onWidgetLocationsChanged", err);
			}
		},
		
		onLocationsRequest: function(/*Object*/ request) {
			if (request) {
				request.callback(this.knownLocations);
			}
		}
	}
);
