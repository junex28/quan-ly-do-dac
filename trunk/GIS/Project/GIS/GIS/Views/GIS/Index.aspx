<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <!--The viewport meta tag is used to improve the presentation and behavior of the samples
      on iOS devices-->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no" />
    <title>Web GIS</title>
    <!--link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dijit/themes/soria/soria.css"  /-->
    <!--link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dojo/resources/dojo.css"  /-->
    <link type="text/css" rel="Stylesheet" href="../../Content/dojo.css" />
    <link type="text/css" rel="Stylesheet" href="../../Content/template/soria/soria.css" />
    <link rel="stylesheet" type="text/css" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dojox/grid/resources/Grid.css">
    <link rel="stylesheet" type="text/css" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dojox/grid/resources/soriaGrid.css">
    <link rel="stylesheet" type="text/css" href="../../Content/map.css" />
    <style type="text/css">
        html, body
        {
            height: 100%;
            width: 100%;
            margin: 0;
            padding: 0;
        }
    </style>

    <script type="text/javascript">
        var djConfig = {
            parseOnLoad: true
        };
    </script>

    <script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=2.5">
    </script>

    <script type="text/javascript" src="../../Resources/config.js"></script>

    <script type="text/javascript" src="../../Resources/project.js"></script>

    <%--<script type="text/javascript" src="../../Resources/gridResult.js"></script>		--%>
</head>
<body class="soria">
    <div dojotype="dijit.layout.BorderContainer" design="headline" gutters="false" style="width: 100%;
        height: 100%; margin: 0;">
        <div id="header" dojotype="dijit.layout.BorderContainer" design="sidebar" gutters="false"
            region="top">
            <div id="title" dojotype="dijit.layout.ContentPane" region="left">
                <img id="logo" alt="HTQL do dac ban do" src="../../Content/images/logo.png" />
                <img id="logoSwoosh" alt"swoosh" src="../../Content/images/logo_space_bg.gif" />
            </div>
            <div id="siteLogin" dojotype="dijit.layout.ContentPane" region="top">
                <% Html.RenderPartial("LogOnUserControl"); %>
            </div>
            <div class="siteMenu" dojotype="dijit.layout.ContentPane" region="center">
                <ul class="mapLinks">
                    <li>
                        <%= Html.ActionLink("Trang chủ", "Index", "Home")%></li>
                    <li>
                        <%= Html.ActionLink("WebGIS", "Index", "GIS")%></li>
                    <li><a href="">Đăng ký cấp phép</a></li>
                </ul>
            </div>
        </div>
        <div id="mapViewer" dojotype="dijit.layout.BorderContainer" gutters="false" design="sidebar"
            region="center">
            <div id="mapPanel" class="roundedCorners" dojotype="dijit.layout.ContentPane" region="center">
                <!--Loanding icon-->
                <img id="loadingImg" src="../../Content/images/loading.gif" style="position: absolute;
                    right: 512px; top: 256px; z-index: 100;" />
                <!--measure window-->
                <div id="test" visible="false">
                    <div class="roundedCorners" id="measureWindow" visible="false">
                        <div class="innerDiv roundedCorners">
                            <div id="measurementDiv">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="toolbarPane" dojotype="dijit.layout.ContentPane" region="top" splitter="true">
                <div id="toolbar1" dojotype="dijit.Toolbar">
                    <div data-dojo-type="dijit.form.Button" id="toolbar1.copy" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCopy', showLabel:false,onClick:function(){toolbar.deactivate;map.showZoomSlider();toolbarDeactivate();}">
                        select</div>
                    <div data-dojo-type="dijit.form.Button" id="toolbar1.cut" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut', showLabel:false,onClick:function(){toolbar.activate(esri.toolbars.Draw.EXTENT);map.hideZoomSlider();}">
                        rectangle</div>
                    <!--div data-dojo-type="dijit.form.Button" id="toolbar1.paste" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconPaste', showLabel:false,onClick:function(){dojo.style('measureWindow','visible',true)}">
                             Paste</div-->
                    <div data-dojo-type="dijit.form.Button" id="toolbar1.measure" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconPaste', showLabel:false,onClick:function(){document.getElementById('measureWindow').style.display = 'inherit';}">
                        Measure</div>
                </div>
            </div>
            <div id="leftPanel" dojotype="dijit.layout.TabContainer" region="left" splitter="true"
                tabstrip="true">
                <div class="lefttab" dojotype="dijit.layout.ContentPane" title="Tìm kiếm">
                    Tìm kiếm
                </div>
                <div class="lefttab" id="addLayer" dojotype="dijit.layout.ContentPane" title="Thêm Lớp" selected="true">
                    <span>Lựa chọn các lớp bản đồ dưới đây để hiển thị trên bản đồ : </span>
                    <fieldset style="padding-left: 20px;">
                        <div id="layer_list">
                        </div>
                    </fieldset>
                </div>
                <div class="lefttab" id="resultTab" dojotype="dijit.layout.ContentPane" title="Kết quả">
                    <div id="resultTool"><span><span><a href="#">Clear All</a> </span>
                    </div>
                    <table data-dojo-type="dojox.grid.DataGrid" data-dojo-id="grid" id="grid" data-dojo-props="rowsPerPage:'5', rowSelector:'20px'"
                        style="width: 200px; height: 425px; border: solid 1px #000;">
                        <thead>
                            <tr>
                                <th field="SoHieu">
                                    Số Hiệu
                                </th>
                                <th field="LoaiMoc" width="100px">
                                    Loại Mốc
                                </th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
