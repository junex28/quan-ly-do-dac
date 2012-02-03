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

dojo.provide("com.esri.solutions.jsviewer.widgets.BookmarkWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "BookmarkWidgetStrings");

// for GUI purposes
dojo.require("dijit.form.Button");
dojo.require("dijit.form.TextBox");
dojo.require("com.esri.solutions.jsviewer.ResultList");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.BookmarkWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
		constructor: function(/*Object*/ params) {
			this.bookmarks = [];
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/BookmarkWidget.html"),
		
		smallIconUrl: "",
		_initialized: false,
		
		i18nStrings: null,
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
				
				if (this.configData) {
					this.bookmarks = this.configData.bookmark.bookmarks;
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "BookmarkWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);

				dojo.parser.parse(this.domNode);
			}
			catch (err) { console.error(err); }
		},
		
		startup: function() {
			this.inherited(arguments);
			if (this._initialized) { return; }

			try {
				this.getAllNamedChildDijits();
				
				// Attach button click events
				this.connects.push(dojo.connect(this.widgets.btnAdd, "onClick", this, "onBookmarkAddClick"));
				
				// Listen to result selection messages
				this.connects.push(dojo.connect(this.widgets.results, "onResultClick", this, "onBookmarkClick"));
				this.connects.push(dojo.connect(this.widgets.results, "onResultAction", this, "onBookmarkDelete"));

				// Init the list graphic symbols
				this.iconUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", this.icon).path;
				this.smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(this.iconUrl);
				this.actionIconUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", "assets/images/widget/w_close_red.png").path;
				
				// Determine if this user has saved bookmarks
				if (this.getSavedBookmarkCount() > 0) {
					this.readSavedBookmarks();
				}
				// Give the bookmarks a real extent object
				var sr = this.map.spatialReference;
				dojo.forEach(this.bookmarks, function(b){
					// coords from config is array of four numbers
					// [xmin, ymin, xmax, ymax]
					var ext = new esri.geometry.Extent(b.coords[0], b.coords[1], b.coords[2], b.coords[3], sr);
					b.extent = ext;
				});
				
				this.displayBookmarks();
				
				this._initialized = true;
			}
			catch (err) {
				console.error(err);
			}
		},
		
		shutdown: function() {
			this.inherited(arguments);
		},

		displayBookmarks: function() {
			var bookmarks = this.bookmarks;
			var list = this.widgets.results;
			var url = this.smallIconUrl;
			var actionUrl = this.actionIconUrl;
			
			list.clear();
			
			dojo.forEach(bookmarks, function(b) {
				list.add({
					title: b.name,
					content: b.coords[0] + ", " + b.coords[1] + ", " + b.coords[2] + ", " + b.coords[3],
					iconUrl: url,
					location: b.extent,
					actionIconUrl: actionUrl
				});
			});
		},
		
		saveBookmarks: function() {
			dojo.cookie("com.esri.solutions.jsviewer.BookmarkWidget:count", this.bookmarks.length, {expires: 1000});
			
			for (var i = 0; i < this.bookmarks.length; i++) {
				var b = this.bookmarks[i];
				var bJson = dojo.toJson(b);
				dojo.cookie("com.esri.solutions.jsviewer.BookmarkWidget:" + i, bJson, {expires: 1000});
			}
		},
		
		getSavedBookmarkCount: function() {
			var count = dojo.cookie("com.esri.solutions.jsviewer.BookmarkWidget:count");
			if (count) {
				return parseInt(count, 10);
			}
			return 0;
		},
		
		readSavedBookmarks: function() {
			var count = this.getSavedBookmarkCount();
			this.bookmarks = [];
			for (var i = 0; i < count; i++) {
				var bJson = dojo.cookie("com.esri.solutions.jsviewer.BookmarkWidget:" + i);
				var b = dojo.fromJson(bJson);
				this.bookmarks.push(b);
			}
		},
		
		onBookmarkAddClick: function(evt) {
			// Create bookmark
			var ext = this.map.extent;
			var sd = com.esri.solutions.jsviewer.util.significantDigits;
			var b = {
				name: this.widgets.bookmarkName.getValue(),
				coords: [sd(ext.xmin, 5), sd(ext.ymin, 5), sd(ext.xmax, 5), sd(ext.ymax, 5)],
				extent: ext
			};
			this.bookmarks.push(b);
			
			// Add it to the results
			var list = this.widgets.results;
			list.add({
				title: b.name,
				content: b.coords[0] + ", " + b.coords[1] + ", " + b.coords[2] + ", " + b.coords[3],
				iconUrl: this.smallIconUrl,
				location: b.extent,
				actionIconUrl: this.actionIconUrl
			});
			
			// Save bookmarks
			this.saveBookmarks();
			
			// Switch to the bookmarks panel
			this.onShowPanel(0);
		},
		
		onBookmarkDelete: function(evt) {
			// Find the bookmark to delete (by name)
			for (var i = 0; i < this.bookmarks.length; i++) {
				if (this.bookmarks[i].name === evt.resultItem.title) {
					this.bookmarks.splice(i, 1);
					break;
				}
			}
			
			this.saveBookmarks();
			this.displayBookmarks();
		},
				
		onBookmarkClick: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				// zoom to location
				try {
					this.map.setExtent(evt.resultItem.location);
				}
				catch (err) {
					console.error("BookmarkWidget::onBookmarkClick", err);
				}
			}
		}
	}
);
