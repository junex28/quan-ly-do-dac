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
    public class ThietBiController : BaseController
    {
        private  IThietBiRepository  _ThietBiRepository;

        public ThietBiController()
            : this(new ThietBiRespository())
        {
        }

        public ThietBiController(IThietBiRepository ThietBiRespository)
        {
            this._ThietBiRepository = ThietBiRespository;
        }
        
        //
        // GET: /ThietBi/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSThietBis(int ttcid, int page)
        {

            var DSThietBi= _ThietBiRepository.GetThietBiByTTCID(ttcid,page-1).ToList();
            return PartialView(DSThietBi);
        }
    }
}
