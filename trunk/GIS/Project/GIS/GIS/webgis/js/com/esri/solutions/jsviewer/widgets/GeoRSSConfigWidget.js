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
dojo.provide("com.esri.solutions.jsviewer.widgets.GeoRSSConfigWidget");

dojo.require("com.esri.solutions.jsviewer.widgets.GeoRSSWidget");

//dijits used in template
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.Button");
dojo.require("dijit.form.FilteringSelect");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.GeoRSSConfigWidget",
	com.esri.solutions.jsviewer.widgets.GeoRSSWidget, 
	{
	    //lifecycle:  preamble (dojo.declare), constructor (dojo.declare), postMixInProperties (dijit._Widget), buildRendering (dijit._Widget)
	    //postCreate (dijit._Widget), startup (dijit._Widget), destroyREcorusive (dijit._Widget), uninitialize (dijit._Widget)
	
	    //override to perform custom behaviour during dijit construction
	    //use to initialize dijit properties that are not primitive types
	    //add any additional properties relied upon by other lifecycle methods downstream
	    constructor: function(/*Object*/ params) {
		},
		
		//separate template file versus inline tempalte creation
		templatePath:  dojo.moduleUrl("com.esri.solutions.jsviewer", "widgets/templates/GeoRSSConfigWidget.html"),
		
		//dijit properties
		
		// Don't allow data fetches unless the user requests it
		allowDataFetch: false,
		
		
		//called after inheritance hierachy walked, all ancestors to class are mixed in, class now has access to all inherited properties
	    //manipulate visual elements here as this is called before dijit becomes visible on screen, modify or derive placeholders here
	    postMixInProperties: function() {
		    //super
			this.inherited(arguments);
		},	
		
		//executes once dijit has been created and visibly placed, child dijits are not safely accessible here use startup instead
		postCreate: function(){
	        //super
	        this.inherited(arguments);
		},
		
		
		
		startup: function(){
		    //super
			var initialized = this._initialized;
		    this.inherited(arguments);
			
			// Only short circuit if initialized was set before the super was called
			if (initialized) { return; }
			
		    try{				
				// Attach button click event
				dojo.connect(this.widgets.btnGeoRSSbutton, "onClick", this, "onGetGeoRSS");
				dojo.connect(this.widgets.btnClearRSS, "onClick", this, "onRSSClear");
                
                //write the default configuration RSS URL to the textbox
                this.widgets.GeoRSSurl.setValue(this.feedUrl);
                
				this._initialized = true;
		        
		    }
		    catch (err) { console.error(err); }
		},
		
		
		shutdown: function() {
			this.inherited(arguments);
		},

		fetchData: function() {
			if (this.allowDataFetch) {
				this.inherited(arguments);
			}
		},

		
		onGetGeoRSS: function(evt) {
			this.feedUrl = this.widgets.GeoRSSurl.getValue();
			this.onShowPanel(1);
			this.allowDataFetch = true;
			this.fetchData();
		},
		
		
		onRSSClear:  function(evt) {
		    this.widgets.GeoRSSurl.setValue("");
			this.allowDataFetch = false;
			this.clearResults();
		}		
	}
	
);
