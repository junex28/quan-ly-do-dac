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
    public class NhanLucController : BaseController
    {
        private  INhanLucRepository  _nhanlucRepository;

        public NhanLucController()
            : this(new NhanLucRespository())
        {
        }

        public NhanLucController(INhanLucRepository nhanlucRespository)
        {
            this._nhanlucRepository = nhanlucRespository;
        }
        
        //
        // GET: /NhanLuc/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DSNhanLucs(int ttcid, int page)
        {

            var DSNhanLuc= _nhanlucRepository.GetNhanLucByTTCID(ttcid,page-1).ToList();
            return PartialView(DSNhanLuc);
        }

    }
}
