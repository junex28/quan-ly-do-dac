using System;
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

        public DangKyGiayPhepController()
            : this(new DiskFileStore("~/App_Data/Upload/HSToChuc"), new HoSoGiayPhepRepository(),new DangKyHoatDongRespository())
        { }

        public DangKyGiayPhepController(IFileStore fileStore, IHoSoGiayPhepRepository gphdRepository, IDangKyHoatDongRepository dkhdRepository)
        {
            _fileStore = fileStore;
            _hsgpRepository = gphdRepository;
            _dkhdRespository = dkhdRepository;
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
           model.NangLucs = new List<NangLucVM> { new NangLucVM{NganhNghe="sdf",
                Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2},new NangLucVM{NganhNghe="sdf",
                Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2} };
           model.NhanLucs = new List<NhanLucVM> { };
           model.ThietBis = new List<ThietBiVM> { };

           model.DSHoatDongSelecteds = new int[] { 2 };
           model.DSHoatDongs = new List<HoatDong> { new HoatDong { MaHoatDong = 1, TenHoatDong = "sdf" }, new HoatDong { MaHoatDong = 2, TenHoatDong = "gfg" } };
           model.Camket = "Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.";

           return View(model);
       }

      [HttpPost]
       public ActionResult TaoMoi(ToChucDetailViewModel model){       
          
          return null;
          HoSoGiayPhep hsgp = new HoSoGiayPhep();
          
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
