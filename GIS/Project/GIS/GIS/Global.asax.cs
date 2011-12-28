using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using GIS.Controllers;
using GIS.Models;
using System.Threading;

namespace GIS
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "PagingToChuc",
                "ToChuc/Trang/{page}",
                new { controller = "ToChuc", action = "List", page = 1 });

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "TrangChu", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );


        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }

        protected void Application_AuthenticateRequest()
        {
            if (IgnoreAuthenticateRequest())
                return;
            EnhancedPrincipal user;
            if (User != null &&
                User.Identity.IsAuthenticated &&
                User.Identity.AuthenticationType == "Forms")
            {
                var repository = new TaiKhoanRepository();
                TaiKhoan dbUser = repository.GetTaiKhoanByID(int.Parse(User.Identity.Name));
                user = new EnhancedPrincipal(User.Identity, dbUser);
            }
            else
            {
                user = EnhancedPrincipal.Anonymous;
            }
            HttpContext.Current.User = Thread.CurrentPrincipal = user;
        }

        private static readonly string[] IgnoredExtensions = new[]
                                                                 {
                                                                     ".js", ".css", ".txt", ".html", ".htm",
                                                                     ".xml", ".png", ".gif", ".jpg", ".ico"
                                                                 };

        private static bool IgnoreAuthenticateRequest()
        {
            var url = HttpContext.Current.Request.Url.AbsolutePath.ToLowerInvariant();
            return IgnoredExtensions.Any(url.EndsWith);
        }
    }
}