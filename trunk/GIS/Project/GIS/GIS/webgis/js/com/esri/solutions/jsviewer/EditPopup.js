////////////////////////////////////////////////////////////////////////////////
//
// Copyright NguyenTanThuong - UIT- 01223830793 
//
//
////////////////////////////////////////////////////////////////////////////////

dojo.provide("com.esri.solutions.jsviewer.EditPopup");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");
dojo.require("dijit._Container");

dojo.require("dojo.fx");

dojo.declare("com.esri.solutions.jsviewer.EditPopup", [dijit._Widget, dijit._Templated, dijit._Container], {
    constructor: function(/*Object*/params) {
        this.connects = [];
    },

    templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "templates/EditPopup.html"),

    map: null,
    visible: false,
    coords: null,
    screenCoords: null,
    link: "",
    alignment: "",
    layerInfos: null,
    updateFeature: null,
    attInspector: null,
    resultItem: null,

    postCreate: function() {
        if (this.map) {
            this.connects.push(dojo.connect(this.map, "onExtentChange", this, "extentChangeHandler"));
            this.connects.push(dojo.connect(this.map, "onPan", this, "panHandler"));
        }
        dojo.setSelectable(this.domNode, false);

        var boxContainerMargin = dojo.marginBox(this.containerNode);
        var boxPopupContent = dojo.contentBox(this.domNode);
        boxContainerMargin.w = boxPopupContent.w;
        dojo.marginBox(this.containerNode, boxContainerMargin);
        dojo.style(this.containerNode, "height", "");

    },

    uninitialize: function() {
        dojo.forEach(this.connects, function(x) {
            dojo.disconnect(x);
        })
    },

    setInfo: function(/*Object*/params) {
        try {
            if (params) {
                if (params.title) {
                    this.titleNode.innerHTML = params.title;
                }

                if (params.layerInfos) {

                    var featureLayer = params.layerInfos.featureLayer;
                    var query = new esri.tasks.Query();
                    query.where = "OBJECTID =" + params.ObjectID;

                    featureLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, dojo.hitch(this, function(features) {
                        console.log("Co truy van nha");
                        if (features.length > 0) {
                            //store the current feature
                            this.updateFeature = features[0];

                            console.log(featureLayer.getSelectedFeatures());

                            this.layerInfos = [{
                                'featureLayer': featureLayer,
                                'showAttachments': params.layerInfos.showAttachments,
                                'isEditable': 'true',
                                'fieldInfos': params.layerInfos.fieldInfos
}];
                                //'isEditable': params.layerInfos.isEditable,
                                console.log("May ra day");
                                console.log(this.layerInfos);
                                if (this.attInspector === null) {
                                    console.log("Co tao may ma");
                                    this.attInspector = new esri.dijit.AttributeInspector({
                                        layerInfos: this.layerInfos
                                    }, dojo.create("div"));

                                    console.log(this.attInspector);

                                    //add a save button next to the delete button
                                    var saveButton = new dijit.form.Button({
                                        label: "Save",
                                        "class": "saveButton"
                                    });

                                    dojo.place(saveButton.domNode, this.attInspector.deleteBtn.domNode, "after");

                                    dojo.connect(this.updateFeature, "onEditComplete", dojo.hitch(this, function() {
                                        this.updateFeature.refresh();
                                    }));

                                    dojo.connect(saveButton, "onClick", dojo.hitch(this, function() {
                                        if (confirm('Bạn có muốn cập nhật không ?')) {
                                            console.log("vao cap nhat");
                                            this.updateFeature.getLayer().applyEdits(null, [this.updateFeature], null);
                                        }
                                        else {
                                            console.log("Ko cap nhat");
                                        }
                                    }));


                                    dojo.connect(this.attInspector, "onAttributeChange", dojo.hitch(this, function(feature, fieldName, newFieldValue) {
                                        //store the updates to apply when the save button is clicked
                                        this.updateFeature.attributes[fieldName] = newFieldValue;
                                    }));

                                    dojo.connect(this.attInspector, "onNext", dojo.hitch(this, function(feature) {
                                        this.updateFeature = feature;
                                        console.log("Next " + this.updateFeature.attributes.objectid);
                                    }));

                                    dojo.connect(this.attInspector, "onDelete", dojo.hitch(this, function(feature) {
                                        if (confirm('Bạn có muốn xoá không ?')) {
                                            feature.getLayer().applyEdits(null, null, [feature]);
                                            this.hide();
                                            console.log("Cho nay dung de xoa");
                                            console.log(this.resultItem);
                                            dojo.publish("DeletedGraphicEvent", [this.resultItem]);
                                        }
                                        else {
                                            dojo.publish("DeletedGraphicEvent", null);
                                        }
                                    }));

                                    console.log(this.attInspector.domNode)
                                    this.contentNode.appendChild(this.attInspector.domNode);
                                    this.attInspector.refresh();
                                }
                                else {
                                    this.attInspector.refresh();
                                    console.log(this.updateFeature);
                                    console.log("DOM NODE this.attributes Inspector");
                                    console.log(this.attInspector.domNode);
                                }

                            }
                        }));
                    }


                    this.link = params.link;
                    if (params.link) {
                        dojo.style(this.linkNode, "display", "block");
                        dojo.attr(this.linkNode, "title", this.link);
                    }
                    else {
                        dojo.style(this.linkNode, "display", "none");
                    }

                    if (dojo.isIE) {
                        dojo.style(this.closeButton, {
                            left: "",
                            right: "2px"
                        });

                        // If the content box < 40px high on IE, it's ugly
                        var contentBox = dojo.contentBox(this.containerNode);
                        if (contentBox.h < 40) {
                            dojo.style(this.containerNode, "height", "40px");
                        }
                        else {
                            dojo.style(this.containerNode, "height", "");
                        }
                    }

                    // Center the infoPopup and leader vertically
                    var b = dojo.coords(this.containerNode);
                    var mTop = (b.h / 2) + "px";
                    dojo.style(this.domNode, "marginTop", "-" + mTop);
                    dojo.style(this.leaderNode, "marginTop", mTop);
                }
            } catch (err) {
                console.error("EditPopup error " + err);
            }

        },

        setCoords: function(/*esri.geometry.Point*/mapPoint) {
            if (mapPoint) {
                this.coords = mapPoint;
                this.screenCoords = this.map.toScreen(mapPoint);
                this._locate(this.screenCoords);
            }
        },

        extentChangeHandler: function(extent, delta, levelChange, lod) {
            if (this.coords) {
                this.screenCoords = this.map.toScreen(this.coords);
            }
            this._locate(this.screenCoords);
        },

        panHandler: function(extent, delta) {
            if (this.screenCoords) {
                var sp = new esri.geometry.Point();
                sp.x = this.screenCoords.x + delta.x;
                sp.y = this.screenCoords.y + delta.y;
            }
            this._locate(sp);
        },

        _locate: function(/*esri.geometry.Point*/loc) {
            try {
                if (loc) {
                    // Determine if loc is in the left or right half of the map
                    var isLeft = (loc.x < this.map.width / 2);
                    // Allow for 10px in the middle as "neutral", to minimize flipping
                    var isNeutral = Math.abs(loc.x - this.map.width / 2) < 5;

                    if (isNeutral) {
                        if (this.alignment === "") {
                            this.alignment = isLeft ? "left" : "right";
                        }
                    }
                    else {
                        this.alignment = isLeft ? "left" : "right";
                    }

                    if (this.alignment === "left") {
                        // left half. Position popup to the right of loc
                        dojo.style(this.domNode, {
                            top: loc.y + "px",
                            left: loc.x + "px",
                            right: ""
                        });

                        // leader
                        dojo.style(this.leaderNode, {
                            left: "1px",
                            right: ""
                        });

                        // buttons
                        if (!dojo.isIE) {
                            dojo.style(this.closeButton, {
                                left: "",
                                right: "-22px"
                            });
                            // pinning removed for 1.0
                            //dojo.style(this.pinButton, {
                            //	left: "",
                            //	right: "-22px"
                            //});
                        }
                    }
                    else {
                        // right half. Position popup to the left of loc
                        var x = this.map.width - loc.x;
                        dojo.style(this.domNode, {
                            top: loc.y + "px",
                            right: x + "px",
                            left: ""
                        });

                        // leader
                        dojo.style(this.leaderNode, {
                            left: "",
                            right: "1px"
                        });

                        // buttons
                        if (!dojo.isIE) {
                            dojo.style(this.closeButton, {
                                left: "-24px",
                                right: ""
                            });
                            // pinning removed for 1.0
                            //dojo.style(this.pinButton, {
                            //	left: "-24px",
                            //	right: ""
                            //});
                        }
                    }
                }
            }
            catch (err) {
                console.error("Error locating infopopup:", err);
            }
        },

        show: function() {
            dojo.fadeIn({
                node: this.domNode
            }).play();
            this.visible = true;
        },

        hide: function() {
            dojo.fadeOut({
                node: this.domNode
            }).play();
            this.visible = false;
        },

        onFollowLink: function(evt) {
            window.open(this.link);
        },

        onClose: function(evt) {
            // Stub for event propagation
        },

        onPin: function(evt) {
            // Stub for event propagation
            dojo.fadeOut({
                node: this.pinButton
            }).play();
        },

        setResultItem: function(res) {
            console.log("setResultItem");
            console.log(res);
            this.resultItem = res;
        }

    });
