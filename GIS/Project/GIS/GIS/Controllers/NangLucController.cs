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
        private IToChucRepository _tochucRepository;
        private INangLucKeKhaiRespository _nanglucRepository;

        public NangLucController()
            : this(new ToChucRepository(), new NangLucKeKhaiRespository())
        {
        }

        public NangLucController(IToChucRepository tochucRepository, INangLucKeKhaiRespository nanglucRespository)
        {
            this._tochucRepository = tochucRepository;
            this._nanglucRepository = nanglucRespository;
        }
        
        //
        // GET: /NangLuc/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSNanglucs(int tcid)
        {

            var DSNangLuc = _nanglucRepository.GetNangLucKeKhaiByID(tcid).ToList();
            return PartialView(DSNangLuc);
        }


    }
}
