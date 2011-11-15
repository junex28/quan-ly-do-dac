<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=7, IE=9" />
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="fragment" content="!" />
    <title> WEB GIS</title>
    <link rel="stylesheet" type="text/css" href="../../Content/map.css" />
    <link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dijit/themes/soria/soria.css"  />
	<link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dojo/resources/dojo.css"  />    
    <%--<link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dijit/themes/claro/claro.css"  />--%>
   
    <script type="text/javascript">
        var djConfig = { parseOnLoad: true };
        var map;
    </script>
    
    <script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=2.5"></script>
	
	<script type="text/javascript" src="../../Resources/project.js"></script>	
	
</head>

<body class="soria">
        <div id="mainContainer" dojotype="dijit.layout.BorderContainer" design="headline" gutters="false">
             <div id="header" dojotype="dijit.layout.BorderContainer" design="sidebar" gutters="false" region="top">
                <div id="title" dojotype="dijit.layout.ContentPane" region="left">
                   <img id="logo" alt="HTQL do dac ban do" src="../../Content/images/logo.png" />
                   <img id="logoSwoosh" alt"swoosh" src="../../Content/images/logo_space_bg.gif" />
                </div>
                              
                <div id="siteLogin" dojotype="dijit.layout.ContentPane" region="top">
                    <% Html.RenderPartial("LogOnUserControl"); %>                
                </div>
          
                <div class="siteMenu" dojotype="dijit.layout.ContentPane" region="center">
                    <ul class="mapLinks"> 
                        <li><%= Html.ActionLink("Trang chủ", "Index", "Home")%></li>
                        <li><%= Html.ActionLink("WebGIS", "Index", "GIS")%></li>
                        <li><a href="">Đăng ký cấp phép</a></li>
                    </ul>
                </div>
            
                
 <%--               <div id="toolbar1" dojotype="dijit.layout.ContentPane" region="bottom">
                        <div id="toolbar1.measure">
                            Measure
                        </div>                        
                </div>    
                
 --%>            </div>
             <div id="mapViewer" dojotype="dijit.layout.BorderContainer" gutters="false" design="sidebar" region="center">
                <div id="mapPanel" dojotype="dijit.layout.BorderContainer" region="center" gutters="false">                    
                </div>
                
                <div id="toolbarPanel" dojotype="dijit.layout.BorderContainer" region="top" splitter="true">
                    
                </div>
                
                <div id="leftPanel" dojotype="dijit.layout.TabContainer" region="left" splitter="true" tabStrip="true">
                    <div dojoType="dijit.layout.ContentPane" title="Tìm kiếm" selected="true">
                           Tìm kiếm
                    </div>
                    <div id="addLayer" dojoType="dijit.layout.ContentPane" title="Thêm Lớp" selected="true">                           	
                           	<span> Lựa chọn các lớp bản đồ dưới đây để hiển thị trên bản đồ : </span>
                           	<h2>Lớp Mốc</h2>
			                        <fieldset style="padding-left:20px;">
				                        <input id="check1" type="checkBox" dojoType="dijit.form.CheckBox">
				                        <label for="check1">Mốc toạ dộ</label><br/>

				                        <input id="check2" type="checkBox" dojoType="dijit.form.CheckBox" checked="checked">
				                        <label for="check2">Mốc độ cao</label><br />

				                        <input id="check3" type="checkBox" dojoType="dijit.form.CheckBox" disabled>
				                        <label for="check3">Mốc trọng lực</label><br />
			                        </fieldset>

                    </div>                
                </div>
                
             </div>
        </div>
</body>
</html>
     
