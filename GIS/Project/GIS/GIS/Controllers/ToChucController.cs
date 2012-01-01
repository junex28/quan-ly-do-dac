﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;
using GIS.ViewModels;
using System.Linq.Dynamic;
using System.ComponentModel;

namespace GIS.Controllers
{
    public class ToChucController : BaseController
    {
        private IToChucRepository _tochucRepository;
        private ILoaiHinhToChucRepository _loaihinhtochucRepository;
        private ITaiKhoanRepository _taikhoanRepository;

        public ToChucController()
            : this(new ToChucRepository(), new LoaiHinhToChucRepository(), new TaiKhoanRepository())
        {
        }

        public ToChucController(IToChucRepository tochucRepository, ILoaiHinhToChucRepository loaihinhtochucRepository, ITaiKhoanRepository taikhoanRepository)
        {
            this._tochucRepository = tochucRepository;
            this._loaihinhtochucRepository = loaihinhtochucRepository;
            this._taikhoanRepository = taikhoanRepository;
        }
      
        [Authorize]
        [RoleFilter(Roles= "4")]
   
        public ActionResult Index([DefaultValue(1)] int page)
        {
            ViewData["page"] = page;
            return View();
        }

        public ActionResult ListData(string sidx, string sord, int page, int rows)
        {
            var listToChucs = _tochucRepository.GetToChucs();
            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = listToChucs.Count();
            var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

            // This is possible because I'm using the LINQ Dynamic Query Library
            var models = listToChucs
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
                        id = u.MaToChuc,
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
        /// <summary>
        // create new tochuc
        /// </summary>
        /// <returns></returns>

        public ActionResult Create()
        {
            var loaihinh = _loaihinhtochucRepository.GetLoaiHinhToChucs1();
            
           ViewData["loaihinh"] = new SelectList(loaihinh, "MaLoaiHinhToChuc", "TenLoaiHinhToChuc");
           // ViewData["loaihinh"] = loaihinh;
            return View();
        }

        [HttpPost]
        public ActionResult Create(ToChuc model)
        {
            if (!ModelState.IsValid)
                return View(model);
            var tc = new ToChuc
            {
                
                TenToChuc = model.TenToChuc,
                NguoiDaiDien = model.NguoiDaiDien,
                TruSoChinh = model.TruSoChinh,
                GiayPhepKinhDoanh = model.GiayPhepKinhDoanh,
                SoTaiKhoan = model.SoTaiKhoan,
                NgayXinPhep = DateTime.Now,
                DienThoai = model.DienThoai,
                Email = model.Email,
                Fax = model.Fax,
                KichHoat = model.KichHoat,
                MaLoaiHinhToChuc = model.MaLoaiHinhToChuc,
                TepDinhKem = model.TepDinhKem,
                TongSoCanBo = model.TongSoCanBo
            };
            _tochucRepository.Add(tc);
            _tochucRepository.Save();
            return RedirectToAction("Index", new { tc.MaToChuc });
        }


        //
        // GET: /Dinners/Details/5

        public ActionResult Detail(int id)
        {
            ToChuc tochuc = _tochucRepository.GetToChucByID(id);
            if (tochuc == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            var modelview = new ToChucDetailViewModel { toChuc = tochuc };
            return View(modelview);
        }


        //
        // GET: /Dinners/Edit/5

        public ActionResult Edit(int id)
        {
            var EditedToChuc = _tochucRepository.GetToChucByID(id);
            //LoaiHinhToChuc lhtc = tochucRepository.getLoaiHinh(tochuc);
            var LoaiHinhToChucList = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();

            var viewmodel = new ToChucDetailViewModel
            {
                toChuc = EditedToChuc,
                loaiHinh = LoaiHinhToChucList
            };

            return View(viewmodel);
        }

        //
        // POST: /Dinners/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ToChuc tochuc = _tochucRepository.GetToChucByID(Convert.ToInt32(Request.Form["MaToChuc"]));

            try
            {
                tochuc.TruSoChinh = Request.Form["TruSoChinh"];
                tochuc.TongSoCanBo = Convert.ToInt32(Request.Form["TongSoCanBo"]);
                tochuc.SoTaiKhoan = Request.Form["SoTaiKhoan"];
                tochuc.LoaiHinhToChuc = _loaihinhtochucRepository.GetLoaiHinhToChucByID(Convert.ToInt16(Request.Form["MaLoaiToChuc"]));
                tochuc.GiayPhepKinhDoanh = Request.Form["GiayPhepKinhDoanh"];
                tochuc.NguoiDaiDien = Request.Form["NguoiDaiDien"];
                tochuc.DienThoai = Request.Form["DienThoai"];
                tochuc.Email = Request.Form["Email"];
                tochuc.Fax = Request.Form["Fax"];
                tochuc.KichHoat = Convert.ToBoolean(Request.Form["KichHoat"]);
                _tochucRepository.Save();
                return RedirectToAction("Details", new { id = tochuc.MaToChuc });
            }
            catch
            {
                return View();
            }
        }


        [HttpPost]
        public ActionResult Delete(int[] ids)
        {
            try
            {
                for (int i = 0; i < ids.Length; i++)
                {
                    ToChuc tochuc = _tochucRepository.GetToChucByID(ids[i]);
                
                    _tochucRepository.Delete(tochuc);
                
                }
                _tochucRepository.Save();
               
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "",new List<string>{"error when deleting"}, HttpContext.Response);
            }
            return View("Index");
        }
    }
}