﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;
using GIS.Models;
using GIS.Helpers;
using GIS.Models.Repository;

namespace GIS.Controllers
{
    public class DangKyGiayPhepController : BaseController
    {
        private IFileStore _fileStore;
        private IHoSoGiayPhepRepository _hsgpRepository;
        private IDangKyHoatDongRepository _dkhdRespository;
        private IThongTinChungRespository _ttcRespository;

        public DangKyGiayPhepController()
            : this(new DiskFileStore("~/App_Data/Upload/HSToChuc"), new HoSoGiayPhepRepository(),new DangKyHoatDongRespository(),
                new ThongTinChungRespository())
        { }

        public DangKyGiayPhepController(IFileStore fileStore, IHoSoGiayPhepRepository gphdRepository, IDangKyHoatDongRepository dkhdRepository,
                        IThongTinChungRespository ttcRespository)
        {
            _fileStore = fileStore;
            _hsgpRepository = gphdRepository;
            _dkhdRespository = dkhdRepository;
            _ttcRespository = ttcRespository;
        }
            //
        // GET: /DangKyGiayPhep/
       [Authorize]
        public ActionResult Index()
        {
            return RedirectToAction("TaoMoi");
        }

       [HttpGet]
       public ActionResult TaoMoi()
       {
           // Get current user
           // Check whether User' Organization is exist (true)
           //      Load User' Organiztion
           // else new detail
           //return View(model)

           ToChucDetailViewModel model = new ToChucDetailViewModel();

           TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;  
           // Luc tao moi thi chua co gi
           model.NangLucs = new List<NangLucVM> { };           
           model.NhanLucs = new List<NhanLucVM> { };
           model.ThietBis = new List<ThietBiVM> { };

           //model.NangLucs = new List<NangLucVM> { new NangLucVM{NganhNghe="sdf",
           //     Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2},new NangLucVM{NganhNghe="sdf",
           //     Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2} };
           
           // Mã nhũng hoạt động khi được chọn từ danh sách hoạt động
           // Ban đầu thì không có phần tử nào

           model.DSHoatDongSelecteds = new int[]{};
           //model.DSHoatDongSelecteds = new int[] { 2 };

           // Load danh sách Hoạt động vào đây.
           model.DSHoatDongs = new List<HoatDong> { new HoatDong { MaHoatDong = 1, TenHoatDong = "sdf" }, new HoatDong { MaHoatDong = 2, TenHoatDong = "gfg" } };

           model.Camket = "Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.";

           return View(model);
       }

      [HttpPost]

       public ActionResult TaoMoi(ToChucDetailViewModel model)
      {
          //ToChuc tc = new ToChuc();
          ThongTinChung ttc = new ThongTinChung();
          ttc.TenToChuc = model.TenToChuc;
          ttc.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
          ttc.HangDoanhNghiep = model.HangDoanhNghiep;
          ttc.VonLuuDong = model.VonLuuDong;
          ttc.VonPhapDinh = model.VonPhapDinh;
          ttc.SoTaiKhoan = model.SoTaiKhoan;
          ttc.TongSoCanBo = model.TongSoCanBo;
          ttc.TruSoChinh = model.TruSoChinh;
          ttc.NguoiDaiDien = model.NguoiDaiDien;
          ttc.DienThoai = model.DienThoai;
          ttc.Email = model.Email;
          ttc.Fax = model.Fax;
          _ttcRespository.Add(ttc);
          return View();

          //HoSoGiayPhep hsgp = new HoSoGiayPhep();
          // Lay danh sach nangluc: model.NangLucRow. 
          //Trả về kiểu định dạng là IEnumerable<NangLucVM>
          // Nhan luc : model.NhanLucRow
          // Thiet Bi : model.ThietBiRow


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
