using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;

namespace GIS.Controllers
{
    public class BaseController : Controller 
    {
        public TaiKhoan CurrentUser
        {
            get
            {
                var principal = User as EnhancedPrincipal;
                return principal == null ? null : principal.Data;
            }
        }

        public ActionResult RedirectToLogin() {
            return RedirectToAction("DangNhap", "TaiKhoan", new {returnUrl = Request.Path });
        }
    }
}
