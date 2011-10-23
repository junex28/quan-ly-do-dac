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
            ViewBag.Menu = "Đăng Ký Gia Hạn";
            return View();
        }

        //
        // Get: /GiayPhep/DangKyMoi

        public ActionResult DangKyMoi()
        {
            ViewBag.Menu = "Đăng Ký Gia Hạn";
            return View();
        }

        //
        // Get: /GiayPhep/DangKyGiaHan

        public ActionResult DangKyGiaHan()
        {
            ViewBag.Menu = "Đăng Ký Gia Hạn";
            return View();
        }
    }
}
