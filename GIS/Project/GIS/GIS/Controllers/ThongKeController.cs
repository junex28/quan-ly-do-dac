using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;


namespace GIS.Controllers
{
    public class ThongKeController : BaseController
    {
        //
        // GET: /ThongKe/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DataToJSON()
        {

            List<ThongKe> DataList = new List<ThongKe>();
            ThongKe Data1 = new ThongKe();
            Data1.LoaiCapPhep = "Lần đầu";
            Data1.SoLieu = new int[4];
            Data1.SoLieu[0]=2;
            Data1.SoLieu[1] = 6;
            Data1.SoLieu[2] = 7;
            Data1.SoLieu[3] = 10;
            DataList.Add(Data1);
            ThongKe Data2 = new ThongKe();
            Data2.LoaiCapPhep = "Gia hạn";
            Data2.SoLieu = new int[4];
            Data2.SoLieu[0] = 7;
            Data2.SoLieu[1] = 5;
            Data2.SoLieu[2] = 3;
            Data2.SoLieu[3] = 4;
            DataList.Add(Data2);
            ThongKe Data3 = new ThongKe();
            Data3.LoaiCapPhep = "Gia hạn";
            Data3.SoLieu = new int[4];
            Data3.SoLieu[0] = 14;
            Data3.SoLieu[1] = 9;
            Data3.SoLieu[2] = 3;
            Data3.SoLieu[3] = 8;
            DataList.Add(Data3);
            return Json(DataList, JsonRequestBehavior.AllowGet);

        }


    }
}
