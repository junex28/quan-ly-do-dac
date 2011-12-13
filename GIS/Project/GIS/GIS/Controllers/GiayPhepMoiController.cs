using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using System.Linq.Dynamic;
using GIS.ViewModels;

namespace GIS.Controllers
{
    public class GiayPhepMoiController : Controller
    {
        IGiayPhepMoiRepository _gpmRepository;


        // Dependency Injection enabled constructors

        public GiayPhepMoiController()
            : this(new GiayPhepMoiRepository())
        {
        }

        public GiayPhepMoiController(IGiayPhepMoiRepository repository)
        {
            _gpmRepository = repository;
        }
        //
        // GET: /GiayPhepMoi/

        public ActionResult Index()
        {
             return View(); 
        }

        public ActionResult List(int page)
        {
            ViewData["page"] = page;
            //ViewData["page2"] = page2;
            //ViewData["page3"] = page3;
            return View();
        }

        public ActionResult ListData1(string sidx, string sord, int page, int rows)
        {
            var dsMoi = _gpmRepository.GetDSMoi();
            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = dsMoi.Count();
            var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

            // Input page number greater than total page
            //if(page >totalPages && page !=1){
            //    pageIndex = 0;
            //} 
            // This is possible because I'm using the LINQ Dynamic Query Library
            var models = dsMoi
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
                        id = u.MaGiayPhepHoatDong,
                        cell = new String[]
                       {   
                           "<ul class='ui-widget icon-collection'>"+
                           "<li class='ui-state-default ui-corner-all' title='Chi tiết'>"+
                           "<a href='/GiayPhepMoi/Details/"+
                           u.MaGiayPhepHoatDong.ToString()+
                           "'><span class='ui-icon ui-icon-document'></span></a>"+
                           "</li>"+
                           
                           "<li class='ui-state-default ui-corner-all' title='Thay đổi'>"+
                           "<a href='/GiayPhepMoi/Edit/"+
                           u.MaGiayPhepHoatDong.ToString()+
                           "'><span class='ui-icon ui-icon-pencil'></span></a>"+
                           "</li>"+
                           
                           "<li class='ui-state-default ui-corner-all' title='Xoá'>"+
                           "<a href='/GiayPhepMoi/Xoa?id="+
                           u.MaGiayPhepHoatDong.ToString()+
                           "'><span class='ui-icon ui-icon-trash'></span></a>"+
                           "</li>"+
                            "</ul>",
                           u.MaGiayPhepHoatDong.ToString(),
                           //CategoryName = "<a href=''>" + entity.CategoryName + "</a>",
                           u.ToChuc.TenToChuc.ToString(),
                           u.NgayXinPhep.ToString(),
                           u.ToChuc.NguoiDaiDien.ToString(),
                           u.ToChuc.TruSoChinh.ToString()
                       }
                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ListData2(string sidx, string sord, int page, int rows)
        {
            var dsMoiChoCapGP = _gpmRepository.GetDSMoiChoCapGP();
            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = dsMoiChoCapGP.Count();
            var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

            // Input page number greater than total page
            //if(page >totalPages && page !=1){
            //    pageIndex = 0;
            //} 
            // This is possible because I'm using the LINQ Dynamic Query Library
            var models = dsMoiChoCapGP
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
                        id = u.MaGiayPhepHoatDong,
                        cell = new String[]
                       {   
                           "<ul class='ui-widget icon-collection'>"+
                           "<li class='ui-state-default ui-corner-all' title='Chi tiết'>"+
                           "<a href='/GiayPhepMoi/Details/"+
                           u.MaGiayPhepHoatDong.ToString()+
                           "'><span class='ui-icon ui-icon-document'></span></a>"+
                           "</li>"+
                           
                           "<li class='ui-state-default ui-corner-all' title='Thay đổi'>"+
                           "<a href='/GiayPhepMoi/Edit/"+
                           u.MaGiayPhepHoatDong.ToString()+
                           "'><span class='ui-icon ui-icon-pencil'></span></a>"+
                           "</li>"+
                           
                           "<li class='ui-state-default ui-corner-all' title='Xoá'>"+
                           "<a href='/GiayPhepMoi/Xoa?id="+
                           u.MaGiayPhepHoatDong.ToString()+
                           "'><span class='ui-icon ui-icon-trash'></span></a>"+
                           "</li>"+
                            "</ul>",
                           u.MaGiayPhepHoatDong.ToString(),
                           //CategoryName = "<a href=''>" + entity.CategoryName + "</a>",
                           u.ToChuc.TenToChuc.ToString(),
                           u.NgayXinPhep.ToString(),
                           u.ToChuc.NguoiDaiDien.ToString(),
                           u.ToChuc.TruSoChinh.ToString()
                       }
                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        //
        // GET: /GiayPhepMoi/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /GiayPhepMoi/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /GiayPhepMoi/Create

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
        // GET: /GiayPhepMoi/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /GiayPhepMoi/Edit/5

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
        // GET: /GiayPhepMoi/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /GiayPhepMoi/Delete/5

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
