using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GIS.Controllers
{
    public class NhanLucController : BaseController
    {
        //
        // GET: /NhanLuc/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSNhanLucs(string tcid) {
            return View();
        }

    }
}
