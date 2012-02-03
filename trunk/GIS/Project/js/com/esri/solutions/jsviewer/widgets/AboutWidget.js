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

dojo.provide("com.esri.solutions.jsviewer.widgets.AboutWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.AboutWidget",
	com.esri.solutions.jsviewer._BaseWidget,
	{
		app_title: "app_title",
		app_subtitle: "app_subtitle",
		description: "description",
		copyright: "copyright",
		version: "version",
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/AboutWidget.html"),
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
	
				if (this.configData) {
					if (this.configDataType === "xml") {
						this.configData = com.esri.solutions.jsviewer.util.xml.parseObject(this.configData.firstChild);
					}
					var about = this.configData.about;
					this.app_title = (dojo.isString(about.title)) ? about.title : "";
					this.app_subtitle = (dojo.isString(about.subtitle)) ? about.subtitle : "";
					this.description = (dojo.isString(about.description)) ? about.description : "";
					this.copyright = (dojo.isString(about.copyright)) ? about.copyright : "";
					this.version = (dojo.isString(about.version)) ? about.version : "";
				}
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);

				if (this.configData) {
					var logo = this.configData.about.logo;
					var logoUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", logo);
					dojo.query(".aboutlogo", this.domNode).style("backgroundImage", "url(" + logoUrl + ")");
				}
			}
			catch (err) { console.error(err); }
		}
	}
);
