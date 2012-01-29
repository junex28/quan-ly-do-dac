﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GIS.Controllers
{
    [HandleError]
    public class GISController : Controller
    {
        public ActionResult Index()
        {
            return View("Viewer");
        }

        public ActionResult Code()
        {
            return View();
        }

        public ActionResult Viewer() {
            return View();
        }
    }
}
