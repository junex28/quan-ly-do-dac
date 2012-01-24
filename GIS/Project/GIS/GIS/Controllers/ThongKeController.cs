using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;
using GIS.Models;

namespace GIS.Controllers
{
    public class ThongKeController : BaseController
    {
        private IThongKeRepository _thongkeRespository;

        public ThongKeController()
            : this( new GIS.Models.Repository.ThongKeRespository())
        {
        }

        public ThongKeController(IThongKeRepository thongkeRespository)
        {
            this._thongkeRespository = thongkeRespository;
        }
         
        
        // GET: /ThongKe/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DataToJSON(string nam)
        {
            int[] arr = new int[12];
            arr = _thongkeRespository.GetSoLieu(nam);
            List<ThongKe> DataList = new List<ThongKe>();
            ThongKe Data1 = new ThongKe();
            Data1.LoaiCapPhep = "Lần đầu";
            Data1.SoLieu = new int[4];
            Data1.SoLieu[0] = arr[0];
            Data1.SoLieu[1] = arr[1];
            Data1.SoLieu[2] = arr[2];
            Data1.SoLieu[3] = arr[3];
            DataList.Add(Data1);
            ThongKe Data2 = new ThongKe();
            Data2.LoaiCapPhep = "Gia hạn";
            Data2.SoLieu = new int[4];
            Data2.SoLieu[0] = arr[4];
            Data2.SoLieu[1] = arr[5];
            Data2.SoLieu[2] = arr[6];
            DataList.Add(Data2);
            ThongKe Data3 = new ThongKe();
            Data3.LoaiCapPhep = "Bổ sung hoạt động";
            Data3.SoLieu = new int[4];
            Data3.SoLieu[0] = arr[8];
            Data3.SoLieu[1] = arr[9];
            Data3.SoLieu[2] = arr[10];
            Data3.SoLieu[3] = arr[11];
            DataList.Add(Data3);
            return Json(DataList, JsonRequestBehavior.AllowGet);
        }
    }
}
