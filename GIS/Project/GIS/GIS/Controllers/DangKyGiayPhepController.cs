﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;
using GIS.Models;
using GIS.Helpers;

namespace GIS.Controllers
{
    public class DangKyGiayPhepController : BaseController
    {
        private IFileStore _fileStore;

        public DangKyGiayPhepController()
            : this(new DiskFileStore("~/App_Data/Upload/HSToChuc"))
        { }

        public DangKyGiayPhepController(IFileStore fileStore)
        {
            _fileStore = fileStore;
        }
            //
        // GET: /DangKyGiayPhep/
       [Authorize]
        public ActionResult Index()
        {
            // Get current user
            // Check whether User' Organization is exist (true)
            //      Load User' Organiztion 
            // else new detail
            //return View(model)

            ToChucDetailViewModel model = new ToChucDetailViewModel();
            model.NangLucs = new List<NangLucVM> { new NangLucVM{NganhNghe="sdf",
                Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2},new NangLucVM{NganhNghe="sdf",
                Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2} };
            model.NhanLucs = new List<NhanLucVM> { };
            model.ThietBis = new List<ThietBiVM> { };
          
            return View(model);
        }

        [HttpPost]
       public ActionResult Dangky() {
           return null;
       }

        public ActionResult ThongTinChung() {
            return View();
        }

        public ViewResult BlankNangLucRow(string formId)
        {
            return new AjaxViewResult("NangLucEditorRow", new NangLucVM()) { UpdateValidationForFormId = formId };
        }

        public ViewResult BlankNhanLucRow(string formId)
        {
            return new AjaxViewResult("NhanLucEditorRow", new NhanLucVM()) { UpdateValidationForFormId = formId };
        }

        public ViewResult BlankThietBiRow(string formId)
        {
            return new AjaxViewResult("ThietBiEditorRow", new ThietBiVM()) { UpdateValidationForFormId = formId };
        }

        public Guid Uploader()
        {
            return _fileStore.SaveUploadedFile(Request.Files[0]);
        }
    }
}