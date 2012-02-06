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

dojo.provide("com.esri.solutions.jsviewer._BaseWidget");

dojo.require("com.esri.solutions.jsviewer._Widget");

dojo.declare(
	"com.esri.solutions.jsviewer._BaseWidget",
	com.esri.solutions.jsviewer._Widget,
	{
		constructor: function(/*Object*/ params) {
			this.connects = [];
			this.widgets = {};
		},
		
		_module: "com.esri.solutions.jsviewer",
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "templates/_BaseWidget.html"),
		panels: null,
		panelIndex: -1,
		configUrl: "",
		configData: null,
		configDataType: "",

		postMixInProperties: function() {
			//console.log("_BaseWidget postMixInProperties " + this.title);			
			if (this.icon === "") {
				this.icon = "assets/images/icons/i_pushpin.png";
			}
			if (this.config !== "") {
				// Triggers XHR call for the config file
				this.setConfig(this.config);
			}
		},
				
		postCreate: function() {
			//console.log("_BaseWidget postCreate " + this.title);
			// Wire up the map
			try {
				this.setMap(dijit.byId(this.mapId));
			}
			catch (err) { console.error(err); }
			
			// If there are multiple panels, show the first only
			this.panels = dojo.query(".widgetPanel", this.domNode);
			this.panels.forEach(function(item,idx,arr){
				item.buttonIcon = dojo.attr(item, "buttonIcon");
				item.buttonText = dojo.attr(item, "buttonText");
			});
			this.showPanel(0);
			console.log("_BaseWidget postCreate finished");
		},
		
		onShowPanel: function(index) {
			// Listened to by WidgetFrame. Allows widget to request that the
			// Frame resize and show the indicated panel
		},
		
		showPanel: function(/*Number*/ index) {
			//console.log('_BaseWidget showPanel begin');
			this.panelIndex = index;
			dojo.forEach(this.panels, function(item, idx, arr) {
				if (idx === index) {
					dojo.style(item, "display", "block");
				}
				else {
					dojo.style(item, "display", "none");
				}
			});
		},
		
		startup: function() {
			if(this._started){ return; }
			//console.log("_BaseWidget startup " + this.title);

			// Pass to children
			var children = this.getChildren();
			dojo.forEach(children, function(child){ child.startup(); });

			// Interact with the WidgetFrame
			var frame = this.getParent();
			if (frame && frame.declaredClass === "com.esri.solutions.jsviewer.WidgetFrame") {
				this.connects.push(dojo.connect(this, "onShowPanel", frame, "selectPanel"));
			}
			
			// If the class mixes in _MapGraphicsMaintainer, init it
			if (this.connectMapClick) {
				this.connectMapClick();
			}
			
			this.inherited(arguments);
		},
		
		shutdown: function() {
			// subclasses override to cleanup on closing
		},
		
		uninitialize: function() {
			//console.log("_BaseWidget uninitialize");
			dojo.forEach(this.connects, function(handle) {
				dojo.disconnect(handle);
			});
			this.connects = [];
		},
		
		setConfig: function(/* String */ config) {
			//console.log('_BaseWidget setConfig startup')
			this.inherited(arguments);

			this.configUrl = dojo.moduleUrl(this._module, config);
			//this.configUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", config);
			
			if (this.config) {
				if (this.config.match("\.json$")) {
					// Ends with .json -> parse JSON
					this.configDataType = "json";
				}
				else if (this.config.match("\.xml$")) {
					// Ends with .xml -> parse XML
					this.configDataType = "xml";
				}
				else {
					// Load plain text
					this.configDataType = "text";
				}
				
				var params = {
					url: this.configUrl,
					sync: true,
					handleAs: this.configDataType
				};
				
				params.load = dojo.hitch(this, function(response, ioArgs) {
					//console.log("_BaseWidget::setConfig::load success");
					this.configData = response;
					return response; // Always return response
				});
				
				params.error = function(response, ioArgs) {
					console.error("failed to retrieve config for Widget", response, ioArgs);
					return response; // Always return response
				};
				
				dojo.xhrGet(params);
			}
		},
		
		getAllNamedChildDijits: function() {
			//console.log('_BaseWidget getAllNamedChildDijits');
			// Gather all child widgets
			var w = dojo.query("[widgetId]", this.containerNode || this.domNode);
			//console.dir(w);
			var children = w.map(dijit.byNode);

			this.widgets = {};
			children.forEach(dojo.hitch(this, function(item, idx) {
				//console.debug(idx + ": " + item.declaredClass + " name: " + item.name);
				if (item.name) {
					this.widgets[item.name] = item;
				}
			}));
		}
	}
);
