using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;
using GIS.Models;
using GIS.Helpers;
using GIS.Models.Repository;
using System.Transactions;

namespace GIS.Controllers
{
    public class DangKyGiayPhepController : BaseController
    {
        private IFileStore _fileStore;
        private IHoSoGiayPhepRepository _hsgpRepository;
        private IDangKyHoatDongRepository _dkhdRespository;
        private IThongTinChungRespository _ttcRespository;
        private ILoaiHinhToChucRepository _loaihinhtochucRepository;
        private IToChucRepository _tochucRespository;
        private INangLucKeKhaiRespository _nanglucRespository;
        private IThietBiRepository _thietbiRespository;
        private INhanLucRepository _nhanlucRespository;
        private IHoatDongRepository _hoatdongRespository;

        public DangKyGiayPhepController()
            : this(new DiskFileStore("~/App_Data/Upload/HSToChuc"), new HoSoGiayPhepRepository(), new DangKyHoatDongRespository(),
                new ThongTinChungRespository(), new LoaiHinhToChucRepository(), new ToChucRepository(), new NangLucKeKhaiRespository(),
                new ThietBiRespository(), new NhanLucRespository(), new HoatDongRespository())
        { }

        public DangKyGiayPhepController(IFileStore fileStore, IHoSoGiayPhepRepository gphdRepository, IDangKyHoatDongRepository dkhdRepository,
                        IThongTinChungRespository ttcRespository, ILoaiHinhToChucRepository lhtcRepository, IToChucRepository tochucRespository,
                        INangLucKeKhaiRespository nanglucRespository, IThietBiRepository thietbiRespository,
                        INhanLucRepository nhanlucRespository, IHoatDongRepository hoatdongRespository)
        {
            _fileStore = fileStore;
            _hsgpRepository = gphdRepository;
            _dkhdRespository = dkhdRepository;
            _ttcRespository = ttcRespository;
            _loaihinhtochucRepository = lhtcRepository;
            _tochucRespository = tochucRespository;
            _nanglucRespository = nanglucRespository;
            _thietbiRespository = thietbiRespository;
            _nhanlucRespository = nhanlucRespository;
            _hoatdongRespository = hoatdongRespository;
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
                ToChuc tc = tcs[0];
                model.NangLucs = new List<NangLucVM> { };
                List<NangLucKeKhai> listNangLuc = new List<NangLucKeKhai>();
                listNangLuc = _nanglucRespository.GetNangLucByTCID(tc.MaToChuc);
                if (listNangLuc != null)
                {
                    foreach (var nl in listNangLuc)
                    {
                        NangLucVM nangluc = new NangLucVM();
                        nangluc.NganhNghe = nl.NganhNghe;
                        nangluc.Daihoc = nl.SoTrenDaiHoc;
                        nangluc.TrungCap = nl.SoTrungCap;
                        nangluc.CongNhan = nl.SoCongNhanKyThuat;
                        nangluc.LoaiKhac = nl.LoaiKhac;
                        model.NangLucs.Add(nangluc);
                    }
                }

                model.NhanLucs = new List<NhanLucVM> { };
                List<NhanLuc> listNhanLuc = new List<NhanLuc>();
                listNhanLuc = _nhanlucRespository.GetNhanLucByTCID(tc.MaToChuc);
                if (listNhanLuc != null)
                {
                    foreach (var nl in listNhanLuc)
                    {
                        NhanLucVM nhanluc = new NhanLucVM();
                        nhanluc.HoTen = nl.HoTen;
                        nhanluc.ChucVu = nl.ChucVu;
                        nhanluc.TrinhDoHocVan = nl.TrinhDoHocVan;
                        nhanluc.ThamNien = nl.ThamNien;
                        model.NhanLucs.Add(nhanluc);
                    }
                }

                model.ThietBis = new List<ThietBiVM> { };
                List<ThietBi> listThietBi = new List<ThietBi>();
                listThietBi = _thietbiRespository.GetThietBiByTCID(tc.MaToChuc);
                if (listThietBi != null)
                {
                    foreach (var tb in listThietBi)
                    {
                        ThietBiVM thietbi = new ThietBiVM();
                        thietbi.TenThietBi_CongNghe = tb.TenThietBi_CongNghe;
                        thietbi.SoLuong = tb.SoLuong;
                        thietbi.GhiChu = tb.GhiChu;
                        thietbi.TinhTrang = tb.TinhTrang;
                        model.ThietBis.Add(thietbi);
                    }
                }

                model.DSHoatDongSelecteds = new int[] { };
                model.DSHoatDongs = new List<HoatDong> { new HoatDong { MaHoatDong = 1, TenHoatDong = "sdf" }, new HoatDong { MaHoatDong = 2, TenHoatDong = "gfg" } };


                model.TenToChuc = tc.TenToChuc;
                model.MaToChuc = tc.MaToChuc;
                model.DienThoai = tc.DienThoai;
                model.Email = tc.Email;
                model.Fax = tc.Fax;
                model.GiayPhepKinhDoanh = tc.GiayPhepKinhDoanh;
                model.HangDoanhNghiep = tc.HangDoanhNghiep;
                model.MaLoaiHinhToChuc = (int)tc.MaLoaiHinhToChuc;
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

            model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();

            //model.DSHoatDongSelecteds = 

            // Load danh sách Hoạt động vào đây.

            return View(model);
        }

        [HttpPost]
        public ActionResult TaoMoi(ToChucDetailViewModel model, int save)
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            List<string> listStr = new List<string>();

            if (save == 1)
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    try
                    {
                        ThongTinChung ttc = new ThongTinChung();
                        using (TransactionScope s1 = new TransactionScope())
                        {
                            ttc.TenToChuc = model.TenToChuc;
                            ttc.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
                            ttc.HangDoanhNghiep = model.HangDoanhNghiep;
                            ttc.VonLuuDong = model.VonLuuDong;
                            ttc.VonPhapDinh = model.VonPhapDinh;
                            ttc.SoTaiKhoan = model.SoTaiKhoan;
                            ttc.TongSoCanBo = model.TongSoCanBo;
                            ttc.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                            ttc.TruSoChinh = model.TruSoChinh;
                            ttc.NguoiDaiDien = model.NguoiDaiDien;
                            ttc.DienThoai = model.DienThoai;
                            ttc.Email = model.Email;
                            ttc.Fax = model.Fax;
                            _ttcRespository.Add(ttc);

                            // Luu vao to chuc neu chua co hoac update 
                            //ToChuc t = _tochucRespository.GetToChucByID(model.MaToChuc);
                            List<ToChuc> tcs = tk.ToChucs.ToList();
                            if (tcs.Count == 0)
                            {
                                ToChuc tc1 = new ToChuc();
                                tc1.TenToChuc = model.TenToChuc;
                                tc1.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
                                tc1.HangDoanhNghiep = model.HangDoanhNghiep;
                                tc1.VonLuuDong = model.VonLuuDong;
                                tc1.VonPhapDinh = model.VonPhapDinh;
                                tc1.SoTaiKhoan = model.SoTaiKhoan;
                                tc1.TongSoCanBo = model.TongSoCanBo;
                                tc1.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                                tc1.TruSoChinh = model.TruSoChinh;
                                tc1.NguoiDaiDien = model.NguoiDaiDien;
                                tc1.DienThoai = model.DienThoai;
                                tc1.Email = model.Email;
                                tc1.Fax = model.Fax;
                                tc1.MaTaiKhoan = tk.MaTaiKhoan;
                                _tochucRespository.Add(tc1);
                            }
                            else
                            {
                                ToChuc t = tcs[0];
                                t.TenToChuc = model.TenToChuc;
                                t.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
                                t.HangDoanhNghiep = model.HangDoanhNghiep;
                                t.VonLuuDong = model.VonLuuDong;
                                t.VonPhapDinh = model.VonPhapDinh;
                                t.SoTaiKhoan = model.SoTaiKhoan;
                                t.TongSoCanBo = model.TongSoCanBo;
                                t.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                                t.TruSoChinh = model.TruSoChinh;
                                t.NguoiDaiDien = model.NguoiDaiDien;
                                t.DienThoai = model.DienThoai;
                                t.Email = model.Email;
                                t.Fax = model.Fax;
                                _tochucRespository.Save();
                            }
                            s1.Complete();
                        }
                        // xoa nhung nangluckekhai co MaToChuc va them vao nangluckekhai co MaToChuc moi
                        // them những nangluckekhai co MaThongTinChung

                        //List<ToChuc> tcs1 = tk.ToChucs.ToList();
                        //ToChuc tochuc = tcs1[0];
                        ToChuc tochuc = _tochucRespository.GetToChucByTaiKhoan(tk.MaTaiKhoan);
                        List<NangLucKeKhai> listNangLucCu = _nanglucRespository.GetNangLucByTCID(tochuc.MaToChuc);
                        foreach (var nlCu in listNangLucCu)
                        {
                            _nanglucRespository.Delete(nlCu);
                        }
                        IEnumerable<NangLucVM> listNangLuc = model.NangLucRow;
                        if (listNangLuc != null)
                        {
                            foreach (var i in listNangLuc)
                            {
                                NangLucKeKhai nl = new NangLucKeKhai();
                                nl.MaToChuc = tochuc.MaToChuc;
                                nl.NganhNghe = i.NganhNghe;
                                nl.SoTrenDaiHoc = i.Daihoc;
                                nl.SoTrungCap = i.TrungCap;
                                nl.SoCongNhanKyThuat = i.CongNhan;
                                nl.LoaiKhac = i.LoaiKhac;
                                _nanglucRespository.Add(nl);
                                NangLucKeKhai nl1 = new NangLucKeKhai();
                                nl1.MaThongTinChung = ttc.MaThongTinChung;
                                nl1.NganhNghe = i.NganhNghe;
                                nl1.SoTrenDaiHoc = i.Daihoc;
                                nl1.SoTrungCap = i.TrungCap;
                                nl1.SoCongNhanKyThuat = i.CongNhan;
                                nl1.LoaiKhac = i.LoaiKhac;
                                _nanglucRespository.Add(nl1);
                            }
                        }
                        // xoa nhung ThietBi co MaToChuc va them vao ThietBi co MaToChuc moi
                        // them những ThietBi co MaThongTinChung
                        List<ThietBi> listThietBiCu = _thietbiRespository.GetThietBiByTCID(tochuc.MaToChuc);
                        foreach (var tbCu in listThietBiCu)
                        {
                            _thietbiRespository.Delete(tbCu);
                        }
                        IEnumerable<ThietBiVM> listThietBi = model.ThietBiRow;
                        if (listThietBi != null)
                        {
                            foreach (var i in listThietBi)
                            {
                                ThietBi tb = new ThietBi();
                                tb.MaToChuc = tochuc.MaToChuc;
                                tb.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                tb.SoLuong = i.SoLuong;
                                tb.TinhTrang = i.TinhTrang;
                                tb.GhiChu = i.GhiChu;
                                _thietbiRespository.Add(tb);
                                ThietBi tb1 = new ThietBi();
                                tb1.MaThongTinChung = ttc.MaThongTinChung;
                                tb1.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                tb1.SoLuong = i.SoLuong;
                                tb1.TinhTrang = i.TinhTrang;
                                tb1.GhiChu = i.GhiChu;
                                _thietbiRespository.Add(tb1);
                            }
                        }

                        // xoa nhung ThietBi co MaToChuc va them vao ThietBi co MaToChuc moi
                        // them những ThietBi co MaThongTinChung

                        List<NhanLuc> listNhanLucCu = _nhanlucRespository.GetNhanLucByTCID(tochuc.MaToChuc);
                        foreach (var nlCu in listNhanLucCu)
                        {
                            _nhanlucRespository.Delete(nlCu);
                        }
                        IEnumerable<NhanLucVM> listNhanLuc = model.NhanLucRow;
                        if (listNhanLuc != null)
                        {
                            foreach (var i in listNhanLuc)
                            {
                                NhanLuc nl = new NhanLuc();
                                nl.MaToChuc = tochuc.MaToChuc;
                                nl.HoTen = i.HoTen;
                                nl.ChucVu = i.ChucVu;
                                nl.TrinhDoHocVan = i.TrinhDoHocVan;
                                nl.ThamNien = i.ThamNien;
                                _nhanlucRespository.Add(nl);
                                NhanLuc nl1 = new NhanLuc();
                                nl1.MaThongTinChung = ttc.MaThongTinChung;
                                nl1.HoTen = i.HoTen;
                                nl1.ChucVu = i.ChucVu;
                                nl1.TrinhDoHocVan = i.TrinhDoHocVan;
                                nl1.ThamNien = i.ThamNien;
                                _nhanlucRespository.Add(nl1);
                            }
                        }

                        HoSoGiayPhep hs = new HoSoGiayPhep();
                        hs.MaToChuc = tochuc.MaToChuc;
                        hs.MaThongTinChung = ttc.MaThongTinChung;
                        hs.NgayXinPhep = DateTime.Today;
                        hs.TinhTrang = 1;
                        hs.CamKet = model.Camket;
                        //hs.LyDo = model
                        if (Request.Files["tepdinhkem"] != null) // If uploaded synchronously
                        {
                            var tep_guid = _fileStore.SaveUploadedFile(Request.Files["tepdinhkem"]);
                            var tep_filename = Request.Files["tepdinhkem"].FileName;
                            hs.TepDinhKem = tep_guid.ToString();
                        }
                        else {
                            hs.TepDinhKem = Request["tepdinhkem_guid"].ToString();
                            
                        }
                        _hsgpRepository.Add(hs);

                        ///add dang ky hoat dong
                        IList<int> listDK = model.DSHoatDongSelecteds;
                        if (listDK != null)
                        {
                            foreach (var i in listDK)
                            {
                                DangKyHoatDong dk = new DangKyHoatDong();
                                dk.MaHoSo = hs.MaHoSo;
                                dk.MaHoatDong = i;
                                dk.LanBoSung = 0;
                                _dkhdRespository.Add(dk);
                            }
                        }
                        scope.Complete();
                    }
                    catch (Exception ex)
                    {
                        //MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "Gửi hồ sơ không thành công" }, HttpContext.Response);
                    }
                }
            }
            else
            {
                using (TransactionScope s2 = new TransactionScope())
                {
                    List<ToChuc> tcs = tk.ToChucs.ToList();
                    if (tcs.Count == 0)
                    {
                        ToChuc tc = new ToChuc();
                        tc.TenToChuc = model.TenToChuc;
                        tc.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
                        tc.HangDoanhNghiep = model.HangDoanhNghiep;
                        tc.VonLuuDong = model.VonLuuDong;
                        tc.VonPhapDinh = model.VonPhapDinh;
                        tc.SoTaiKhoan = model.SoTaiKhoan;
                        tc.TongSoCanBo = model.TongSoCanBo;
                        tc.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                        tc.TruSoChinh = model.TruSoChinh;
                        tc.NguoiDaiDien = model.NguoiDaiDien;
                        tc.DienThoai = model.DienThoai;
                        tc.Email = model.Email;
                        tc.Fax = model.Fax;
                        tc.MaTaiKhoan = tk.MaTaiKhoan;
                        _tochucRespository.Add(tc);
                    }
                    else
                    {
                        ToChuc tc = tcs[0];
                        tc.TenToChuc = model.TenToChuc;
                        tc.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
                        tc.HangDoanhNghiep = model.HangDoanhNghiep;
                        tc.VonLuuDong = model.VonLuuDong;
                        tc.VonPhapDinh = model.VonPhapDinh;
                        tc.SoTaiKhoan = model.SoTaiKhoan;
                        tc.TongSoCanBo = model.TongSoCanBo;
                        tc.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                        tc.TruSoChinh = model.TruSoChinh;
                        tc.NguoiDaiDien = model.NguoiDaiDien;
                        tc.DienThoai = model.DienThoai;
                        tc.Email = model.Email;
                        tc.Fax = model.Fax;
                        _tochucRespository.Save();
                    }

                    ToChuc tochuc = _tochucRespository.GetToChucByTaiKhoan(tk.MaTaiKhoan);
                    List<NhanLuc> listNhanLucCu = _nhanlucRespository.GetNhanLucByTCID(tochuc.MaToChuc);
                    foreach (var nlCu in listNhanLucCu)
                    {
                        _nhanlucRespository.Delete(nlCu);
                    }
                    IEnumerable<NhanLucVM> listNhanLuc = model.NhanLucRow;
                    foreach (var i in listNhanLuc)
                    {
                        NhanLuc nl = new NhanLuc();
                        nl.MaToChuc = tochuc.MaToChuc;
                        nl.HoTen = i.HoTen;
                        nl.ChucVu = i.ChucVu;
                        nl.TrinhDoHocVan = i.TrinhDoHocVan;
                        nl.ThamNien = i.ThamNien;
                        _nhanlucRespository.Add(nl);
                    }

                    List<NangLucKeKhai> listNangLucCu = _nanglucRespository.GetNangLucByTCID(tochuc.MaToChuc);
                    foreach (var nlCu in listNangLucCu)
                    {
                        _nanglucRespository.Delete(nlCu);
                    }
                    IEnumerable<NangLucVM> listNangLuc = model.NangLucRow;
                    foreach (var i in listNangLuc)
                    {
                        NangLucKeKhai nl = new NangLucKeKhai();
                        nl.MaToChuc = tochuc.MaToChuc;
                        nl.NganhNghe = i.NganhNghe;
                        nl.SoTrenDaiHoc = i.Daihoc;
                        nl.SoTrungCap = i.TrungCap;
                        nl.SoCongNhanKyThuat = i.CongNhan;
                        nl.LoaiKhac = i.LoaiKhac;
                        _nanglucRespository.Add(nl);
                    }

                    List<ThietBi> listThietBiCu = _thietbiRespository.GetThietBiByTCID(tochuc.MaToChuc);
                    foreach (var tbCu in listThietBiCu)
                    {
                        _thietbiRespository.Delete(tbCu);
                    }
                    IEnumerable<ThietBiVM> listThietBi = model.ThietBiRow;
                    foreach (var i in listThietBi)
                    {
                        ThietBi tb = new ThietBi();
                        tb.MaToChuc = tochuc.MaToChuc;
                        tb.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                        tb.SoLuong = i.SoLuong;
                        tb.TinhTrang = i.TinhTrang;
                        tb.GhiChu = i.GhiChu;
                        _thietbiRespository.Add(tb);
                    }
                    s2.Complete();
                }
            }
            return View();

            //HoSoGiayPhep hsgp = new HoSoGiayPhep();
        }

        [HttpGet]
        public ActionResult BoSungGiayPhep()
        {
            // Get current user
            // Check whether User' Organization is exist (true)
            //      Load User' Organiztion
            // else new detail
            //return View(model)

            ToChucBoSungViewModel model = new ToChucBoSungViewModel();

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
                ToChuc tc = tcs[0];
                model.NangLucs = new List<NangLucVM> { };
                List<NangLucKeKhai> listNangLuc = new List<NangLucKeKhai>();
                listNangLuc = _nanglucRespository.GetNangLucByTCID(tc.MaToChuc);
                if (listNangLuc != null)
                {
                    foreach (var nl in listNangLuc)
                    {
                        NangLucVM nangluc = new NangLucVM();
                        nangluc.NganhNghe = nl.NganhNghe;
                        nangluc.Daihoc = nl.SoTrenDaiHoc;
                        nangluc.TrungCap = nl.SoTrungCap;
                        nangluc.CongNhan = nl.SoCongNhanKyThuat;
                        nangluc.LoaiKhac = nl.LoaiKhac;
                        model.NangLucs.Add(nangluc);
                    }
                }

                model.NhanLucs = new List<NhanLucVM> { };
                List<NhanLuc> listNhanLuc = new List<NhanLuc>();
                listNhanLuc = _nhanlucRespository.GetNhanLucByTCID(tc.MaToChuc);
                if (listNhanLuc != null)
                {
                    foreach (var nl in listNhanLuc)
                    {
                        NhanLucVM nhanluc = new NhanLucVM();
                        nhanluc.HoTen = nl.HoTen;
                        nhanluc.ChucVu = nl.ChucVu;
                        nhanluc.TrinhDoHocVan = nl.TrinhDoHocVan;
                        nhanluc.ThamNien = nl.ThamNien;
                        model.NhanLucs.Add(nhanluc);
                    }
                }

                model.ThietBis = new List<ThietBiVM> { };
                List<ThietBi> listThietBi = new List<ThietBi>();
                listThietBi = _thietbiRespository.GetThietBiByTCID(tc.MaToChuc);
                if (listThietBi != null)
                {
                    foreach (var tb in listThietBi)
                    {
                        ThietBiVM thietbi = new ThietBiVM();
                        thietbi.TenThietBi_CongNghe = tb.TenThietBi_CongNghe;
                        thietbi.SoLuong = tb.SoLuong;
                        thietbi.GhiChu = tb.GhiChu;
                        thietbi.TinhTrang = tb.TinhTrang;
                        model.ThietBis.Add(thietbi);
                    }
                }

                model.DSHoatDongSelecteds = new int[] { };
                model.DSHoatDongs = new List<HoatDong> { new HoatDong { MaHoatDong = 1, TenHoatDong = "sdf" }, new HoatDong { MaHoatDong = 2, TenHoatDong = "gfg" } };


                model.TenToChuc = tc.TenToChuc;
                model.MaToChuc = tc.MaToChuc;
                model.DienThoai = tc.DienThoai;
                model.Email = tc.Email;
                model.Fax = tc.Fax;
                model.GiayPhepKinhDoanh = tc.GiayPhepKinhDoanh;
                model.HangDoanhNghiep = tc.HangDoanhNghiep;
                model.MaLoaiHinhToChuc = (int)tc.MaLoaiHinhToChuc;
                model.NguoiDaiDien = tc.NguoiDaiDien;
                model.SoTaiKhoan = tc.SoTaiKhoan;
                model.TongSoCanBo = tc.TongSoCanBo.GetValueOrDefault(0);
                model.TruSoChinh = tc.TruSoChinh;
                model.VonLuuDong = tc.VonLuuDong.GetValueOrDefault(0);
                model.VonPhapDinh = tc.VonPhapDinh.GetValueOrDefault(0);
            }

            model.DSHoatDongDaDKs = new List<string>(){"sfd","sdf"};

            model.loaiHinh = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();

            model.Camket = "Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.";

            //model.NangLucs = new List<NangLucVM> { new NangLucVM{NganhNghe="sdf",
            //     Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2},new NangLucVM{NganhNghe="sdf",
            //     Daihoc=1,CongNhan=2,TrungCap=3,LoaiKhac=2} };

            // Mã nhũng hoạt động khi được chọn từ danh sách hoạt động
            // Ban đầu thì không có phần tử nào

            model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();

            //model.DSHoatDongSelecteds = 

            // Load danh sách Hoạt động vào đây.

            return View(model);
        }

        [HttpPost]
        public ActionResult Luu(ToChucDetailViewModel model)
        {
            return View();
        }

        public ActionResult ThongTinChung()
        {
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

        public ViewResult BlankCongTrinhRow(string formId)
        {
            return new AjaxViewResult("CongTrinhEditorRow", new CongTrinhVM()) { UpdateValidationForFormId = formId };
        }

        public string Uploader()
        {
            return _fileStore.SaveUploadedFile(Request.Files[0]);
        }
    }
}
