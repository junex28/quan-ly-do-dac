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

dojo.provide("com.esri.solutions.jsviewer._MapGraphicsMaintainer");

dojo.declare(
	"com.esri.solutions.jsviewer._MapGraphicsMaintainer",
	null,
	{
		connectMapClick: function() {
			// Listen to map clicks for clicking on graphics
			if (this.map) {
				this.connects.push(dojo.connect(this.map, "onClick", this, "onMapClick"));
			}
		},
		
		addGraphic: function(g) {
			try {
				if (this.map && g) {
					// add a property to the graphic
					g.owner = this.title;
					this.map.graphics.add(g);
				}
			} 
			catch (err) {
				console.error("Error adding graphic: " + err);
			}
		},
		
		clearGraphics: function() {
			// Find graphics marked as being owned by this widget
			if (this.map) {
				try {
					for (var i = this.map.graphics.graphics.length - 1; i >= 0; i--) {
						var g = this.map.graphics.graphics[i];
						if (this.isMyGraphic(g)) {
							this.map.graphics.remove(g);
						}
					}
				} 
				catch (err) {
					console.error("Error clearing graphics: " + err);
				}
			}
		},
		
		isMyGraphic: function(/*esri.Graphic*/ g) {
			return (g && g.owner && g.owner === this.title);
		},
		
		onMapClick: function(evt) {
			// See if we clicked on a graphic
			if (this.map) {
				if (!evt.graphic) {
					dojo.forEach(this.map.graphics.graphics, dojo.hitch(this, function(g, idx){
						if (this.isMyGraphic(g)) {
							var p = this.map.toScreen(g.geometry);
							var dist = esri.geometry.getLength(evt.screenPoint, p);
							if (dist < 20) { //pixels
								evt.graphic = g;
							}
						}
					}));
				}
				if (evt.graphic) {
					if (this.isMyGraphic(evt.graphic)) {
						dojo.publish("widgetHighlightEvent", [evt.graphic, evt.graphic.geometry]);
					}
				}
			}
		}
	}
);