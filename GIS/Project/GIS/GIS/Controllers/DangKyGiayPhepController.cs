

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GIS.Controllers
{
    public class DangKyGiayPhepController : BaseController
    {
        //
        // GET: /DangKyGiayPhep/
        //[Authorize]
        public ActionResult Index()
        {
            return RedirectToAction("ThongTinChung","DangKyGiayPhep");
        }

        public ActionResult ThongTinChung() {
            return View();
        }

    }
}
