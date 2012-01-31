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
    public class NangLucController : BaseController
    {
        private INangLucKeKhaiRespository _nanglucRepository;

        public NangLucController()
            : this(new NangLucKeKhaiRespository())
        {
        }

        public NangLucController(INangLucKeKhaiRespository nanglucRespository)
        {
            this._nanglucRepository = nanglucRespository;
        }
        
        //
        // GET: /NangLuc/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSNanglucs(int tcid, int page)
        {
            var DSNangLuc = _nanglucRepository.GetNangLucKeKhaiByID(tcid,page-1).ToList();
            return PartialView(DSNangLuc);
        }


    }
}
