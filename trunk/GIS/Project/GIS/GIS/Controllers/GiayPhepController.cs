using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GIS.Controllers
{
    public class GiayPhepController : Controller
    {
        //
        // GET: /GiayPhep/
 
        public ActionResult Index()
        {
            return RedirectToAction("DangKyMoi");
        }

        public ActionResult DangKyMoi()
        {
            return View();
        }

        public ActionResult GiaHan()
        {
            return View();
        }

        public ActionResult DangKyBoSungHoatDong()
        {
            return View();
        }

        public ActionResult BoSungThongTin()
        {
            return View();
        }
    }
}
