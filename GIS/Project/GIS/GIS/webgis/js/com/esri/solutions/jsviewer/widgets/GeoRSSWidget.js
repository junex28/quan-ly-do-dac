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
dojo.provide("com.esri.solutions.jsviewer.widgets.GeoRSSWidget");

dojo.require("com.esri.solutions.jsviewer.widgets._XmlFeedWidget");

dojo.declare(
	"com.esri.solutions.jsviewer.widgets.GeoRSSWidget",
	[com.esri.solutions.jsviewer.widgets._XmlFeedWidget],
	{
	    //lifecycle:  preamble (dojo.declare), constructor (dojo.declare), postMixInProperties (dijit._Widget), buildRendering (dijit._Widget)
	    //postCreate (dijit._Widget), startup (dijit._Widget), destroyREcorusive (dijit._Widget), uninitialize (dijit._Widget)
	
	    //override to perform custom behaviour during dijit construction
	    //use to initialize dijit properties that are not primitive types
	    //add any additional properties relied upon by other lifecycle methods downstream
	    constructor: function(/*Object*/ params) {
			this.spatialReference = new esri.SpatialReference({wkid:4326});
		},		
		
		onLoad: function(response, ioArgs) {
			// Overrides _XmlFeedWidget.onLoad
			console.log("GeoRSSWidget::onLoad");
			console.debug(response);
         
			var feedNode = this.getFeedRoot(response);
			var feedNodeName = feedNode.nodeName;
			
			//if feedNodeName == feed then Atom, == rdf then RSS 1.0, if == rss then RSS 2.0
			
			var geoRssType = this.getAttribute(feedNode, "xmlns:georss");
			//W3C uses "xmlns:geo"
			if(geoRssType == null){
			    geoRssType = this.getAttribute(feedNode, "xmlns:geo");
			}
			//console.log(geoRssType);
			var rssGML = this.getAttribute(feedNode, "xmlns:gml");
			var urlBase = this.getAttribute(feedNode, "xml:base");
			//console.log("feed base: " + urlBase);
			 
	        var features = [];
	        
	        var entryNodes = null;
	        //all items have the tag "entry" and live under the "feed" node
	        if(feedNodeName == "feed"){
	            entryNodes = this.getNodes("feed", "entry", response);
	            //console.log("atom");
	        }
	        //all items have the tag "item" and live under the "rdf" node
	        else if(feedNodeName == "rdf"){
	            entryNodes = this.getNodes("rdf", "item", response);
	            //console.log("rss 1");
	        }
	        //all item have the tag "item" and liver under the "channel" node which is the child node of rss
	        else if(feedNodeName == "rss"){
	            entryNodes = this.getNodes("channel", "item", response);
	            //console.log("rss 2");
	        }
	        
	        //var entryCount = entryNodes.length;
	        //console.log(entryCount);
	   
	        entryNodes.forEach(dojo.hitch(this, function(node,idx, arr){
	         
	            var allEntryChildren = this.getAllNodes(node);
	            //console.log(allEntryChildren.length);
	            var title;
	            var link;
	            var description;
	            var point;
	            allEntryChildren.forEach(dojo.hitch(this, function(enode, eidx, earr){
	                //title is the same across all RSS formats
	                if(enode.nodeName == "title"){
	                    title = enode.firstChild.nodeValue;
	                    //console.log("title: " + title);
	                }
	                //if Atom = summary, in RSS 1,2 = description
	                if(feedNodeName == "feed"){
	                    if(enode.nodeName == "summary"){
	                        description = enode.firstChild.nodeValue;
	                        //console.log("desc: " + description);
	                    }
	                }
	                else{
	                    if(enode.nodeName == "description"){
	                        description = enode.firstChild.nodeValue;
	                        //console.log("desc: " + description);
	                    }
	                }
	                //in Atom link is an href attribute, RSS 1,2 it is the content of link
	                if(enode.nodeName == "link"){
	                    if(feedNodeName == "feed"){ //is atom
                            if((urlBase != null) && (urlBase != "")){
                                link = urlBase + this.getAttribute(enode, "href");
                                //console.log("link: " + link);
                            }
                            else{
                                link = this.getAttribute(enode, "href");
                                //console.log("link: " + link);
                            }
                        }
                        else{ //is rss 1 or 2
                            if((urlBase != null) && (urlBase != "")){
                                //console.log("isbase");
                                link = urlBase + enode.firstChild.nodeValue;
                                //console.log("link: " + link);
                            }
                            else{
                                //console.log("isnotbase");
                                link = enode.firstChild.nodeValue;
                                //console.log("link: " + link);
                            }
                        }
	                }
	                //GML RSS
	                if(rssGML == "http://www.opengis.net/gml"){
	                    if(enode.nodeName == "georss:where"){
	                        point = this.getGMLGRSSPoint(enode);
	                        //console.log("gml");
	                    }
	                }
	                //Simple
	                else if(geoRssType == "http://www.georss.org/georss"){
	                    if(enode.nodeName == "georss:point"){
	                        point = this.getSimpleGRSSPoint(enode);
	                        //console.log("simple");
	                    }
	                }
	                //WC3
	                else if(geoRssType == "http://www.w3.org/2003/01/geo/wgs84_pos#"){
	                    if(enode.nodeName == "geo:lat"){
	                        //console.log("start w3c");
	                        point = this.getW3CGRSSPoint(enode);
	                        //console.log("w3c");
	                    }
	                }
	            }));
	            
	            var attrs = {
	                "title": title,
	                "content": description,
	                "link": link
	            };
				var g = new esri.Graphic(point, this.symbol, attrs);
				features.push(g);
	            
	        }));
			
			// Project the results
			console.dir(features);
			this.projectShapes(features, this.map.spatialReference, dojo.hitch(this, "projectCallback"));
	    },
		
		projectCallback: function(/*Graphic[]*/ features) {
			console.log("projectCallback");
			var locations = [];
			
			dojo.forEach(features, dojo.hitch(this, function(g) {
				var attrs = g.attributes;
				
				var params = {
					title: attrs.title,
					content: attrs.content,
					iconUrl: this.smallIconUrl,
					graphic: g,
					location: g.geometry,
					link: attrs.link,
					zoomScale: this.zoomScale
				};
				this.widgets.results.add(params);
				
	            this.addGraphic(g);
	            locations.push(params);
			}));
			
			var msg = this.i18nStrings.msgFound;
			msg = dojo.string.substitute(msg, [features.length]);
	        this.setMessage(msg);
	        
	        //this.widgets.results.selectFirstItem();
				
			dojo.publish("widgetLocationsChangedEvent", [{source: this.title, locations: locations}]);
		},
	    
	    
	    getSimpleGRSSPoint:  function(/*node*/ entryNode){
	        
	        var stringPoint = entryNode.firstChild.nodeValue;
	        var coords = stringPoint.split(" ");
	        var p = new esri.geometry.Point(coords[1], coords[0], this.spatialReference);
	        return p;
	    },
	    
	    getGMLGRSSPoint:  function(/*node*/ entryNode){
	       
            
            var pointNode = this.getNonTextNodeChild(entryNode);
         
            var posNode = this.getNonTextNodeChild(pointNode);
            //console.log(posNode.node);
            
            var gmlPosNodeValue = posNode.firstChild.nodeValue;
            
            var coords = gmlPosNodeValue.split(" ");
            var p = new esri.geometry.Point(coords[1], coords[0], this.spatialReference);
            return p;

	    },
	    
	    getNonTextNodeChild: function(/*DOMnode*/ node){
	        var childNodes = node.childNodes;
		    for(var i = 0; i < childNodes.length; i++){
		        if(childNodes[i].nodeType != 3){
		            return childNodes[i];
		        }
		    }
	        
	    },
	    
	    getW3CGRSSPoint:  function(/*node*/ latNode){
	     
            var longNode = latNode.nextSibling;
           
            if(latNode.nextSibling.nodeName == "#text"){
                longNode = latNode.nextSibling.nextSibling; 
            }
           
        
            
            var lat = latNode.firstChild.nodeValue;
            
            var lon = longNode.firstChild.nodeValue;
            var p = new esri.geometry.Point(lon, lat, this.spatialReference);
            return p;

	    },
	    
	    getFeedRoot:  function(/*document*/ response){
	          //var childNodes = node.childNodes;
		        //for(var i=0; i< childNodes.length; i++){
		    var childNodes = response.childNodes;
		    for(var i = 0; i < childNodes.length; i++){
		        var childName = childNodes[i].nodeName;
		        console.log("child name: " + childName);
		        var subString = childName.substring(0,3);
		        console.log("substring: " + subString);
		        if(subString != "xml"){
		            return childNodes[i];
		        }
		    }
	        
	    }		
	}
	
);
