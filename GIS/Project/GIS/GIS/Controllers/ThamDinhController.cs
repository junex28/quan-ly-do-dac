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
        private ILoaiThamDinhRepository _loaitdRespository;

        public ThamDinhController()
            : this(new ThamDinhRespository(), new GiayPhepHoatDongRepository(), new LoaiThamDinhResposiroty())
        {
        }

        public ThamDinhController(IThamDinhRepository thamdinhRepository, IGiayPhepHoatDongRepository gphdRepository, ILoaiThamDinhRepository loaitdRespository)
        {
            this._thamdinhRepository = thamdinhRepository;
            this._gphdRepository = gphdRepository;
            this._loaitdRespository = loaitdRespository;
        }
        //
        // GET: /ThamDinh/
        public ActionResult Index([DefaultValue(1)] int page, int id)
        {
            ViewData["id"]=id;
            ViewData["page"] = page;
            return View();
        }

        public ActionResult ListData(int sid, string sidx, string sord, int page, int rows)
        {
            var listThamDinhs = _thamdinhRepository.GetThamDinhByGPID(sid);
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
                           u.MaThamDinh.ToString(),
                           u.GiayPhepHoatDong.ToChuc.TenToChuc,
                           u.NgayThamDinh.Value.ToShortDateString(),
                           u.KienNghi,
                           u.LoaiThamDinh1.DienGiai
                        }
                    })
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        //
        // GET: /ThamDinh/Details/5

        public ActionResult Detail(int id)
        {
            ThamDinh thamdinh = new ThamDinh();
            thamdinh = _thamdinhRepository.GetThamDinhById(id);
            return View(thamdinh);
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
            ThamDinh thamdinh = new ThamDinh();
            thamdinh = _thamdinhRepository.GetThamDinhById(id);
            var loaithamdinh = _loaitdRespository.GetLoaiThamDinhs().ToList();
            ViewData["LoaiThamDinh"] = loaithamdinh;
            return View(thamdinh);
        }

        //
        // POST: /ThamDinh/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ThamDinh thamdinh = _thamdinhRepository.GetThamDinhById(Convert.ToInt32(Request.Form["MaThamDinh"]));

            try
            {
                thamdinh.NgayThamDinh = Convert.ToDateTime(Request.Form["NgayThamDinh"]);
                thamdinh.NguoiThamDinh = Request.Form["NguoiThamDinh"];
                thamdinh.NguoiPhiaToChuc = Request.Form["NguoiPhiaToChuc"];
                thamdinh.TinhHopLe = Request.Form["TinhHopLe"];
                thamdinh.NangLucNhanVien = Request.Form["NangLucNhanVien"];
                thamdinh.NangLucThietBi = Request.Form["NangLucThietBi"];
                thamdinh.KetLuan = Request.Form["KetLuan"];
                thamdinh.KienNghi = Request.Form["KienNghi"];
                //thamdinh.LoaiThamDinh = Request.Form["LoaiThamDinh"];
                _thamdinhRepository.Save();
                return RedirectToAction("Detail", new { id = thamdinh.MaThamDinh });
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
