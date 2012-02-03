using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.ViewModels;
using GIS.Models.Repository;


namespace GIS.Controllers
{
    public class BCCongTrinhController : Controller
    {
         private  IBaoCaoHoatDongRepository  _bchdRepository;
        private  IBaoCaoCongTrinhRespository  _bcctRepository;

        public BCCongTrinhController()
            : this(new BaoCaoCongTrinhRespository(), new BaoCaoHoatDongRespository())
        {
        }

        public BCCongTrinhController(BaoCaoCongTrinhRespository bcctRespository, BaoCaoHoatDongRespository bchdRespository)
        {
            this._bchdRepository = bchdRespository;
            this._bcctRepository = bcctRespository;
        }
        
        public ActionResult Index()
        {
            return View();
        }

      
        public ActionResult DSCongTrinh(int bcid, int page)
        {

            var DSCongTrinh = _bcctRepository.GetBCCTByBCID(bcid, page - 1).ToList();
            return PartialView(DSCongTrinh);
        }

    }
}
