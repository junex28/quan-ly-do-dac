// layout
dojo.require("dijit.dijit");
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("dijit.form.Button");
dojo.require("dijit.form.CheckBox");
dojo.require("dijit.Toolbar");
dojo.require("dijit.Tree");
dojo.require("dijit.Menu");
dojo.require("dijit.MenuItem");
dojo.require("dijit.Toolbar");

dojo.require("dojox.grid.DataGrid");
dojo.require("dojox.grid.cells.dijit");

dojo.require("dojo.data.ItemFileReadStore");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dojo.number");

dojo.require("esri.dijit.OverviewMap");
dojo.require("esri.dijit.Measurement");
dojo.require("esri.toolbars.draw");
dojo.require("esri.map");
dojo.require("esri.tasks.query");
dojo.require("esri.layers.FeatureLayer");
dojo.require("esri.tasks.geometry");


var resizeTimer;
var map;    // main map
var basemap;
var enableFeatureLayers = [], visible = [];
var toolbar, toolSymbol;
var result;
var queryGraphics = []; // store select query such as extent, polygon
var loading;
var pageLength = 5, pageInfo;

// Initialiazation
function init() {
    var initExtent = new esri.geometry.Extent({ "xmin": appConfig.service.initialExtent.xmin, "ymin": appConfig.service.initialExtent.ymin, "xmax": appConfig.service.initialExtent.xmax, "ymax": appConfig.service.initialExtent.ymax, "spatialReference": { "wkid": appConfig.service.initialExtent.spatialReference.wkid} });
    map = new esri.Map("mapPanel", { extent: initExtent });
    loading = dojo.byId("loadingImg");  //loading im~age. id

    dojo.connect(map, "onUpdateStart", showLoading);
    dojo.connect(map, "onUpdateEnd", hideLoading);
    loadBaseMap();

    dojo.connect(map, "onLoad", loadFeatureLayers);
    dojo.connect(map, "onLoad", createToolbar);

    dojo.connect(map, 'onLoad', function(map) {
        // MAP RESIZE EVENT
        //dojo.connect(dijit.byId("mapPanel"), "resize", resizeBrowser);
        dojo.connect(dijit.byId('mapPanel'), 'resize', map, map.resize);
        overviewMap();
        initMeasurement(map);
    });

}

/*+++++++++++++++++++++LOADING ICON++++++++++++++++++++++++++++++++++++++++++++*/
function showLoading() {
    esri.show(loading);
    //map.disableMapNavigation();
    map.hideZoomSlider();
}

function hideLoading(error) {
    esri.hide(loading);
    //map.enableMapNavigation();
    map.showZoomSlider();
}
/*+++++++++++++++++++++END LOADING ICON++++++++++++++++++++++++++++++++++++++++*/

function loadBaseMap() {

    basemap = new esri.layers.ArcGISTiledMapServiceLayer(appConfig.service.baseMapService.url);
    map.addLayer(basemap);
    map.infoWindow.resize(appConfig.service.infoWindow.width, appConfig.service.infoWindow.height);

}

//////////////////// LOAD FEATURE LAYER ////////////////////////
function loadFeatureLayers() {
    var featureLayer;
    var i = 0;
    // Add Info Window to Feature Layer
    dojo.forEach(appConfig.service.layerServices.enableLayers, function(id) {
        var url = appConfig.service.featureLayers[id].url;
        var mode = appConfig.service.featureLayers[id].mode;
        var infoTemplate = new esri.InfoTemplate(appConfig.service.featureLayers[id].infoTemplate);
        // init symbol
        var symbol = new esri.symbol.PictureMarkerSymbol(appConfig.service.featureLayers[id].symbol.url, appConfig.service.featureLayers[id].symbol.width, appConfig.service.featureLayers[id].symbol.height);
        featureLayer = new esri.layers.FeatureLayer(url, { mode: mode, outFields: ["*"], infoTemplate: infoTemplate });
        featureLayer.setRenderer(new esri.renderer.SimpleRenderer(symbol));
        map.addLayer(featureLayer);
        enableFeatureLayers.push(featureLayer);

        // All layer hide when initilized
        enableFeatureLayers[i].hide();
        // Initialize GUI checkbox
        dojo.place("<br/><input type='checkbox' dojotype='dijit.form.Checkbox' class='list_item' id='" + i + "' onClick='updateLayerVisibility(" + i + ");' /><label for='" + i + "'> " + appConfig.service.featureLayers[id].title + "</label>", "layer_list", "last");

        i++;
    });
}


function updateLayerVisibility(layerIndex) {
    var inputs = dojo.query(".list_item"), input;

    visible = [];

    dojo.forEach(inputs, function(input) {
        if (input.checked) {
            visible.push(input.id);
        }
    });
    //if there aren't any layers visible set the array to be -1
    if (visible.length === 0) {
        visible.push(-1);
    }

    (enableFeatureLayers[layerIndex].visible) ? enableFeatureLayers[layerIndex].hide() : enableFeatureLayers[layerIndex].show();
}

//////////////////// END LOAD FEATURE LAYER ////////////////////////

//////////////////////////TOOLBAR/////////////////////////////////

function createToolbar(themap) {
    toolbar = new esri.toolbars.Draw(map);
    dojo.connect(toolbar, "onDrawEnd", addToMap);
}

function addToMap(geometry) {
    toolbar.deactivate();
    map.showZoomSlider();
    switch (geometry.type) {
        case "point":
            var toolSymbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE, 10, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255, 0, 0]), 1), new dojo.Color([0, 255, 0, 0.25]));
            break;
        case "polyline":
            var toolSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASH, new dojo.Color([255, 0, 0]), 1);
            break;
        case "polygon":
            var toolSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
            break;
        case "extent":
            var toolSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
            break;
        case "multipoint":
            var toolSymbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_DIAMOND, 20, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0, 0, 0]), 1), new dojo.Color([255, 255, 0, 0.5]));
            break;
    }
    var graphic = new esri.Graphic(geometry, toolSymbol);
    //queryGraphics.push(graphic);
    map.graphics.add(graphic);

    selectFeature(graphic);
}

/////////////////////////END TOOLBAR/////////////////////////////

function selectFeature(graphic) {
    dojo.forEach(visible, function(id) {
        selectFeatureByExtent(id, graphic);
    });
}






/////////////////SELECT QUERY//////////////////////////////////////

//     String id : id in feature visible[].
//     Feature-Graphics extent : filter .         
function selectFeatureByExtent(id, extent) {
    var queryTask, query;

    try {
        queryTask = new esri.tasks.QueryTask(appConfig.service.featureLayers[id].url);

        query = new esri.tasks.Query();
        query.spatialRelationship = esri.tasks.Query.SPATIAL_REL_INTERSECTS;
        if (extent !== null) {

            query.geometry = extent.geometry;

            query.outSpatialReference = { "wkid": appConfig.service.initialExtent.spatialReference.wkid };
            query.returnGeometry = true;
            query.outFields = [appConfig.service.featureLayers[id].outFields];
        
            queryTask.execute(query,displayInGrid);
            // finish query task : delete
            map.graphics.remove(extent);
            dojo.connect(queryTask, "onComplete", function(fset) {

                var resultFeatures = fset.features;
                for (var i = 0, il = resultFeatures.length; i < il; i++) {
                    var graphic = resultFeatures[i];
                    // todo : set symbol
                    var symbolLink = appConfig.service.featureLayers[id].highlight;
                    graphic.setSymbol(getHighlightFromFeature(id));
                    graphic.setInfoTemplate(getTemplateFromFeature(id));
                    map.graphics.add(graphic);
                    queryGraphics.push(graphic);
                    //displayInGrid();        // Display Grid Results
                }
                selectLeftTab("resultTab");
            });
        }
    } catch (err) {
        alert("Error : selectFeatureByExtent is not run");
    }

}



////////////////////OVERVIEW MAP ///////////////////////////////////
function overviewMap() {
    var overviewMapDijit = new esri.dijit.OverviewMap({
        map: map,
        visible: false
    });
    overviewMapDijit.startup();
}
////////////////// END OVERVIEW MAP/////////////////////////////////

//////////////////////////MEASURE/////////////////////////////////
function initMeasurement(mymap) {
    var measurement = new esri.dijit.Measurement({
        map: mymap
    }, dojo.byId('measurementDiv'));
    measurement.startup();
}
////////////////////////// END MEASURE////////////////////////////

///////////////////////////////////////// UTILS ////////////////////////////////////////////////////////////
// Int Id : is the id in list features services on config
// Geometry 
function getSymbolFromFeature(id) {

    var symbolLink = appConfig.service.featureLayers[id].symbol;
    var symbol;

    if (symbolLink.type == '' || symbolLink.type == 1)// Is marker symbol
    {
        switch (symbolLink.geometryType) {
            case "point":
                symbol = new esri.symbol.SimpleMarkerSymbol();
                symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE;
                symbol.setSize(8);
                symbol.setColor(new dojo.Color([255, 255, 0, 0.5]));
                break;
            case "polyline":
                symbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASH, new dojo.Color([255, 0, 0]), 1);
                break;
            case "polygon":
                symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
                break;
            case "extent":
                symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
                break;
            case "multipoint":
                symbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_DIAMOND, 20, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0, 0, 0]), 1), new dojo.Color([255, 255, 0, 0.5]));
                break;
        }
    } else // Is Picture marker            
    {
        switch (symbolLink.geometryType) {
            case "point":

                symbol = new esri.symbol.PictureMarkerSymbol(symbolLink.url, symbolLink.width, symbolLink.height);
                break;
        }
    }

    return symbol;
}

function getHighlightFromFeature(id) {

    var symbolLink = appConfig.service.featureLayers[id].highlight;
    var symbol;

    if (symbolLink.type == '' || symbolLink.type == 1)// Is marker symbol
    {
        switch (symbolLink.geometryType) {
            case "point":
                symbol = new esri.symbol.SimpleMarkerSymbol();
                symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE;
                symbol.setSize(8);
                symbol.setColor(new dojo.Color([255, 255, 0, 0.5]));
                break;
            case "polyline":
                symbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASH, new dojo.Color([255, 0, 0]), 1);
                break;
            case "polygon":
                symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
                break;
            case "extent":
                symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255, 0, 0]), 2), new dojo.Color([255, 255, 0, 0.25]));
                break;
            case "multipoint":
                symbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_DIAMOND, 20, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0, 0, 0]), 1), new dojo.Color([255, 255, 0, 0.5]));
                break;
        }
    } else // Is Picture marker            
    {
        switch (symbolLink.geometryType) {
            case "point":
                symbol = new esri.symbol.PictureMarkerSymbol(symbolLink.url, symbolLink.width, symbolLink.height);
                break;
        }
    }
    return symbol;
}

function getTemplateFromFeature(id) {
    var infoTemplate = new esri.InfoTemplate(appConfig.service.featureLayers[id].infoTemplate);
    return infoTemplate;
}

// get layer name by type
function iLayerType(value) {
    switch (value) {
        case 1: return "Mốc tọa độ"; break;
        case 2: return "Mốc độ cao"; break;
        case 3: return "Mốc trọng lực"; break;
        default: return value;
    }
}

// Return normal, not in selected
function toolbarDeactivate() {
    toolbar.deactivate();
}

// Clear all graphics selected
function reset() {
    // Clear grid
    clearDataGrid();
    // Clear all result on queryGraphics
    queryGraphics.splice(0, queryGraphics.length);
    // Clear all highlight graphics on map
        map.graphics.clear();
}

function selectLeftTab(tabSelected) {
    var tabs = dijit.byId("leftPanel");
    var tabid = dijit.byId(tabSelected);
    tabs.selectChild(tabid);
}

function clearDataGrid() {
    var newStore = new dojo.data.ItemFileReadStore({ data: { identifier: "", items: []} });
    var grid = dijit.byId("grid");
    grid.setStore(newStore);
    grid.update();
}


////////////////PAGINATION///////////////////////////////
function displayInGrid() {
    // if number results > 0 then display toolbol, paginations
    if (queryGraphics.length > 0) {
        updatePageInformation(queryGraphics);
        queryRecordsByPage(1);
    }
    else {
        grid.showMessage("Không có kết quả");
        grid.setStore(null);
    }

}

function updatePageInformation(objectIds, page) {
    pageInfo = {
        objectIds: objectIds,
        totalRecords: objectIds.length,
        totalPages: Math.ceil(objectIds.length / pageLength),
        currentPage: page || 0,
        recordsPerPage: pageLength
    };

    dojo.byId("pageInfo").innerHTML = pageInfo.currentPage + "/" + pageInfo.totalPages;
    dojo.byId("recordsInfo").innerHTML = pageInfo.totalRecords;

    if (pageInfo.currentPage > pageInfo.totalPages) {
        queryRecordsByPage(pageInfo.currentPage - 1);
    }
}

function queryRecordsByPage(pageNumber) {

    // check if the page number is valid
    if (pageNumber < 1 || pageNumber > pageInfo.totalPages) {
        return;
    }

    var grid = dijit.byId('grid');
    grid.showMessage("Đang cập nhật...");

    var begin = pageInfo.recordsPerPage * (pageNumber - 1);
    var end = begin + pageInfo.recordsPerPage;
    alert(begin + " " + end);
    var queryGraphicsPage = queryGraphics.slice(begin, end);
    alert(queryGraphicsPage.length);
    updateGrid(queryGraphicsPage, pageNumber);    
//    // create the query
//    var query = new esri.tasks.Query();
//    query.objectIds = pageInfo.objectIds.slice(begin, end);
//    query.outFields = ["*"];

//    // Query for the records with the given object IDs and populate the grid
//    featureLayer.queryFeatures(query, function(featureSet) {
//        updateGrid(featureSet, pageNumber);
//    });
}

function updateGrid(featureSet, pageNumber) {

    alert("come here");
    //    //Create data store and bind to grid.
    //    gridStore = new dojo.data.ItemFileReadStore({ data: gridData });
    //    var grid = dijit.byId('grid');
    //    grid.setStore(gridStore);
    //    grid.update();
    // create the data store and add it to the grid
  

    var items = dojo.map(featureSet, function(res) {
        res.attributes.LoaiMoc = iLayerType(res.attributes.LoaiMoc);
            return res.attributes;
        });
    
    var  data = {
            identifier: "OBJECTID",  //This field needs to have unique values
            label: "SoHieu", //Name field for display. Not pertinent to a grid but may be used elsewhere.
            items: items
        }

    var store = new dojo.data.ItemFileReadStore({
    data: data
    });

    var grid = dijit.byId('grid');
    grid.setStore(store);
    grid.setSortIndex(2, false); //descending sort on the magnitude field
    grid.update();

    // update application state
    pageInfo.currentPage = pageNumber;
    dojo.byId("pageInfo").innerHTML = pageInfo.currentPage + "/" + pageInfo.totalPages;
}

//////////////////// END TREE RESULT //////////////////////////
dojo.addOnLoad(init);

///////////////////// IDENTIFY ///////////////////


////////////////////////TREE VIEW RESULT ///////////////////////
/*
function createTree() {
result = {
label: 'name',
identifier: 'sohieu',
items: [
{ name: 'Mốc toạ độ', sohieu: '0', type: 'directory', children: [
{ type: 'kq', name: 'XAZ', sohieu: 'XAZ', tinhtrang: 'con tot', year: '1996' },
{ type: 'kq', name: 'XBZ', sohieu: 'XBZ', tinhtrang: 'con tot', year: '2000' }
]
},
{ name: 'Mốc độ cao', sohieu: '1', 'children': [
{ type: 'kq', name: 'YAZ', sohieu: 'YAZ', tinhtrang: 'con tot', year: '1996' },
{ type: 'kq', name: 'YBZ', sohieu: 'YBZ', tinhtrang: 'con tot', year: '2000' }
]}]
}

var store = new dojo.data.ItemFileReadStore({
id: "treeStore",
data: result
});

var treeModel = new dijit.tree.ForestStoreModel({
id: "treeModel",
store: store
});

var tree = new dijit.Tree({
id: "resultTree",
model: treeModel,
showRoot: false,
onClick: function(item, node, evt) {
if (store.getValue(item, 'type') == 'kq') {
//                    var grid = dijit.byId('resDetailTable');                    
//                    grid.setStore(store);
//add info in thong tin table
var data = store.getAttributes(item);
alert(treeModel.getIdentity(item));
}
},
_createTreeNode: function(
args) {
var tnode = new dijit._TreeNode(args);
tnode.labelNode.innerHTML = args.label;
return tnode;
}
},
"resultDiv");
}


*/

/*
var queryTask, query;
var arrtypes = [];
        
var treeresults = {
label: 'name',
identifier: 'sohieu',
items: arrtypes
}
        
        
function selectFeature() {
// for (v in visible) {
var url = appConfig.service.featureLayers[0].url;
queryTask = new esri.tasks.QueryTask(url);
query = new esri.tasks.Query();
query.spatialRelationship = esri.tasks.Query.SPATIAL_REL_INTERSECTS;
query.geometry = queryGraphics[0].geometry;
query.outSpatialReference = { "wkid": 4756 };
query.returnGeometry = true;
query.outFields = ['*'];

queryTask.execute(query, showResults);            
                
dojo.connect(queryTask, "onComplete", function(fset) {
var symbol = new esri.symbol.SimpleMarkerSymbol();
symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE;
symbol.setSize(8);
symbol.setColor(new dojo.Color([255, 255, 0, 0.5]));

var infoTemplate = new esri.InfoTemplate("title", "${*}");

var resultFeatures = fset.features;
for (var i = 0, il = resultFeatures.length; i < il; i++) {
var graphic = resultFeatures[i];
graphic.setSymbol(symbol);
graphic.setInfoTemplate(infoTemplate);
map.graphics.add(graphic);
queryGraphics.push(graphic);
}
});

dojo.byId('debug').innerHTML = "<b>Executing Query with Result Buffer Geometry...</b>";
//  }

}

function selectFeature() {
var queryTask, query;
    
//////////////////// Temporary
//reset();
///////////////////
queryTask = new esri.tasks.QueryTask("http://localhost/ArcGIS/rest/services/Moc/MapServer/0");

query = new esri.tasks.Query();
query.spatialRelationship = esri.tasks.Query.SPATIAL_REL_INTERSECTS;
if (queryGraphics.length > 0) {
            
query.geometry = queryGraphics[0].geometry;

query.outSpatialReference = { "wkid": 4756 };
query.returnGeometry = true;
query.outFields = ['*'];

queryTask.execute(query, showResults);
// finish query task : delete
map.graphics.remove(queryGraphics[0]);
//queryGraphics.pop();
// Callback event
dojo.connect(queryTask, "onComplete", function(fset) {
var resultFeatures = fset.features;
for (var i = 0, il = resultFeatures.length; i < il; i++) {
var graphic = resultFeatures[i];
// todo : set symbol
var symbolLink = appConfig.service.featureLayers[0].highlight;
graphic.setSymbol(getHighlightFromFeature(0));
graphic.setInfoTemplate(getTemplateFromFeature(0));
map.graphics.add(graphic);
}
});    

}
}

function showResults(results) {
var s = "";

// String output
for (var i = 0, il = results.features.length; i < il; i++) {
var featureAttributes = results.features[i].attributes;
for (att in featureAttributes) {
s = s + "<b>" + att + ":</b>  " + featureAttributes[att] + "<br />";
}
}
dojo.place(s, 'debug', 'after');    
}
*/