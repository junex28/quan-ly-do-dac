using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;
using GIS.ViewModels;
using System.Linq.Dynamic;
using System.ComponentModel;
using GIS.Models.Repository;

namespace GIS.Controllers
{
    public class ThamDinhController : Controller
    {
        
        private IThamDinhRepository _thamdinhRepository;
        private IGiayPhepHoatDongRepository _gphdRepository;

        public ThamDinhController()
            : this(new ThamDinhRespository(), new GiayPhepHoatDongRepository())
        {
        }

        public ThamDinhController(IThamDinhRepository thamdinhRepository, IGiayPhepHoatDongRepository gphdRepository)
        {
            this._thamdinhRepository = thamdinhRepository;
            this._gphdRepository = gphdRepository;
        }
        //
        // GET: /ThamDinh/
        public ActionResult Index([DefaultValue(1)] int page)
        {
            ViewData["page"] = page;
            return View();
        }

        public ActionResult ListData(string sidx, string sord, int page, int rows)
        {
            var listThamDinhs = _thamdinhRepository.GetThamDinhs() ;
            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = listThamDinhs.Count();
            var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

            // This is possible because I'm using the LINQ Dynamic Query Library
            var models = listThamDinhs
                    .OrderBy(sidx + " " + sord)
                    .Skip(pageIndex * pageSize)
                    .Take(pageSize).AsQueryable();

            var jsonData = new
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (
                    from u in models
                    select new
                    {
                        id = u.MaThamDinh,
                        cell = new string[] {
                           u.MaToChuc.ToString(),
                           u.TenToChuc,
                           u.LoaiHinhToChuc.TenLoaiHinhToChuc,
                           "Sogiayphep",
                           "ThoiGianHetHan",
                           u.DienThoai,
                           u.TruSoChinh
                        }
                    })
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        //
        // GET: /ThamDinh/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /ThamDinh/Create

        public ActionResult Create()
        {

            return View();
        } 

        //
        // POST: /ThamDinh/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /ThamDinh/Edit/5
 
        public ActionResult Edit(int id)
        {

            return View();
        }

        //
        // POST: /ThamDinh/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /ThamDinh/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /ThamDinh/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
