<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
 
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <!--The viewport meta tag is used to improve the presentation and behavior of the samples
      on iOS devices-->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
    <title>Web GIS</title>
    <link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dijit/themes/soria/soria.css"  />
	<link type="text/css" rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.5/js/dojo/dojo/resources/dojo.css"  />    
    <link rel="stylesheet" type="text/css" href="../../Content/map.css" />   
    <style type="text/css">
      html, body {
        height: 100%; width: 100%; margin: 0; padding: 0;
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
  </head>
  <body class="soria">
    <div dojotype="dijit.layout.BorderContainer" design="headline" gutters="false"
    style="width: 100%; height: 100%; margin: 0;">
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
            
                
       </div>
        <div id="mapViewer" dojotype="dijit.layout.BorderContainer" gutters="false" design="sidebar" region="center">
                <div id="mapPanel" dojotype="dijit.layout.ContentPane" region="center">
                </div>
                 <div id="toolbarPanel" dojotype="dijit.layout.BorderContainer" region="top" splitter="true">
                    
                </div>
                 <div id="leftPanel" dojotype="dijit.layout.TabContainer" region="left" splitter="true" tabStrip="true">
                    <div dojoType="dijit.layout.ContentPane" title="Tìm kiếm" selected="true">
                           Tìm kiếm
                    </div>
                    <div id="addLayer" dojoType="dijit.layout.ContentPane" title="Thêm Lớp" selected="true">                           	
                           	<span> Lựa chọn các lớp bản đồ dưới đây để hiển thị trên bản đồ : </span>
			                        <fieldset style="padding-left:20px;">
				                        <div id="layer_list"></div>        
				                    </fieldset>

                    </div>                
                </div>
                
             </div>
      </div>
  </body>

</html> 