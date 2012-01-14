

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
       [Authorize]
        public ActionResult Index()
        {
            // Get current user
            // Check whether User' Organization is exist (true)
            //      Load User' Organiztion 
            // else new detail
            //return View(model)
            

            return View();
        }

        public ActionResult ThongTinChung() {
            return View();
        }

    }
}
