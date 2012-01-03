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

 //namespace and widget declaration
dojo.provide("com.esri.solutions.jsviewer.widgets._XmlFeedWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "_XmlFeedWidgetStrings");

//dijits used in template
dojo.require("com.esri.solutions.jsviewer.ResultList");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets._XmlFeedWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer], //_BaseWidget derives from _Widget derives from _Widget, _Templated, _Contained
	{
	    //lifecycle:  preamble (dojo.declare), constructor (dojo.declare), postMixInProperties (dijit._Widget), buildRendering (dijit._Widget)
	    //postCreate (dijit._Widget), startup (dijit._Widget), destroyREcorusive (dijit._Widget), uninitialize (dijit._Widget)
	
	    //override to perform custom behaviour during dijit construction
	    //use to initialize dijit properties that are not primitive types
	    //add any additional properties relied upon by other lifecycle methods downstream
	    constructor: function(/*Object*/ params) {
		},
		
		//separate template file versus inline tempalte creation
		templatePath:  dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/_XmlFeedWidget.html"),
		
		//dijit properties
		feedUrl: "",
		handleAs: "xml",
		titleField: "",
		contentField: "",
		linkField: "",
		zoomScale: -1,
		
		// for projecting feed shapes to map spatial reference
		geometryServiceUrl: "",
		geometryService: null,
		
		iconUrl: "",
		smallIconUrl: "",
		symbol: null,
		
		loaderNode: null,
		messageNode: null,
		
		_initialized: false,
		_refreshRate: 60,
		_fetchInterval: null,

		getAttribute: com.esri.solutions.jsviewer.util.xml.getAttribute,
		getValue: com.esri.solutions.jsviewer.util.xml.getValue,
		getNodes: com.esri.solutions.jsviewer.util.xml.getNodes,
		getAllNodes: com.esri.solutions.jsviewer.util.xml.getAllNodes,
		
		
		i18nStrings: null,
		
		
		
		//called after inheritance hierachy walked, all ancestors to class are mixed in, class now has access to all inherited properties
	    //manipulate visual elements here as this is called before dijit becomes visible on screen, modify or derive placeholders here
	    postMixInProperties: function() {
			try {
			    //super
				this.inherited(arguments);
	            //this.configData inherited from _BaseWidget, reads config file
				if (this.configData) {
				    //json configuration
					this.feedUrl = this.configData.xmlFeed.source;
					this._refreshRate = this.configData.xmlFeed.refreshRate;
					this.zoomScale = this.configData.xmlFeed.zoomScale;
					
					// For projecting feed shapes to map spatial reference
					this.geometryServiceUrl = this.configData.xmlFeed.geometryService;
					if (this.geometryServiceUrl) {
						this.geometryService = new esri.tasks.GeometryService(this.geometryServiceUrl);
					}
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "_XmlFeedWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},	
		
		//executes once dijit has been created and visibly placed, child dijits are not safely accessible here use startup instead
		postCreate: function(){
		    try{
		        //super
		        this.inherited(arguments);
		        dojo.parser.parse(this.domNode);
				
				//initialize loader where dojo.query where css class = "loader"
				this.loaderNode = dojo.query(".loader", this.domNode)[0];
				//moduleURL creates an object representing an URL which is then set to the loader img src attribute
                this.loaderNode.src = dojo.moduleUrl("com.esri.solutions.jsviewer", "assets/images/loader.gif");
		    }
		    catch (err) { console.error(err); }
		},
		
		
		
		startup: function(){
		    //super
		    this.inherited(arguments);
			if (!this._initialized) {
				try {					
					// Gather all child widgets, dojo.query("[widgetId]") returns elements with attributes "widgetId" within the scope of containerNode
					//or domNode, map = runs each item thorugh a function and returns the results as a dojo.NodeList
					//dijit.byNode(dom node) given a node, returns the digit that represents the node.
					this.getAllNamedChildDijits();
					
					//initialze the map graphic sysmbol
					this.iconURL = dojo.moduleUrl("com.esri.solutions.jsviewer", this.icon).path;
					this.smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(this.iconURL);
					//using the JS API PictureMarkerSymbol
					this.symbol = new esri.symbol.PictureMarkerSymbol(this.iconURL, 40, 40);
					
					//initialize message node where dojo.query where css class = "locateResultsMsg" and scope is dijit domnode
					this.messageNode = dojo.query(".resultsMsg", this.domNode)[0];
					//see setMessage function defined below, intialize to ready
					this.setMessage(this.i18nStrings.msgReady);
					
					// Listen to result selection messages
					this.connects.push(dojo.connect(this.widgets.results, "onResultClick", this, "onResultClick"));
					this.connects.push(dojo.connect(this.widgets.results, "onResultHover", this, "onResultHover"));
					this.clearResults();
					
					this._initialized = true;
					
				} 
				catch (err) {
					console.error(err);
				}
			}
			
			// Start refreshing data
			if (this._fetchInterval === null) {
				this._fetchInterval = setInterval(dojo.hitch(this, function(){
					this.fetchData();
				}), this._refreshRate * 1000);
			}
			this.fetchData();
			
		},
		
		
		shutdown: function() {
			if (this._fetchInterval) {
				clearInterval(this._fetchInterval);
				this._fetchInterval = null;
			}
			this.clearResults();
			dojo.publish("widgetHighlightEvent", [null]);
			this.inherited(arguments);
		},

		
		
		//a custom function used to manipulate the animated loading icon and message node result during a long
		//running operation
		setMessage: function(/*String*/ message, /*boolean*/ showLoading) {
			this.messageNode.innerHTML = message;
			if (showLoading) {
				dojo.style(this.loaderNode, "visibility", "visible");
			}
			else {
				dojo.style(this.loaderNode, "visibility", "hidden");
			}
		},

		
		fetchData: function(evt) {
			if (this.feedUrl) {
				this.setMessage(this.i18nStrings.msgLoad, true);
				this.clearResults();
				
				var params = {
					url: this.feedUrl,
					handleAs: this.handleAs,
					load: dojo.hitch(this, "onLoad"),
					error: dojo.hitch(this, "onError"),
					sync: false
				};
				
				dojo.publish("dataRequestEvent", [params]);
			}
		},
		
		onLoad: function(response, ioArgs) {
			console.error("_XmlFeedWidget::onLoad must be overridden");
			return response;
		},
	    
		
		onError: function(response, ioArgs) {
			console.error("Error reading xml feed", response, ioArgs);
			return response;
		},
				
		projectShapes: function(/*esri.Graphic[]*/ features, /*esri.SpatialReference*/ outSR, /*Function*/ callback) {
			try {
				if (dojo.isFunction(callback)) {
					if (features && outSR && this.geometryService) {
					
						// If the features all have the same SR as the map, don't project, just call the callback
						var bNeedProj = false;
						var mapSR = this.map.spatialReference;
						dojo.forEach(features, function(g){
							if (g.geometry && g.geometry.spatialReference.wkid !== mapSR.wkid) {
								bNeedProj = true;
							}
						});
						if (bNeedProj) {
							this.geometryService.project(features, outSR);//, callback);
						}
						else {
							callback(features);
						}
					}
					else {
						// Either no features, no output SR or no defined geometry service
						callback(features);
					}
				}
			// no callback
			}
			catch (err) {
				console.error("_XmlFeedWidget::projectShapes ", err);
			}
		},
		
		//clear the results node and any graphics on the screen
		clearResults: function() {
		    //console.debug("clear results");
		    this.widgets.results.clear();
			dojo.publish("widgetLocationsChangedEvent", [{
				source: this.title,
				locations: []
			}]);
			this.clearGraphics();
		},		
		
		onResultClick: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				dojo.publish("widgetHighlightEvent", [evt.resultItem.graphic, evt.resultItem.location, true, evt.resultItem.zoomScale]);
			}
			else {
				dojo.publish("widgetHighlightEvent", [null]);
			}
		},
		
		onResultHover: function(evt) {
			// evt.resultItem is the result item dijit
			// evt.resultItem.graphic is the result in the map.
			// evt.resultItem.location is the place to zoom to
			if (evt.resultItem) {
				dojo.publish("widgetHighlightEvent", [evt.resultItem.graphic, evt.resultItem.location, false]);
			}
			else {
				dojo.publish("widgetHighlightEvent", [null]);
			}
		}

		
	}
	
);
