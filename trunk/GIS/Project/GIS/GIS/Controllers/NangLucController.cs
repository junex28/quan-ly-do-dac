using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GIS.Controllers
{
    public class NangLucController : BaseController
    {
        //
        // GET: /NangLuc/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSNanglucs(string tcid)
        {
            return View();
        }


    }
}
