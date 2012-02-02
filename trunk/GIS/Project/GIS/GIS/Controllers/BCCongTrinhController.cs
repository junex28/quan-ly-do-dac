using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;

namespace GIS.Controllers
{
    public class BCCongTrinhController : Controller
    {
        //
        // GET: /BCCongTrinh/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSCongTrinh()
        {
            IList<CongTrinhVM> DSCongTrinh = new List<CongTrinhVM>(); 
            return PartialView(DSCongTrinh);
        }


    }
}
