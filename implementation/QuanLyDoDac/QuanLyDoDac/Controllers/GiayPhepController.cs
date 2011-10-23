using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyDoDac.Controllers
{
    public class GiayPhepController : Controller
    {
        //
        // GET: /GiayPhep/

        public ActionResult Index()
        {
            return View();
        }

        //
        // Get: /GiayPhep/DangKyMoi

        public ActionResult DangKyMoi()
        {
            return View();
        }

        //
        // Get: /GiayPhep/DangKyGiaHan

        public ActionResult DangKyGiaHan()
        {
            return View();
        }

        // Get: /GiayPhep/BoSungThongTin

        public ActionResult BoSungThongTin()
        {
            return View();
        }
    }
}
