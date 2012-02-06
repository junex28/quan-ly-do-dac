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

dojo.provide("com.esri.solutions.jsviewer.widgets.SearchWidget");

dojo.require("com.esri.solutions.jsviewer._BaseWidget");
dojo.require("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

// I18N
dojo.require("dojo.string");
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer.widgets", "SearchWidgetStrings");

// for GUI purposes
dojo.require("dijit.form.Button");
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.FilteringSelect");
dojo.require("esri.tasks.geometry");
dojo.require("com.esri.solutions.jsviewer.ResultList");

dojo.require("com.esri.solutions.jsviewer.util");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.SearchWidget",
	[com.esri.solutions.jsviewer._BaseWidget, com.esri.solutions.jsviewer._MapGraphicsMaintainer],
	{
		constructor: function(/*Object*/ params) {
			this.layers = [];
			this.districts = [];
		},
		
		templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/SearchWidget.html"),
		
		_initialized: false,
		
		iconUrl: "",
		smallIconUrl: "",
		symbol: null,
		zoomScale: 100000,
		pinIcon: "",
		
		loaderNode: null,
		messageNode: null,
		
		i18nStrings: null,
		
		postMixInProperties: function() {
			try {
				this.inherited(arguments);
	
				if (this.configData) {
					this.zoomScale = this.configData.search.zoomScale;
					this.pinIcon = this.configData.search.pinIcon;
					// Layers are read from config in startup
				}
				
				// Init i18n
				this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer.widgets", "SearchWidgetStrings");
			}
			catch (err) { console.error(err); }		
		},
		
		postCreate: function() {
			try {
				this.inherited(arguments);

				dojo.parser.parse(this.domNode);
				
				// Init the icons on the toolbuttons
				var buttons = dojo.query(".toolbutton", this.domNode);
				buttons.forEach(function(item,idx,arr){
					var icon = dojo.moduleUrl("com.esri.solutions.jsviewer", dojo.attr(item, "buttonIcon"));
					dojo.style(item, "backgroundImage", "url(" + icon + ")");
				});

				// Init the loader animation
				this.loaderNode = dojo.query(".loader", this.domNode)[0];
				this.loaderNode.src = dojo.moduleUrl("com.esri.solutions.jsviewer", "assets/images/loader.gif");
			}
			catch (err) { console.error(err); }
		},
		
		startup: function() {
			this.inherited(arguments);
			if (this._initialized) { return; }

			try {
				this.getAllNamedChildDijits();
				
				// Attach events
				this.connects.push(dojo.connect(this.widgets.btnSearchText, "onClick", this, "onTextSearch"));
				this.connects.push(dojo.connect(this.widgets.btnClearText, "onClick", this, "onTextClear"));
				this.connects.push(dojo.connect(this.widgets.btnStateSearch, "onClick", this, "onStateSearch"));
				
				this.connects.push(dojo.connect(this.widgets.cboGraphicSearch, "onChange", this, "onGraphicSearchLayerChange"));
				this.connects.push(dojo.connect(this.widgets.cboTextSearch, "onChange", this, "onTextSearchLayerChange"));
				this.connects.push(dojo.connect(this.widgets.cboBufferSearch, "onChange", this, "onBufferSearchLayerChange"));
				
				// Linear units dropdown
				var distUnitData = {
					identifier: "val",
					label: "unitName",
					items: []
				};
				dojo.forEach(com.esri.solutions.jsviewer.util.measure.knownDistanceUnits, dojo.hitch(this, function(unit) {
					if (this.i18nStrings["distUnit" + unit]) {
						var item = {
							"unit": unit,
							"unitName": this.i18nStrings["distUnit" + unit],
							"abbr": this.i18nStrings["abbrDistUnit" + unit],
							"val": this.i18nStrings["valDistUnit" + unit]
						};
						distUnitData.items.push(item);
					}
				}));
				
				var dataStoreD = new dojo.data.ItemFileReadStore({
					data: distUnitData
				});
				
				// Apply datastore to cboBufferSearchUnit widget
				this.widgets.cboBufferSearchUnit.store = dataStoreD;
				this.widgets.cboBufferSearchUnit.searchAttr = "unitName";
				this.widgets.cboBufferSearchUnit.set('value','UNIT_METER');
				
				// Search Layers dropdowns
				var graphicSearchLayerData = {
					identifier: "name",
					label: "name",
					items: []
				};
				var textSearchLayerData = {
					identifier: "name",
					label: "name",
					items: []
				};
				var stateSearchLayerData = {
					identifier: "name",
					label: "name",
					items: []
				};
				var districtSearchLayerData = {
					identifier: "name",
					label: "name",
					items: []
				};				
				var bufferSearchLayerData ={
					identifier: "name",
					label: "name",
					items: []					
				}; 
				
				var gInitValue = null;
				var tInitValue = null;
				var sInitValue = null;
				var bInitValue = null;
				
				dojo.forEach(this.configData.search.layers, dojo.hitch(this, function(layer) {
					if (layer.graphicalSearch) {
						graphicSearchLayerData.items.push(dojo.clone(layer));
						gInitValue = layer.name;
					}
					if (layer.expression) {
						textSearchLayerData.items.push(dojo.clone(layer));
						tInitValue = layer.name;
					}
					if (layer.districtSearch){
						stateSearchLayerData.items.push(dojo.clone(layer));
						sInitValue = layer.name;
					}
					if (layer.bufferSearch){
						bufferSearchLayerData.items.push(dojo.clone(layer));
						bInitValue = layer.name;							
					}					
					// Store the config for the layer
					this.layers[layer.name] = layer;
				}));
				
				// Load data to districtSearchLayerData	
				var urlDistrict = this.configData.search.districtLayer;
				if(urlDistrict){
					this.loadListDistrict(urlDistrict);				
				}
					
				var graphicSearchDataStore = new dojo.data.ItemFileReadStore({
					data: graphicSearchLayerData
				});
				var textSearchDataStore = new dojo.data.ItemFileReadStore({
					data: textSearchLayerData
				});
				var stateSearchDataStore = new dojo.data.ItemFileReadStore({
					data: stateSearchLayerData
				});	
				var bufferSearchDataStore = new dojo.data.ItemFileReadStore({
					data: bufferSearchLayerData
				});	
				
			
				// Apply datastores to widgets
				this.widgets.cboGraphicSearch.store = graphicSearchDataStore;
				this.widgets.cboGraphicSearch.searchAttr = "name";
				this.widgets.cboGraphicSearch.set("value",gInitValue);

				this.widgets.cboTextSearch.store = textSearchDataStore;
				this.widgets.cboTextSearch.searchAttr = "name";
				this.widgets.cboTextSearch.set("value",tInitValue);
				
				this.widgets.cboStateSearch.store = stateSearchDataStore;
				this.widgets.cboStateSearch.searchAttr = "name";
				this.widgets.cboStateSearch.set("value",sInitValue);
				
				this.widgets.cboBufferSearch.store = bufferSearchDataStore;
				this.widgets.cboBufferSearch.searchAttr = "name";
				this.widgets.cboBufferSearch.set("value",bInitValue);
							
				// Init the map graphic symbol
				this.iconUrl = dojo.moduleUrl("com.esri.solutions.jsviewer", this.pinIcon).path;
				this.smallIconUrl = com.esri.solutions.jsviewer.util.getSmallIcon(this.iconUrl);
				// Create map symbols
				this.symbols = {
					point: new esri.symbol.PictureMarkerSymbol(this.iconUrl, 40, 40),
					line: new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0,255,255]), 2),
					polygon: new esri.symbol.SimpleFillSymbol(
						esri.symbol.SimpleFillSymbol.STYLE_SOLID,
						new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0,255,255]), 2),
						new dojo.Color([0,255,255,0.5]))
				};
				
				// Grab the message node for future use
				this.messageNode = dojo.query(".resultsMsg", this.domNode)[0];
				this.setMessage(this.i18nStrings.msgReady);
				
				// Listen to result selection messages
				this.connects.push(dojo.connect(this.widgets.results, "onResultClick", this, "onResultClick"));
				this.connects.push(dojo.connect(this.widgets.results, "onResultHover", this, "onResultHover"));
				this.clearResults();

				this._initialized = true;
			}
			catch (err) {
				console.error("SearchWidget::startup", err);
			}
		},
		
		shutdown: function() {
			this.clearResults();
			dojo.publish("widgetHighlightEvent", [null]);
			this.inherited(arguments);
		},
		
		setMessage: function(/*String*/ message, /*boolean*/ showLoading) {
			this.messageNode.innerHTML = message;
			
			if (showLoading) {
				dojo.style(this.loaderNode, "visibility", "visible");
			}
			else {
				dojo.style(this.loaderNode, "visibility", "hidden");
			}
		},
		
		clearResults: function() {
			this.widgets.results.clear();
			this.clearGraphics();
		},
		
		onToolButtonClick: function(evt) {
			console.log(JSON.stringify(evt));
			if (evt && evt.target) {
				var params = {
					onDrawEnd: dojo.hitch(this, function(geometry) { this.searchGeometry(geometry); }),
					label: evt.target.title
				};
				
				switch (evt.target.title) {
					case (this.i18nStrings.msgSearchPoint):
						params.geometryType = esri.toolbars.Draw.POINT;
						break;
					case (this.i18nStrings.msgSearchLine):
						params.geometryType = esri.toolbars.Draw.POLYLINE;
						break;
					case (this.i18nStrings.msgSearchRect):
						params.geometryType = esri.toolbars.Draw.EXTENT;
						break;
					case (this.i18nStrings.msgSearchPolygon):
						params.geometryType = esri.toolbars.Draw.POLYGON;
						break;
					case (this.i18nStrings.msgSearchClear):
						this.clearResults();
						return;
					default:
						console.error("Unknown toolbutton pressed: " + evt.target.title);
						return;
				}
				dojo.publish("widgetDrawRequestEvent", [params]);
			}
		},
		
		onGraphicSearchLayerChange: function(newValue) {
			var msg = this.i18nStrings.promptGraphicSearch;
			msg = dojo.string.substitute(msg, [newValue]);
			this.graphicSearchPrompt.innerHTML = msg;
		},
		
		onTextSearchLayerChange: function(newValue) {
			var msg = this.i18nStrings.promptTextSearch;
			
			var store = this.widgets.cboGraphicSearch.store;
			store.fetchItemByIdentity({
				identity: newValue,
				onItem: dojo.hitch(this, function(item,request) {
					var textSearchField = store.getValue(item, "textSearchField");
					var textSearchSampleValue = store.getValue(item, "textSearchSampleValue");
					msg = dojo.string.substitute(msg, [newValue, textSearchField, textSearchSampleValue]);
					this.textSearchPrompt.innerHTML = msg;
				})
			});
		},
		/**** Search by district ****/
				
		onStateSearch: function(evt){	
			this.getDistrictGeometry();
		},
		
		getDistrictGeometry: function(){
			//console.log("getDistrictGeometry");
			var districtId  = this.widgets.cboDistrictSearch.get("value");
			//console.log(districtId); 
			if(districtId){
				var url = this.configData.search.districtLayer;
				var task = new esri.tasks.QueryTask(url);
				
				var q = new esri.tasks.Query();
				q.returnGeometry = true;
				q.outFields = ["OBJECTID","NAME_3"];
				q.outSpatialReference = this.map.spatialReference;
				var expr = "OBJECTID=[value]";
				expr = expr.replace("[value]", this.widgets.cboDistrictSearch.get("value"));
				q.where = expr;
				try{
					task.execute(q,dojo.hitch(this,"districtSearchMoc"));
				}catch(err){
					console.error("getDistrictGeometry",err);
				}	
			}	
		},
		
		districtSearchMoc: function(featureSet){			
			if (featureSet) {
				//console.log(JSON.stringify(featureSet));
				var districtGeometry = featureSet.features[0].geometry;
				console.log(districtGeometry);
				var layer = this.layers[this.widgets.cboStateSearch.get("value")];
				if (layer) {
					var url = layer.url;
					var task = new esri.tasks.QueryTask(url);
					var q = new esri.tasks.Query();
					q.returnGeometry = true;
					q.outFields = layer.fields;
					q.outSpatialReference = this.map.spatialReference;
					q.geometry = districtGeometry;
					try{
							task.execute(q,dojo.hitch(this,"searchCallback",layer.name));
							this.setMessage(this.i18nStrings.msgSearch, true);
							this.clearResults();
							this.onShowPanel(4);								
					}catch(err){
						console.error("districtSearchMoc",err);
					}
				}
				
			}
		}
		,
		loadListDistrict: function(url){
			if(url){
				var task = new esri.tasks.QueryTask(url);
				var q = new esri.tasks.Query();
				q.returnGeometry = false;
				q.outFields = ["OBJECTID","NAME_3"];
				q.outSpatialReference = this.map.spatialReference;				
				q.where = 'OBJECTID>0';
				try {
					//task.execute(q, this.populateListDistrict);
					var districts = task.execute(q, dojo.hitch(this,function(featureSet){
						//console.log(JSON.stringify(featureSet));
						var items = dojo.map(featureSet.features,function(result){
							var name = result.attributes.NAME_3;
			     			var id = result.attributes.OBJECTID;
							return {
								id:id,
				 				name: name
				 			};
		        			});
					//console.log(JSON.stringify(items))
					var districtLayerData = {
					identifier: "id",
					label: "name",
					items: items
					};	
			
					var districtDataStore = new dojo.data.ItemFileReadStore({
					data: districtLayerData
					});
					
					var dInitValue = "1";
					this.widgets.cboDistrictSearch.store = districtDataStore;
					this.widgets.cboDistrictSearch.searchAttr = "name";
					this.widgets.cboDistrictSearch.set("value",dInitValue);
		
					}));
				}
				catch (err) {
					console.error("loadListDistrict", err);
				}			
			}
		},
		/**** End search by district ****/
		
		onTextSearch: function(evt) {
			var layer = this.layers[this.widgets.cboTextSearch.getValue()];
			if (layer) {
				var url = layer.url;
				var task = new esri.tasks.QueryTask(url);
				
				var q = new esri.tasks.Query();
				q.returnGeometry = true;
				q.outFields = layer.fields;
				q.outSpatialReference = this.map.spatialReference;
				var expr = layer.expression;
				expr = expr.replace("[value]", this.widgets.textSearch.getValue());
				q.where = expr;
				
				try {
					task.execute(q, dojo.hitch(this, "searchCallback", layer.name));
					this.setMessage(this.i18nStrings.msgSearch, true);
					this.clearResults();
					this.onShowPanel(4);
				}
				catch (err) {
					console.error("onTextSearch", err);
				}
			}
		},
		
		onTextClear: function(evt) {
			this.widgets.textSearch.setValue("");
		},
		
		searchGeometry: function(geometry) {
			console.log(geometry);
			var layer = this.layers[this.widgets.cboGraphicSearch.getValue()];
			if (layer) {
				var url = layer.url;
				var task = new esri.tasks.QueryTask(url);
				
				var q = new esri.tasks.Query();
				q.returnGeometry = true;
				q.outFields = layer.fields;
				q.outSpatialReference = this.map.spatialReference;
				q.geometry = geometry;
				
				try {
					task.execute(q, dojo.hitch(this, "searchCallback", layer.name));
					this.setMessage(this.i18nStrings.msgSearch, true);
					this.clearResults();
					this.onShowPanel(4);
				}
				catch (err) {
					console.error("searchGeometry", err);
				}
			}
		},
		
		searchCallback: function(layerId, featureSet) {
			console.log("searchCallback");
			try {
				// Create graphics, list items
				var resultCountBeforeAddingThese = this.widgets.results.count;
				var isUrl = com.esri.solutions.jsviewer.util.isUrl;
				
				dojo.forEach(featureSet.features, dojo.hitch(this, function(f){
					var layer = this.layers[layerId];
					
					// Content
					var link = null;
					var content = "<table>";
					content+= "<tr><td> Cấp hạng </td><td>" + this.tenCapHang(f.attributes['CapHang']) + "</td></tr>";
					content+= "<tr><td> Loại mốc </td><td>" + this.tenLoaiMoc(f.attributes['LoaiMoc']) + "</td></tr>";
					content+= "<tr><td> Hệ quy chiếu </td><td>" + f.attributes['HeQuyChieu'] + "</td></tr>";
					content+= "<tr><td> Năm thành lập </td><td>" + f.attributes['NamThanhLap'] + "</td></tr>";
					content+= "<tr><td> Tình trạng </td><td>" + this.tenTinhTrang(f.attributes['TinhTrang']) + "</td></tr>";										
					content += "</table>";
					
					var shortcontent = "<table>";
					shortcontent+= "<tr><td> Loại mốc </td><td>" + this.tenLoaiMoc(f.attributes['LoaiMoc']) + "</td></tr>";
					shortcontent+= "<tr><td> Tình trạng </td><td>" + this.tenTinhTrang(f.attributes['TinhTrang']) + "</td></tr>";										
					shortcontent += "</table>";
					/*
					for (var fIdx in layer.fields) {
						var field = layer.fields[fIdx];
						if (field === layer.linkField) {
							link = f.attributes[field];
						}
						else if (field !== layer.titleField) {
							content += "<tr><td>" + field + ":</td><td>" + f.attributes[field] + "</td></tr>";
						}
					}
					content += "</table>";*/
					
		            var attrs = {
		                "title": f.attributes[layer.titleField],
						"shortcontent":shortcontent,
		                "content": content,
		                "link": link
		            };
					
					var sym = null;
					var loc = null;
					switch (f.geometry.type) {
						case "point":
							sym = this.symbols.point;
							loc = f.geometry;
							break;
						case "multipoint":
							sym = this.symbols.point;
							loc = f.geometry.getExtent().getCenter();
							break;
						case "polyline":
							sym = this.symbols.line;
							var nPts = f.geometry.paths[0].length;
							var idx = Math.round(nPts / 2);
							loc = f.geometry.getPoint(0, idx);
							break;
						default:
							sym = this.symbols.polygon;
							// For multiring geometries, choose one
							if (f.geometry.rings && f.geometry.rings.length > 1) {
								var p = new esri.geometry.Polygon(f.geometry.spatialReference);
								p.addRing(f.geometry.rings[0]);
								var ext = p.getExtent();
								loc = ext.getCenter();
							}
							else {
								var ext = f.geometry.getExtent();
								loc = ext.getCenter();
							}
							break;
					}
					
					var g = new esri.Graphic(f.geometry, sym, attrs);
					var zoomScale = this.zoomScale;
					if (layer.zoomScale) {
						zoomScale = layer.zoomScale;
					}
					
					this.widgets.results.add({
						title: attrs.title,
						shortcontent: attrs.shortcontent,
						content: attrs.content,
						iconUrl: this.smallIconUrl,
						graphic: g,
						location: loc,
						link: attrs.link,
						zoomScale: zoomScale
					});
					this.addGraphic(g);
				}));
				
				var msg = this.i18nStrings.msgFound;
				msg = dojo.string.substitute(msg, [this.widgets.results.count]);
				this.setMessage(msg);
				
				if (resultCountBeforeAddingThese === 0) {
					this.widgets.results.selectFirstItem();
				}
			}
			catch (err) {
				console.error("SearchWidget::searchCallback", err);
			}
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
		
		/***** Buffer Search *****/
		onBufferSearchLayerChange: function(newValue){
			var msg = this.i18nStrings.promptBufGraphicSearch;
			msg = dojo.string.substitute(msg, [newValue]);
			this.bufgraphicSearchPrompt.innerHTML = msg;
	
		},
		
		onBufToolButtonClick: function(evt) {
			console.log(JSON.stringify(evt));
			if (evt && evt.target) {
				var params = {
					onDrawEnd: dojo.hitch(this, function(geometry) { this.doBuffer(geometry); }),
					label: evt.target.title
				};
				
				switch (evt.target.title) {
					case (this.i18nStrings.msgSearchPoint):
						params.geometryType = esri.toolbars.Draw.POINT;
						break;
					case (this.i18nStrings.msgSearchLine):
						params.geometryType = esri.toolbars.Draw.POLYLINE;
						break;
					case (this.i18nStrings.msgSearchRect):
						params.geometryType = esri.toolbars.Draw.EXTENT;
						break;
					case (this.i18nStrings.msgSearchPolygon):
						params.geometryType = esri.toolbars.Draw.POLYGON;
						break;
					case (this.i18nStrings.msgSearchClear):
						this.clearResults();
						return;
					default:
						console.error("Unknown toolbutton pressed: " + evt.target.title);
						return;
				}
				dojo.publish("widgetDrawRequestEvent", [params]);
			}
		},
		
        doBuffer: function(geometry){
        	
		switch (geometry.type) {
         case "point":
           var symbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE, 10, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,0,0]), 1), new dojo.Color([0,255,0,0.25]));
           break;
         case "polyline":
           var symbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASH, new dojo.Color([255,0,0]), 1);
           break;
         case "polygon":
           var symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_NONE, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255,0,0]), 2), new dojo.Color([255,255,0,0.25]));
           break;
		 case "extent":
		  var symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_NONE, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255,0,0]), 2), new dojo.Color([255,255,0,0.25]));
           break;
      }
	  		var graphic = new esri.Graphic(geometry, symbol);
     		this.addGraphic(graphic);

            //setup the buffer parameters
            var params = new esri.tasks.BufferParameters();
            var diameter = this.widgets.textBufDiameter.get("value");
            
            var urlGS = this.configData.search.geometryService;
            try {
                if (urlGS) {					
                    var gsvc = new esri.tasks.GeometryService(urlGS);
                }
                //check is integer 
                if (diameter) 
             	params.distances = [parseInt(diameter)];				
				params.bufferSpatialReference = new esri.SpatialReference({wkid: this.configData.search.bufferWKID});
                params.outSpatialReference = this.map.spatialReference;
                params.unit = eval("esri.tasks.GeometryService." + this.widgets.cboBufferSearchUnit.get("value"));
                
				
                if (geometry.type === "polygon") {
                    //if geometry is a polygon then simplify polygon.  This will make the user drawn polygon topologically correct.
                    gsvc.simplify([geometry], dojo.hitch(this,function(geometries){
                        params.geometries = geometries;
						console.log(JSON.stringify(params));
                        gsvc.buffer(params, dojo.hitch(this,"showBuffer"));
                    }));
                }
                else {
                    params.geometries = [geometry];
					console.log(JSON.stringify(params));
                    gsvc.buffer(params, dojo.hitch(this,"showBuffer"));
                }
            } 
            catch (err) {
                console.error("doBuffer", err);
            }
        },
		
        showBuffer: function(bufferedGeometries){
			
			var symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255, 0, 0, 0.65]), 2), new dojo.Color([255, 0, 0, 0.35]));        
			console.log(JSON.stringify(bufferedGeometries));
			try{
            dojo.forEach(bufferedGeometries, dojo.hitch(this,function(geometry){
                var layer = this.layers[this.widgets.cboBufferSearch.get("value")];
				if (layer) {
					var url = layer.url;
					var task = new esri.tasks.QueryTask(url);
					var q = new esri.tasks.Query();
					q.returnGeometry = true;
					q.outFields = layer.fields;
					q.outSpatialReference = this.map.spatialReference;
					q.geometry = geometry;
					
					task.execute(q, dojo.hitch(this, "searchCallback", layer.name));
					this.setMessage(this.i18nStrings.msgSearch, true);
					this.clearResults();
					this.onShowPanel(4);
				}
				
				var g = new esri.Graphic(geometry, symbol);
                this.addGraphic(g);
				
				
            }));
            }
            catch(err){
				console.error("showBuffer",err);
			}
        }
		
				
		/***** End Buffer Search *****/		
		,					
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
		}
		
		
	}
);