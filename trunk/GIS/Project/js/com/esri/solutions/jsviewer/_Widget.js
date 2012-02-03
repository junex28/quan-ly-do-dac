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

dojo.provide("com.esri.solutions.jsviewer._Widget");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");
dojo.require("dijit._Container");

dojo.declare(
	"com.esri.solutions.jsviewer._Widget",
	[dijit._Widget, dijit._Templated, dijit._Container, dijit._Contained],
	{
		constructor: function(/*Object*/ params) {
			//console.log("_Widget::constructor");
			//console.dir(params);
		},
		
		mapId: "",
		map: null,
		title: "",
		icon: "",
		alarm: "",
		config: "",
		state: "maximized",
		
		setId: function(/*Number*/ id) {
			this.id = id;
		},
		setTitle: function (/*String*/ title) {
			this.title = title;
		},
		setIcon: function (/*String*/ icon) {
			this.icon = icon;
		},
		setConfig: function (/*String*/ config) {
			this.config = config;
		},
		setState: function (/*String*/ state) {
			this.state = state;
		},
		setMap: function (/*esri.Map*/ map) {
			this.map = map;
		}
	}
);
