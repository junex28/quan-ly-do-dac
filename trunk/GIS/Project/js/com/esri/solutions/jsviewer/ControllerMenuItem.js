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

dojo.provide("com.esri.solutions.jsviewer.ControllerMenuItem");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");
dojo.require("dijit._Container");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare("com.esri.solutions.jsviewer.ControllerMenuItem",
	[dijit._Widget, dijit._Templated, dijit._Contained],
	{
		constructor: function(/*Object*/ params) {
			
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "templates/ControllerMenuItem.html"),
		
		label: "",
		icon: "",
		value: "",
		menuCode: "",
		title: "", // tooltip text
		url: "",
		
		postMixInProperties: function() {
			//console.log("ControllerMenuItem postMixInProperties");
			if (this.icon === "") {
				this.icon = "assets/images/icons/i_icp.png";
			}
			if (this.label === "") {
				this.label = "No Label";
			}
			if (!this.value) {
				this.value = this.label;
			}
			if (!this.title) {
				if (this.url) {
					this.title = this.url;
				}
				else {
					this.title = this.label;
				}
			} 
		},
		
		postCreate: function() {
			//console.log("ControllerMenuItem postCreate");
			var iconUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", this.icon);
			this.setIcon(iconUrl.path);
			dojo.setSelectable(this.domNode, false);
		},
		
		startup: function() {
			//console.log("ControllerMenuItem startup");
		},
		
		onClick: function(evt) {
			this.onMenuItemClick({
				value: this.value,
				label: this.label,
				menuCode: this.menuCode
			});
		},
		
		onMenuItemClick: function(data) {
			// stub for event propagation
		},
		
		setIcon: function(/*URL*/ iconUrl) {
			var smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(iconUrl);			
			dojo.style(this.domNode, "backgroundImage", "url(" + smallIconUrl + ")");
		}
	}
);
