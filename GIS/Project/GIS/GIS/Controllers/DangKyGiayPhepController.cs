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
        private IThongTinChungRespository _ttcRespository;
        public ILoaiHinhToChucRepository _loaihinhtochucRepository;

        public DangKyGiayPhepController()
            : this(new DiskFileStore("~/App_Data/Upload/HSToChuc"), new HoSoGiayPhepRepository(),new DangKyHoatDongRespository(),
                new ThongTinChungRespository(), new LoaiHinhToChucRepository())
        { }

        public DangKyGiayPhepController(IFileStore fileStore, IHoSoGiayPhepRepository gphdRepository, IDangKyHoatDongRepository dkhdRepository,
                        IThongTinChungRespository ttcRespository,  ILoaiHinhToChucRepository lhtcRepository)
        {
            _fileStore = fileStore;
            _hsgpRepository = gphdRepository;
            _dkhdRespository = dkhdRepository;
            _ttcRespository = ttcRespository;
            _loaihinhtochucRepository = lhtcRepository;
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

           // Get current user
           TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
           List<ToChuc> tcs = tk.ToChucs.ToList(); 
           // Khi chua co to chuc nao duoc luu
           if (tcs.Count == 0)
           {
               model.NangLucs = new List<NangLucVM> { };
               model.NhanLucs = new List<NhanLucVM> { };
               model.ThietBis = new List<ThietBiVM> { };
               model.DSHoatDongSelecteds = new int[] { };
               model.DSHoatDongs = new List<HoatDong> { new HoatDong { MaHoatDong = 1, TenHoatDong = "sdf" }, new HoatDong { MaHoatDong = 2, TenHoatDong = "gfg" } };


           }
           // Da co thong tin to chuc cua tai khoan do
           else
           {
               model.NangLucs = new List<NangLucVM> { };
               model.NhanLucs = new List<NhanLucVM> { };
               model.ThietBis = new List<ThietBiVM> { };
               model.DSHoatDongSelecteds = new int[] { };
               model.DSHoatDongs = new List<HoatDong> { new HoatDong { MaHoatDong = 1, TenHoatDong = "sdf" }, new HoatDong { MaHoatDong = 2, TenHoatDong = "gfg" } };

               ToChuc tc = tcs[0];
               model.TenToChuc = tc.TenToChuc;
               model.MaToChuc = tc.MaToChuc;
               model.DienThoai = tc.DienThoai;
               model.Email = tc.Email;
               model.Fax = tc.Fax;
               model.GiayPhepKinhDoanh = tc.GiayPhepKinhDoanh;
               model.HangDoanhNghiep = tc.HangDoanhNghiep;
               model.MaLoaiHinhToChuc =  (int)tc.MaLoaiHinhToChuc;
               model.NguoiDaiDien = tc.NguoiDaiDien;
               model.SoTaiKhoan = tc.SoTaiKhoan;
               model.TongSoCanBo = tc.TongSoCanBo.GetValueOrDefault(0);
               model.TruSoChinh = tc.TruSoChinh;
               model.VonLuuDong = tc.VonLuuDong.GetValueOrDefault(0);
               model.VonPhapDinh = tc.VonPhapDinh.GetValueOrDefault(0);
           }
           model.loaiHinh = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();

           model.Camket = "Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.";

           //model.NangLucs = new List<NangLucVM> { new NangLucVM{NganhNghe="sdf",
           //     Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2},new NangLucVM{NganhNghe="sdf",
           //     Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2} };
           
           // Mã nhũng hoạt động khi được chọn từ danh sách hoạt động
           // Ban đầu thì không có phần tử nào


           //model.DSHoatDongSelecteds = new int[] { 2 };

           // Load danh sách Hoạt động vào đây.

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

          // Luu vao to chuc.

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
