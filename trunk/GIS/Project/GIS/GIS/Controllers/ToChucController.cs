using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;

namespace GIS.Controllers
{
    public class ToChucController : Controller
    {
        private IToChucRepository tochucRepository;

        
        public ToChucController(): this(new ToChucRepository()) 
        {
        }

        public ToChucController(IToChucRepository tochucRepository)
        {
            this.tochucRepository = tochucRepository;
        }

        //
        // GET: /ToChuc/
        //      /ToChuc/Page/2

        public ActionResult Index(int? page)
        {

            const int pageSize = 1;

            var listToChucs = tochucRepository.GetToChucs();
            var paginatedToChucs = new PaginatedList<ToChuc>(listToChucs, page ?? 0, pageSize);

            return View(paginatedToChucs);
        }

    }
}
