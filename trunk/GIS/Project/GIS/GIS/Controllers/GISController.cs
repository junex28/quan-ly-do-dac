using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;

namespace GIS.Controllers
{
    [HandleError]
    public class GISController : Controller
    {
        public ActionResult Index()
        {
            return View("JSViewer");
        }

        public ActionResult Old()
        {
            return View("Index");
        }

        public ActionResult HuongDan()
        {
            return View();
        }

        public ActionResult Viewer() {
            return View();
        }

        public JsonResult OverviewWidget() {
            OvervierwWidget overview = new OvervierwWidget {
                mapservice = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandonen/MapServer",
                servicetype = "tiled"
            }; 
            return Json(new { overview = overview }, JsonRequestBehavior.AllowGet); 
        }

        public JsonResult MocToaDoWidget() {
            MocToaDoWidget moctoado = new MocToaDoWidget
            {
                layer = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/MapServer/3",
                query = "OBJECTID > 0",
                fields = new string[] { "OBJECTID", "SoHieu", "CapHang", "LoaiMoc", "HeQuyChieu", "TinhTrang", "NamThanhLap" },
                titleField = "SoHieu",
                linkField = "",
                refreshRate = 600, //seconds
                zoomScale = 5000,
                rowPerPage = 10
            };
            return Json(new {livelayer = moctoado}, JsonRequestBehavior.AllowGet);
        }

        public JsonResult MocDoCaoWidget()
        {
            MocToaDoWidget mocdocao = new MocToaDoWidget
            {
                layer = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/MapServer/2",
                query = "OBJECTID > 0",
                fields = new string[] { "OBJECTID", "SoHieu", "CapHang", "LoaiMoc", "HeQuyChieu", "TinhTrang", "NamThanhLap" },
                titleField = "SoHieu",
                linkField = "",
                refreshRate = 600, //seconds
                zoomScale = 5000,
                rowPerPage = 10
            };
            return Json(new { livelayer = mocdocao }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult MocTrongLucWidget()
        {
            MocToaDoWidget moctrongluc = new MocToaDoWidget
            {
                layer = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/MapServer/1",
                query = "OBJECTID > 0",
                fields = new string[] { "OBJECTID", "SoHieu", "CapHang", "LoaiMoc", "HeQuyChieu", "TinhTrang", "NamThanhLap" },
                titleField = "SoHieu",
                linkField = "",
                refreshRate = 600, //seconds
                zoomScale = 5000,
                rowPerPage = 10
            };
            return Json(new { livelayer = moctrongluc }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BookmarkWidget() {
            BookmarkWidget bookmark = new BookmarkWidget
            {
                bookmarks = new List<Bookmark>{
                new Bookmark{name="Quân 1",coords= new double[]{-122.2, 24.89, -70.59, 46.92}}
                }
            };
            return Json(new { bookmark = bookmark }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult LocateWidget() {
            var locate = new LocateWidget
            {
                locator = "http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer",
		        constrainedFields = new string[]{"State"},			            		            
		        constraintValues = new Constraint{State = new string[]{
                    "AK","AL","AR","AZ","CA","CO","CT","DE","DC","FL",
					 "GA","HI","IA","ID","IL","IN","KS","KY","LA","MA",
					 "MD","ME","MI","MN","MS","MO","MT","NC","ND","NE",
					 "NH","NJ","NM","NV","NY","OH","OK","OR","PA","RI",
					 "SC","SD","TN","TX","UT","VA","WA","WI","WV","WY"
                }},					   
		        minGeocodeScore = 50,
		        geometry = "http://127.0.0.1/ArcGIS/rest/services/QLDD/Geometry/GeometryServer",
		        projections = new List<SpatialRef>{ new SpatialRef{name="",wkid=-1}}
            };
            return Json(new { locate = locate }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SearchWidget() {
            var search = new SearchWidget
            {
                layers = new List<Layer> { 
                new Layer{
                    name = "Mốc trọng lực",
				    url = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/MapServer/1",
				    expression = "SoHieu = '[value]'",
				    textSearchField = "SoHieu",
				    textSearchSampleValue = "QTB.526",
				    graphicalSearch = true,
				    fields = new string[]{"OBJECTID","SoHieu","CapHang","LoaiMoc","HeQuyChieu","TinhTrang","NamThanhLap"},
				    titleField = "SoHieu",
				    linkField = "",
				    districtSearch = true,	
				    bufferSearch =true,
				    rowPerPage = 10	}
                ,
                new Layer{
                    name = "Mốc toạ độ",
				    url = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/MapServer/3",
				    expression = "SoHieu = '[value]'",
				    textSearchField = "SoHieu",
				    textSearchSampleValue = "HCM06",
				    graphicalSearch = true,
				    fields = new string[]{"OBJECTID","SoHieu","CapHang","LoaiMoc","HeQuyChieu","TinhTrang","NamThanhLap"},
				    titleField = "SoHieu",
				    linkField = "",
				    districtSearch = true,	
				    bufferSearch =true,
				    rowPerPage = 10	},
                new Layer{
                    name = "Mốc độ cao",
				    url = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/MapServer/2",
				    expression = "SoHieu = '[value]'",
				    textSearchField = "SoHieu",
				    textSearchSampleValue = "QTB.331",
				    graphicalSearch = true,
				    fields = new string[]{"OBJECTID","SoHieu","CapHang","LoaiMoc","HeQuyChieu","TinhTrang","NamThanhLap"},
				    titleField = "SoHieu",
				    linkField = "",
				    districtSearch = true,	
				    bufferSearch =true,
				    rowPerPage = 10	}
                }
                ,
                zoomScale = 10000,
		        pinIcon = "assets/images/icons/i_pinblue.png",
		        districtLayer = "http://127.0.0.1/ArcGIS/rest/services/QLDD/quan/MapServer/4",
		        geometryService = "http://127.0.0.1/ArcGIS/rest/services/QLDD/Geometry/GeometryServer",
		        bufferWKID = 102113

            };

            return Json(new { search = search }, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [RoleFilter(Roles = "4")]
        public JsonResult EditSearchWidget()
        {
            var search = new EditSearchWidget
            {
                layers = new List<Layer> { 
                new Layer{
                    name = "Mốc trọng lực",
				    url = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/FeatureServer/1",
				    expression = "SoHieu = '[value]'",
				    textSearchField = "SoHieu",
				    textSearchSampleValue = "QTB.526",
				    graphicalSearch = true,
				    fields = new string[]{"OBJECTID","SoHieu","CapHang","LoaiMoc","HeQuyChieu","TinhTrang","NamThanhLap"},
				    titleField = "SoHieu",
				    linkField = "",
				    districtSearch = true,	
				    bufferSearch =true,
				    rowPerPage = 10	}
                ,
                new Layer{
                    name = "Mốc toạ độ",
				    url = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/FeatureServer/3",
				    expression = "SoHieu = '[value]'",
				    textSearchField = "SoHieu",
				    textSearchSampleValue = "HCM06",
				    graphicalSearch = true,
				    fields = new string[]{"OBJECTID","SoHieu","CapHang","LoaiMoc","HeQuyChieu","TinhTrang","NamThanhLap"},
				    titleField = "SoHieu",
				    linkField = "",
				    districtSearch = true,	
				    bufferSearch =true,
				    rowPerPage = 10	},
                new Layer{
                    name = "Mốc độ cao",
				    url = "http://127.0.0.1/ArcGIS/rest/services/QLDD/bandodong/FeatureServer/2",
				    expression = "SoHieu = '[value]'",
				    textSearchField = "SoHieu",
				    textSearchSampleValue = "QTB.331",
				    graphicalSearch = true,
				    fields = new string[]{"OBJECTID","SoHieu","CapHang","LoaiMoc","HeQuyChieu","TinhTrang","NamThanhLap"},
				    titleField = "SoHieu",
				    linkField = "",
				    districtSearch = true,	
				    bufferSearch =true,
				    rowPerPage = 10	}
                }
                ,
                zoomScale = 10000,
                pinIcon = "assets/images/icons/i_pinblue.png",
                districtLayer = "http://127.0.0.1/ArcGIS/rest/services/QLDD/quan/MapServer/2",
                geometryService = "http://127.0.0.1/ArcGIS/rest/services/QLDD/Geometry/GeometryServer",
                bufferWKID = 102113,
                layerInfo = new LayerInfo
                {
                    showAttachments = false,
                    isEditable = true,
                    fieldInfos = new List<FieldInfo> { 
                    new FieldInfo{
                        fieldName = "SoHieu", isEditable = false, tooltip = "Số hiệu" , label= "Số hiệu:"
                    },
                    new FieldInfo{
                        fieldName = "CapHang", isEditable = false, tooltip = "Cấp hạng" , label= "Cấp hạng:"
                    },
                    new FieldInfo{
                        fieldName = "LoaiMoc", isEditable = false, tooltip = "Loại mốc" , label= "Loại mốc:"
                    },
                    new FieldInfo{
                        fieldName = "HeQuyChieu", isEditable = false, tooltip = "Hệ quy chiếu" , label= "Hệ quy chiếu:"
                    },
                    new FieldInfo{
                        fieldName = "TinhTrang", isEditable = true, tooltip = "Tình trạng" , label= "Tình trạng:"
                    },
                    new FieldInfo{
                        fieldName = "NamThanhLap", isEditable = false, tooltip = "Năm thành lập" , label= "Năm thành lập:"
                    }

                    }
                }

            };

            return Json(new { search = search }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DrawWidget()
        {
            var draw = new DrawWidget
            {
                geometryService = "http://127.0.0.1/ArcGIS/rest/services/QLDD/Geometry/GeometryServer",
                color = new int[] { 0, 0, 0 },
                size = 10,
                font = "Arial",
                measureSize = 10,
                labelRounding = new Graph
                {
                    point = new GraphStyle { mode = "round", digits = 2 },
                    line = new GraphStyle { mode = "sigdigit", digits = 4},
                    area = new GraphStyle { mode = "sigdigit", digits = 6 }
                }

            };
            return Json(new { draw = draw }, JsonRequestBehavior.AllowGet);
        }

    }

    public class OvervierwWidget {
        public string mapservice {get;set;}
        public string servicetype { get; set;}

    }

    public class MocToaDoWidget {
        public string layer { get; set; }
        public string query { get; set; }
        public string[] fields {get;set; }
        public string titleField { get; set; }
        public string linkField { get; set; }
        public int refreshRate { get; set; }
        public int zoomScale { get; set; }
        public int rowPerPage { get; set; }
    }

    public class BookmarkWidget {
        public List<Bookmark> bookmarks;
    }

    public class Bookmark {
        public string name { get; set; }
        public double[] coords { get; set; }
    }

    public class LocateWidget{
        public string locator { get; set; }
        public string[] constrainedFields { get; set; }
        public Constraint constraintValues { get; set; }
        public int minGeocodeScore { get; set; }
        public string geometry { get; set; }
        public List<SpatialRef> projections{ get; set; }
    }

    public class Constraint {
        public string[] State { get; set; }
    }

    public class SpatialRef {
        public string name{ get; set; }
        public int wkid{ get; set; }
    }

    public class SearchWidget {
        public List<Layer> layers{ get; set; }
        public int zoomScale { get; set; }
        public string pinIcon { get; set; }
        public string districtLayer { get; set; }
        public string geometryService { get; set; }
        public int bufferWKID { get; set; }
    }

    public class Layer {
        public string name { get; set; }
        public string url { get; set; }
        public string expression { get; set; }
        public string textSearchField{ get; set; }
        public string textSearchSampleValue { get; set; }
        public bool graphicalSearch { get; set; }
        public string[] fields { get; set; }
        public string titleField { get; set; }
        public string linkField { get; set; }
        public bool districtSearch { get; set; }
        public bool bufferSearch { get; set; }
        public int rowPerPage { get; set; }
    }

    public class LayerInfo {
        public bool showAttachments { get; set; }
        public bool isEditable { get; set; }
        public List<FieldInfo> fieldInfos { get; set; }
        
    }

    public class FieldInfo {
        public string fieldName {get; set;}
        public bool isEditable { get; set; }
        public string tooltip { get; set; }
        public string label { get; set; }
    }

    public class EditSearchWidget {
        public List<Layer> layers { get; set; }
        public int zoomScale { get; set; }
        public string pinIcon { get; set; }
        public string districtLayer { get; set; }
        public string geometryService { get; set; }
        public int bufferWKID { get; set; }
        public LayerInfo layerInfo{ get; set; }
    }

    public class DrawWidget {
        public string geometryService { get; set; }
        public int[] color { get; set; }
        public int size { get; set; }
        public string font { get; set; }
        public int measureSize { get; set; }
        public Graph labelRounding { get; set; }        
    }

    public class Graph {
        public GraphStyle point { get; set; }
        public GraphStyle line { get; set; }
        public GraphStyle area { get; set; }
    }

    public class GraphStyle {
        public string mode { get; set; }
        public int digits { get; set; }
    }
}
