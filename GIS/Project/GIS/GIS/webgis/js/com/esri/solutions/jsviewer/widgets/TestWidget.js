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

dojo.provide("com.esri.solutions.jsviewer.widgets.TestWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");
dojo.require("esri.layers.FeatureLayer");
// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "MocLayerWidgetStrings");

//dijits used in template
dojo.require("com.esri.solutions.jsviewer.ResultList");
dojo.require("com.esri.solutions.jsviewer.Pagination");


dojo.declare(
	"com.esri.solutions.jsviewer.widgets.TestWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
	    constructor: function(/*Object*/ params) {
		},
		
		//separate template file versus inline tempalte creation
		templatePath:  dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/TestWidget.html"),
		
		layerUrl: "",
		titleField: "",
		queryFields: "",
		linkField: "",
		query: "",
		zoomScale: -1,
		rowPerPage: 10,  // default
		
		iconUrl: "",
		smallIconUrl: "",
		symbol: null,
		
		loaderNode: null,
		messageNode: null,
		
		_initialized: false,
		_refreshRate: 60,
		_fetchInterval: null,
		
		//Pagination
		currentPage: 1,
		totalPage : 0,
		pageInfo : null,
		paginator: null,
		
		
	    postMixInProperties: function() {
			console.log("TestWidget postMixInProperties");
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
					this.rowPerPage = c.rowPerPage;
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "MocLayerWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function(){
			console.log("TestWidget postCreate");
		    try{
		        //super
		        this.inherited(arguments);
		        dojo.parser.parse(this.domNode);
				
				//initialize loader where dojo.query where css class = "loader"
				this.loaderNode = dojo.query(".loader", this.domNode)[0];
				//moduleURL creates an object representing an URL which is then set to the loader img src attribute
                this.loaderNode.src = dojo.moduleUrl("com.esri.solutions.jsviewer", "assets/images/loader.gif");
				
				//initialize loader where dojo.query where css class = "paginator"
				this.paginator = dojo.query(".paginator", this.domNode)[0];
				//console.log("paginator"+ this.paginator);
		    }
		    catch (err) { console.error(err); }
		},
		
		startup: function(){
			console.log("TestWidget startup");
		    //super
		    this.inherited(arguments);
			if (!this._initialized) {
				try {
					this.getAllNamedChildDijits();
					//console.dir(this.widgets);
					
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
									
					// Listen to pagination 
					this.connects.push(dojo.connect(this.widgets.paginator,"onPageChange" ,this, "onPageChange"));
	
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
					
					var featureLayer = new esri.layers.FeatureLayer(this.layerUrl, {
    				 outFields: this.queryFields,
 					 mode: esri.layers.FeatureLayer.MODE_SELECTION
					});
					
					var qParams = new esri.tasks.Query();
					qParams.where = this.query;
					
					featureLayer.queryIds(qParams, dojo.hitch(this,function(objectIds) {
             			 this.fetchRecords(objectIds);
            		}));
										
					/*
					var qParams = new esri.tasks.Query();
					qParams.returnGeometry = true;
					qParams.outFields = this.queryFields;
					qParams.where = this.query;
					qParams.outSpatialReference = this.map.spatialReference;
					var task = new esri.tasks.QueryTask(this.layerUrl);
					task.execute(qParams, dojo.hitch(this, "queryCallback"));*/
				}
			}
			catch (err) {
				console.error("LiveLayerWidget::fetchData", err);
			}
		},
		
		fetchRecords: function(objectIds){
			try{
			console.log("fetchRecords is running");
			//console.log(this.widgets);
			//console.log("ObjectIds lenght: " + objectIds.length);
			if (objectIds.length > 0) {
          			this.updatePageInformation(objectIds);					
          			this.queryRecordsByPage(1);
					
					// Display Pagination
					if(objectIds.length > this.rowPerPage){ 
												
						this.totalPage = objectIds.length;
						this.widgets.paginator.setRowPerPage(this.rowPerPage);						
						this.widgets.paginator.setPageInfo(this.currentPage,this.pageInfo.totalPages);						
						//console.log("page info h" + JSON.stringify(this.pageInfo));
						this.widgets.paginator.refresh(); 
						
						dojo.style(this.paginator, "display", "");
					}
					else
					{
						dojo.style(this.paginator, "display", "none");
					}
        	}
			else{
				dojo.style(this.paginator, "display", "none");	
			}
						
				var msg = this.i18nStrings.msgFound;
				msg = dojo.string.substitute(msg, [objectIds.length]);

				this.setMessage(msg);
			}
			catch(err){
				console.error("fetch Record "+ err);
			}
									
		},
		
		updatePageInformation: function(objectIds, page){
			try{
			console.log("updatePageInformation is running");
			this.pageInfo = {
          		objectIds: objectIds,
          		totalRecords: objectIds.length,
          		totalPages: Math.ceil(objectIds.length / this.rowPerPage),
          		currentPage: page || 0,
          		recordsPerPage: this.rowPerPage
       		 };
			 
      		 // dojo.byId("pageInfo").innerHTML = pageInfo.currentPage + "/" + pageInfo.totalPages;
      		 // dojo.byId("recordsInfo").innerHTML = pageInfo.totalRecords;

        		if (this.pageInfo.currentPage > this.pageInfo.totalPages) {
         			 this.queryRecordsByPage(this.pageInfo.currentPage - 1);
      		  }	
			}catch(err){
				 console.error("updatePageInformation : " + err);
			}
					},
		
        queryRecordsByPage: function(pageNumber){
			try{
			console.log("queryRecordsByPage is running");
            // check if the page number is valid
            if (pageNumber < 1 || pageNumber > this.pageInfo.totalPages) {
                return;
            }
            
            //Loading
            //grid.showMessage("Fetching records...");
            
            var begin = this.pageInfo.recordsPerPage * (pageNumber - 1);
            var end = begin + this.pageInfo.recordsPerPage;
            		       
            var featureLayer = new esri.layers.FeatureLayer(this.layerUrl, {
                outFields: this.queryFields,
                mode: esri.layers.FeatureLayer.MODE_SELECTION
            });
            

			 // create the query
            var query = new esri.tasks.Query();
            query.where = this.query;			
			query.objectIds = this.pageInfo.objectIds.slice(begin, end);
            query.outFields = this.queryFields;
			//console.log(JSON.stringify(query));            
						
            // Query for the records with the given object IDs and populate the grid
            featureLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, dojo.hitch(this, function(features){
                this.updateGrid(features, pageNumber);
            }));
			//console.log("sdffds");
			}catch(err){
				console.error("queryRecordsByPage " + err );
			}
           }					
		,
		
        updateGrid: function(features, pageNumber){
			try{
			//console.log("updategrid is running" );
			//console.log(features);
			if (features) {
				console.log("updateGrid is runing");
				var locations = [];
				for (var i = 0; i < features.length; i++) {
					var f = features[i];
					console.log(f);
					var link = null;
					var content = "<table>";
					content += "<tr><td> Cấp hạng </td><td>" + this.tenCapHang(f.attributes['CapHang']) + "</td></tr>";
					content += "<tr><td> Loại mốc </td><td>" + this.tenLoaiMoc(f.attributes['LoaiMoc']) + "</td></tr>";
					content += "<tr><td> Hệ quy chiếu </td><td>" + f.attributes['HeQuyChieu'] + "</td></tr>";
					content += "<tr><td> Năm thành lập </td><td>" + f.attributes['NamThanhLap'] + "</td></tr>";
					content += "<tr><td> Tình trạng </td><td>" + this.tenTinhTrang(f.attributes['TinhTrang']) + "</td></tr>";
					content += "</table>";
					
					var shortcontent = "<table>";
					shortcontent += "<tr><td> Loại mốc </td><td>" + this.tenLoaiMoc(f.attributes['LoaiMoc']) + "</td></tr>";
					shortcontent += "<tr><td> Tình trạng </td><td>" + this.tenTinhTrang(f.attributes['TinhTrang']) + "</td></tr>";
					shortcontent += "</table>";
					
					var attrs = {
						"title": f.attributes[this.titleField],
						"shortcontent": shortcontent,
						"content": content,
						"link": link
					};
					var g = new esri.Graphic(f.geometry, this.symbol, attrs);
					
					var params = {
						title: attrs.title,
						shortcontent: attrs.shortcontent,
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
				
				// update application state
				this.pageInfo.currentPage = pageNumber;
			//dojo.byId("pageInfo").innerHTML = pageInfo.currentPage + "/" + pageInfo.totalPages;
			}	
			}catch(err){
				console.error("updateGrid "+ err);
			}
		}
		,
		
		queryCallback: function(featureSet) {
			try{
			
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
					content+= "</table>";
					
					var shortcontent = "<table>";
					shortcontent+= "<tr><td> Loại mốc </td><td>" + this.tenLoaiMoc(f.attributes['LoaiMoc']) + "</td></tr>";
					shortcontent+= "<tr><td> Tình trạng </td><td>" + this.tenTinhTrang(f.attributes['TinhTrang']) + "</td></tr>";										
					shortcontent+= "</table>";
		            
					var attrs = {
		                "title": f.attributes[this.titleField],
		                "shortcontent": shortcontent,
						"content": content,
		                "link": link
		            };
					var g = new esri.Graphic(f.geometry, this.symbol, attrs);
	
					var params = {
						title: attrs.title,
						shortcontent: attrs.shortcontent,
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
		
			}catch(err){
				console.error("queryCallback "+ err);
			}	},
		
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
		},
		
		onPageChange : function(current){
			console.log("onPageChange is running");
			this.clearResults();
			 this.queryRecordsByPage(current);
		}
	
		
	}
);