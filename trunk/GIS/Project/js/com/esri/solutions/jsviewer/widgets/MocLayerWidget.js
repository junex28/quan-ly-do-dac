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

dojo.provide("com.esri.solutions.jsviewer.widgets.MocLayerWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "MocLayerWidgetStrings");

//dijits used in template
dojo.require("com.esri.solutions.jsviewer.ResultList");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.MocLayerWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
	    constructor: function(/*Object*/ params) {
		},
		
		//separate template file versus inline tempalte creation
		templatePath:  dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/MocLayerWidget.html"),
		
		layerUrl: "",
		titleField: "",
		queryFields: "",
		linkField: "",
		query: "",
		zoomScale: -1,
		
		iconUrl: "",
		smallIconUrl: "",
		symbol: null,
		
		loaderNode: null,
		messageNode: null,
		
		_initialized: false,
		_refreshRate: 60,
		_fetchInterval: null,
		
	    postMixInProperties: function() {
			console.log("MocLayerWidget postMixInProperties");
			try {
			    //super
				this.inherited(arguments);

				if (this.configData) {
				    //json configuration
					var c = this.configData.livelayer;
					this.layerUrl = c.layer;
					this.query = c.query;
					if (this.query === "") {
						this.query = "objectid > 0";
					}
					this.queryFields = c.fields;
					this.titleField = c.titleField;
					this.linkField = c.linkField;
					this._refreshRate = c.refreshRate;
					this.zoomScale = c.zoomScale;
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "MocLayerWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function(){
			console.log("MocLayerWidget postCreate");
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
			console.log("MocLayerWidget startup");
		    //super
		    this.inherited(arguments);
			if (!this._initialized) {
				try {
					this.getAllNamedChildDijits();
					
					//initialze the map graphic sysmbol
					this.iconURL = dojo.moduleUrl("com.esri.solutions.jsviewer", this.icon).path;
					this.smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(this.iconURL);
					//using the JS API PictureMarkerSymbol
					this.symbol = new esri.symbol.PictureMarkerSymbol(this.iconURL, 16, 16);
					
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
			try {
				if (this.layerUrl) {
					this.setMessage(this.i18nStrings.msgLoad, true);
					this.clearResults();
					
					var qParams = new esri.tasks.Query();
					qParams.returnGeometry = true;
					qParams.outFields = this.queryFields;
					qParams.where = this.query;
					qParams.outSpatialReference = this.map.spatialReference;
					var task = new esri.tasks.QueryTask(this.layerUrl);
					task.execute(qParams, dojo.hitch(this, "queryCallback"));
				}
			}
			catch (err) {
				console.error("LiveLayerWidget::fetchData", err);
			}
		},

		queryCallback: function(featureSet) {
			if (featureSet && featureSet.features) {
				var locations = [];
				
				for (var i = 0; i < featureSet.features.length; i++) {
					var f = featureSet.features[i];
					
					var link = null;
					var content = "<table>";
					content+= "<tr><td> Cấp hạng </td><td>" + this.tenCapHang(f.attributes['CapHang']) + "</td></tr>";
					content+= "<tr><td> Loại mốc </td><td>" + this.tenLoaiMoc(f.attributes['LoaiMoc']) + "</td></tr>";
					content+= "<tr><td> Hệ quy chiếu </td><td>" + f.attributes['HeQuyChieu'] + "</td></tr>";
					content+= "<tr><td> Năm thành lập </td><td>" + f.attributes['NamThanhLap'] + "</td></tr>";
					content+= "<tr><td> Tình trạng </td><td>" + this.tenTinhTrang(f.attributes['TinhTrang']) + "</td></tr>";										
					content += "</table>";
					
		            var attrs = {
		                "title": f.attributes[this.titleField],
		                "content": content,
		                "link": link
		            };
					var g = new esri.Graphic(f.geometry, this.symbol, attrs);
	
					var params = {
						title: attrs.title,
						content: attrs.content,
						iconUrl: this.smallIconUrl,
						graphic: g,
						location: f.geometry,
						link: attrs.link,
						zoomScale: this.zoomScale
					};
					this.widgets.results.add(params);
					
		            this.addGraphic(g);
					locations.push(params);
				}
				dojo.publish("widgetLocationsChangedEvent", [{
					source: this.title,
					locations: locations
				}]);
			}
			
			var msg = this.i18nStrings.msgFound;
			msg = dojo.string.substitute(msg, [this.widgets.results.count]);
			this.setMessage(msg);
		},
		
		tenLoaiMoc: function(coded){
			if(coded){
				switch(coded){
				case 1: return 'Mốc toạ độ';
				case 2: return 'Mốc độ cao';
				case 3: return 'Mốc trọng lực';
			}
			}
		},
		
		tenCapHang: function(coded){
			if(coded){
				switch(coded){
				case 1: return 'Cấp I';
				case 2: return 'Cấp II';
				case 3: return 'Cấp III';
			}
			}
		},
		
		tenTinhTrang: function(coded){
			if(coded){
				switch(coded){
				case 1: return 'Còn tốt';
				case 2: return 'Đang sửa chửa';
				case 3: return 'Không còn sử dụng';
			}
			}
		},
		
		//clear the results node and any graphics on the screen
		clearResults: function() {
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