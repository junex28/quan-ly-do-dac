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

dojo.provide("com.esri.solutions.jsviewer.ResultList");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");
dojo.require("dijit._Container");

dojo.declare("com.esri.solutions.jsviewer.ResultList",
	[dijit._Widget, dijit._Templated, dijit._Container],
	{
		constructor: function(/*Object*/ params) {
			this.connects = [];
		},
		
		templateString: "<div class='resultsPane' dojoAttachPoint='containerNode'></div>",
		
		count: 0,
		name: "",
		suppressImages: true,
		
		add: function(/*Object|ResultItem*/ obj) {
			try {
				if (obj) {
					var item = null;
					if (obj.declaredClass === "com.esri.solutions.jsviewer.ResultItem") {
						item = obj;
					}
					else {
						if (this.suppressImages) {
							obj.suppressImages = true;
						}
						item = new com.esri.solutions.jsviewer.ResultItem(obj);
					}
					
					item.applyAlternateBackground(this.count % 2 !== 0);
					
					this.addChild(item);
					this.count++;
					this.connects.push(dojo.connect(item, "onClick", this, "onResultClick"));
					this.connects.push(dojo.connect(item, "onHover", this, "onResultHover"));
					this.connects.push(dojo.connect(item, "onAction", this, "onResultAction"));
				}
			}
			catch (err) {
				console.error("Error adding ResultItem", err);
			}
		},
		
		clear: function() {
			dojo.forEach(this.connects, function(x){
				dojo.disconnect(x);
			});
			this.connects = [];
			
			var children = this.getChildren();
			dojo.forEach(children, function(x){
				x.destroyRecursive();
			});
			
			this.count = 0;
			this.onResultClick({}); // empty event object
		},
		
		selectFirstItem: function() {
			var children = this.getChildren();
			this.onResultClick({resultItem: children[0]});
		},
		
		onResultClick: function(evt) {
			// stub for events
			//console.debug("onResultClick");
			//console.dir(evt);
		},
		
		onResultHover: function(evt) {
			// stub for events
			//console.debug("onResultHover");
			//console.dir(evt);
		},
		
		onResultAction: function(evt) {
			// stub for events
			//console.debug("onResultAction");
			//console.dir(evt);
		}
	}
);

dojo.declare("com.esri.solutions.jsviewer.ResultItem",
	[dijit._Widget, dijit._Templated],
	{
		constructor: function(/*Object*/ params) {
			
		},
		
		title: "",
		content: "",
		link: "",
		iconUrl: "",
		actionIconUrl: "",
		graphic: null,
		location: null,
		suppressImages: false,
		zoomScale: null,
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "templates/ResultItem.html"),
		
		postCreate: function() {
			this.setTitle(this.title);
			this.setContent(this.content);
			this.setIconUrl(this.iconUrl);
			this.setLink(this.link);
			this.setActionIconUrl(this.actionIconUrl);
			this.setZoomScale(this.zoomScale);
		},

		setTitle: function(/*String*/ title) {
			this.title = title;
			this.titleNode.innerHTML = this.title;
			dojo.attr(this.domNode, "title", this.title);
		},
		
		setContent: function(/*HTML*/ content) {
			if (this.suppressImages) {
				content = content.replace(/<img [^>]*>/ig,"<!--img removed-->");
			}
			this.content = content;
			this.contentNode.innerHTML = content;
			dojo.setSelectable(this.domNode, false);
		},
		
		setLink: function(/*URL*/ url) {
			this.link = url;
			if (this.link) {
				dojo.style(this.linkNode, "display", "block");
				dojo.attr(this.linkNode, "title", this.link);
			}
			else {
				dojo.style(this.linkNode, "display", "none");
			}
		},
		
		setIconUrl: function(/*URL*/ url) {
			this.iconUrl = url;
			if (!dojo.isIE) {
				dojo.style(this.domNode, "backgroundImage", "url(" + this.iconUrl + ")");
			}
		},
		
		setActionIconUrl: function(/*URL*/ url) {
			this.actionIconUrl = url;
			if (this.actionIconUrl) {
				dojo.style(this.actionNode, "backgroundImage", "url(" + this.actionIconUrl + ")");
				dojo.style(this.actionNode, "display", "block");
			}
			else {
				dojo.style(this.actionNode, "display", "none");
			}
		},
		
		setZoomScale: function(/*Number*/ scale) {
			if (scale) {
				try {
					var scaleInt = parseInt(scale);
					this.zoomScale = scaleInt;
					return;
				}
				catch (err) {
					console.error("ResultItem::setZoomScale could not parse scale '" + scale + "'");
				}
			}
			this.zoomScale = null;
		},
		
		applyAlternateBackground: function(/*boolean*/ isAlt) {
			if (isAlt && dojo.hasClass(this.domNode, "alt") === false) {
				dojo.addClass(this.domNode, "alt");
			}
			else if (!isAlt && dojo.hasClass(this.domNode, "alt")) {
				dojo.removeClass(this.domNode, "alt");
			}
		},
		
		removeContentImages: function() {
			dojo.query("img", this.contentNode).forEach( function(img) {
				img.parentNode.removeChild(img);
				});
		},
		
		// Trap "hover" events
		_hoverTimeout: null,
		_clearHoverTimeout: function() {
			if (this._hoverTimeout) {
				clearTimeout(this._hoverTimeout);
				this._hoverTimeout = null;
			}
		},
		
		onMouseMove: function(evt) {
			this._clearHoverTimeout();
			this._hoverTimeout = setTimeout(dojo.hitch(this, function(evt) {
				this.onHover({});
			}), 300);
		},
		
		onMouseOut: function(evt) {
			this._clearHoverTimeout();
		},
		
		onClick: function(evt) {
			// stub for events
			evt.resultItem = this;
		},
		
		onHover: function(evt) {
			// stub for events
			evt.resultItem = this;
		},
		
		onFollowLink: function(evt) {
			window.open(this.link);
			dojo.stopEvent(evt);
		},
		
		onAction: function(evt) {
			evt.resultItem = this;
			dojo.stopEvent(evt);
		}
	}
);