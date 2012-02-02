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
        private IBaoCaoHoatDongRepository _bchdRespository;
        private IBaoCaoCongTrinhRespository _bcctRespository;

        public DangKyGiayPhepController()
            : this(new DiskFileStore("~/App_Data/Upload/HSToChuc"), new HoSoGiayPhepRepository(), new DangKyHoatDongRespository(),
                new ThongTinChungRespository(), new LoaiHinhToChucRepository(), new ToChucRepository(), new NangLucKeKhaiRespository(),
                new ThietBiRespository(), new NhanLucRespository(), new HoatDongRespository(), new BaoCaoHoatDongRespository(),
                new BaoCaoCongTrinhRespository())
        { }

        public DangKyGiayPhepController(IFileStore fileStore, IHoSoGiayPhepRepository gphdRepository, IDangKyHoatDongRepository dkhdRepository,
                        IThongTinChungRespository ttcRespository, ILoaiHinhToChucRepository lhtcRepository, IToChucRepository tochucRespository,
                        INangLucKeKhaiRespository nanglucRespository, IThietBiRepository thietbiRespository,
                        INhanLucRepository nhanlucRespository, IHoatDongRepository hoatdongRespository,
                        IBaoCaoHoatDongRepository baocaohdRespository, IBaoCaoCongTrinhRespository baocaoctRespository)
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
            _bchdRespository = baocaohdRespository;
            _bcctRespository = baocaoctRespository;
        }
        //
        // GET: /DangKyGiayPhep/
        [Authorize]
        public ActionResult Index()
        {
            return RedirectToAction("TaoMoi");
        }

        [Authorize]
        [HttpGet]
        public ActionResult TaoMoi()
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            List<ToChuc> tcs = tk.ToChucs.ToList();
            ToChucDetailViewModel model = new ToChucDetailViewModel();

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
                //kiểm tra được phép đăng ký mới hay không
                int check = _hsgpRepository.Check(tc.MaToChuc);
                if (check == 1 || check == 4 || check == 5 || check == 6 || check == 8 || check == 9 || check == 11)
                    return RedirectToAction("ThongBao", new { iMsg = check });

                model.NangLucs = new List<NangLucVM> { };
                List<NangLucKeKhai> listNangLuc = new List<NangLucKeKhai>();
                listNangLuc = _nanglucRespository.GetNangLucByTCID(tc.MaToChuc);
                if (listNangLuc != null)
                {
                    foreach (var nl in listNangLuc)
                    {
                        NangLucVM nangluc = new NangLucVM();
                        nangluc.NganhNghe = nl.NganhNghe;
                        nangluc.Daihoc = nl.SoTrenDaiHoc.GetValueOrDefault(0);
                        nangluc.TrungCap = nl.SoTrungCap.GetValueOrDefault(0);
                        nangluc.CongNhan = nl.SoCongNhanKyThuat.GetValueOrDefault(0);
                        nangluc.LoaiKhac = nl.LoaiKhac.GetValueOrDefault(0);
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
                        thietbi.SoLuong = tb.SoLuong.GetValueOrDefault(0);
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
            model.LyDo = "Xin đăng ký giấy phép mới.";

            // Mã nhũng hoạt động khi được chọn từ danh sách hoạt động
            // Ban đầu thì không có phần tử nào
            model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();
            return View(model);
        }

        [HttpPost]
        public ActionResult TaoMoi(ToChucDetailViewModel model, int save)
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            int msg = 0;

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
                                _tochucRespository.Update(t);
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
                                nl.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                nl.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                nl.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                nl.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                _nanglucRespository.Add(nl);
                                NangLucKeKhai nl1 = new NangLucKeKhai();
                                nl1.MaThongTinChung = ttc.MaThongTinChung;
                                nl1.NganhNghe = i.NganhNghe;
                                nl1.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                nl1.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                nl1.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                nl1.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
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
                                tb.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                tb.TinhTrang = i.TinhTrang;
                                tb.GhiChu = i.GhiChu;
                                _thietbiRespository.Add(tb);
                                ThietBi tb1 = new ThietBi();
                                tb1.MaThongTinChung = ttc.MaThongTinChung;
                                tb1.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                tb1.SoLuong = i.SoLuong.GetValueOrDefault(0);
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
                        hs.LoaiGiayPhep = 1;
                        hs.CamKet = model.Camket;
                        hs.LyDo = model.LyDo;
                        if (Request.Files["tepdinhkem"] != null) // If uploaded synchronously
                        {
                            var tep_guid = _fileStore.SaveUploadedFile(Request.Files["tepdinhkem"]);
                            var tep_filename = Request.Files["tepdinhkem"].FileName;
                            hs.TepDinhKem = tep_guid.ToString();
                        }
                        else
                        {
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
                        msg = 20;
                    }
                    catch (Exception ex)
                    {
                        //MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "Gửi hồ sơ không thành công" }, HttpContext.Response);
                        msg = 21;
                    }
                }
            }
            else
            {
                try
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
                            _tochucRespository.Update(tc);
                        }

                        ToChuc tochuc = _tochucRespository.GetToChucByTaiKhoan(tk.MaTaiKhoan);
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
                                nl.ThamNien = i.ThamNien;
                                _nhanlucRespository.Add(nl);
                            }
                        }

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
                                nl.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                nl.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                nl.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                nl.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                _nanglucRespository.Add(nl);
                            }
                        }

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
                                tb.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                tb.TinhTrang = i.TinhTrang;
                                tb.GhiChu = i.GhiChu;
                                _thietbiRespository.Add(tb);
                            }
                        }
                        s2.Complete();
                        msg = 22;
                    }
                }
                catch (Exception ex)
                {
                    msg = 23;
                }
            }
            return RedirectToAction("ThongBao", new { iMsg = msg });
        }

        [Authorize]
        [HttpGet]
        public ActionResult BoSungGiayPhep()
        {
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
                model.DSHoatDongDaDKs = new List<string> { };
                model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();
                model.CongTrinhs = new List<CongTrinhVM> { };
                ViewData["sogiayphep"] = 0;
            }
            // Da co thong tin to chuc cua tai khoan do
            else
            {
                ToChuc tc = tcs[0];
                //kiểm tra xem tổ chức có được đăng ký bổ sung hoạt động không
                int check = _hsgpRepository.Check(tc.MaToChuc);
                if (check == 1 || check == 2 || check == 3 || check == 4 || check == 6 || check == 9 || check == 10 || check == 12)
                    return RedirectToAction("ThongBao", new { iMsg = check });

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

                //nếu đã có thông tin tổ chức thì lấy list năng lực, lấy list nhân lực, list thiết bị
                model.NangLucs = new List<NangLucVM> { };
                List<NangLucKeKhai> listNangLuc = new List<NangLucKeKhai>();
                listNangLuc = _nanglucRespository.GetNangLucByTCID(tc.MaToChuc);
                if (listNangLuc != null && listNangLuc.Count != 0)
                {
                    foreach (var nl in listNangLuc)
                    {
                        NangLucVM nangluc = new NangLucVM();
                        nangluc.NganhNghe = nl.NganhNghe;
                        nangluc.Daihoc = nl.SoTrenDaiHoc.GetValueOrDefault(0);
                        nangluc.TrungCap = nl.SoTrungCap.GetValueOrDefault(0);
                        nangluc.CongNhan = nl.SoCongNhanKyThuat.GetValueOrDefault(0);
                        nangluc.LoaiKhac = nl.LoaiKhac.GetValueOrDefault(0);
                        model.NangLucs.Add(nangluc);
                    }
                }
                //nhân lực
                model.NhanLucs = new List<NhanLucVM> { };
                List<NhanLuc> listNhanLuc = new List<NhanLuc>();
                listNhanLuc = _nhanlucRespository.GetNhanLucByTCID(tc.MaToChuc);
                if (listNhanLuc != null && listNhanLuc.Count != 0)
                {
                    foreach (var nl in listNhanLuc)
                    {
                        NhanLucVM nhanluc = new NhanLucVM();
                        nhanluc.HoTen = nl.HoTen;
                        nhanluc.ChucVu = nl.ChucVu;
                        nhanluc.ThamNien = nl.ThamNien;
                        model.NhanLucs.Add(nhanluc);
                    }
                }
                //thiết bị
                model.ThietBis = new List<ThietBiVM> { };
                List<ThietBi> listThietBi = new List<ThietBi>();
                listThietBi = _thietbiRespository.GetThietBiByTCID(tc.MaToChuc);
                if (listThietBi != null && listThietBi.Count != 0)
                {
                    foreach (var tb in listThietBi)
                    {
                        ThietBiVM thietbi = new ThietBiVM();
                        thietbi.TenThietBi_CongNghe = tb.TenThietBi_CongNghe;
                        thietbi.SoLuong = tb.SoLuong.GetValueOrDefault(0);
                        thietbi.GhiChu = tb.GhiChu;
                        thietbi.TinhTrang = tb.TinhTrang;
                        model.ThietBis.Add(thietbi);
                    }
                }
                /// báo cáo hoạt động
                BaoCaoHoatDong bc = _bchdRespository.GetBaoCaoHoatDongByTC(tc.MaToChuc);
                model.CongTrinhs = new List<CongTrinhVM> { };
                if (bc != null)
                {
                    model.TuNam = bc.TuNam;
                    model.DenNam = bc.DenNam;
                    model.DoanhThuNam = bc.DoanhThu.GetValueOrDefault(0);
                    model.NopNganSach = bc.NopNganSach.GetValueOrDefault(0);

                    List<BaoCaoCongTrinh> bcctList = _bcctRespository.GetBCCTByBCHD(bc.MaBaoCao);
                    if (bcctList.Count != 0)
                    {
                        foreach (var bcct in bcctList)
                        {
                            CongTrinhVM ct = new CongTrinhVM();
                            ct.ChuDauTu = bcct.ChuDauTu;
                            ct.TenCongTrinh = bcct.TenCongTrinh;
                            ct.CongDoanDaThiCong = bcct.CongDoanDaThiCong;
                            ct.ThoiGianThucHien = bcct.ThoiGianThucHien;
                            ct.GiaTriThucHien = bcct.GiaTriDaThucHien;
                            ct.GhiChu = bcct.GhiChu;
                            model.CongTrinhs.Add(ct);
                        }
                    }
                }

                ///kiểm tra có hồ sơ tồn tại chưa
                ///nếu đã tồn tại thì k cho điền số gp trên view, nếu chưa thì cho điền số gp trên view rồi lưu xuống.
                // lấy danh sách hoạt động đã được cấp (nếu có tổ chức rồi thì có thể là mảng rỗng hoặc không)

                IList<HoSoGiayPhep> listHS = _hsgpRepository.GetHSGPByToChuc(tc.MaToChuc);
                HoSoGiayPhep hs = new HoSoGiayPhep();
                if (listHS != null && listHS.Count != 0)
                {
                    ViewData["sogiayphep"] = 1;
                    hs = listHS[0];
                    model.SoGiayPhep = hs.SoGiayPhep;
                    if(hs.NgayCapPhep != null)
                    {
                        model.NgayCapPhepDoDac = (DateTime)hs.NgayCapPhep;
                    }
                    ///những hoạt động đã được cấp (lúc đăng ký + lúc bổ sung)
                    IList<HoatDongDuocCap> listHDDaCap = _dkhdRespository.GetHDDaCapBySoGP(model.SoGiayPhep, tc.MaToChuc);
                    model.DSHoatDongDaDKs = new List<string>();
                    model.DSHoatDongs = new List<HoatDong>();
                    List<HoatDong> allHD = _hoatdongRespository.GetHoatDongs().ToList();
                    foreach (var i in listHDDaCap)
                    {
                        model.DSHoatDongDaDKs.Add(i.TenHoatDong);
                        for (int j = 0; j < allHD.Count; j++)
                        {
                            if (allHD[j].MaHoatDong == i.MaHDHienTai)
                            {
                                allHD.RemoveAt(j);
                                break;
                            }
                        }
                    }
                    model.DSHoatDongs = allHD;
                    model.TepDinhKem = hs.TepDinhKem;
                    //model.NgayCapPhepDoDac = hs.NgayCapPhep;
                }
                else
                {
                    ViewData["sogiayphep"] = 0;
                    model.SoGiayPhep = "";
                    model.DSHoatDongDaDKs = new List<string> { };
                    model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();
                }
            }

            model.DSHoatDongSelecteds = new int[] { };
            model.loaiHinh = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();
            model.Camket = "Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.";
            model.LyDo = "Xin đăng ký bổ sung hoạt động đo đạc";

            return View(model);
        }

        [HttpPost]
        public ActionResult BoSungGiayPhep(ToChucBoSungViewModel model, int save)
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            int msg = 0;

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
                                _tochucRespository.Update(t);
                            }
                            s1.Complete();
                        }
                        // xoa nhung nangluckekhai co MaToChuc va them vao nangluckekhai co MaToChuc moi
                        // them những nangluckekhai co MaThongTinChung

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
                                if (i.NganhNghe != "" && i.NganhNghe != null)
                                {
                                    NangLucKeKhai nl = new NangLucKeKhai();
                                    nl.MaToChuc = tochuc.MaToChuc;
                                    nl.NganhNghe = i.NganhNghe;
                                    nl.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                    nl.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                    nl.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                    nl.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                    _nanglucRespository.Add(nl);
                                    NangLucKeKhai nl1 = new NangLucKeKhai();
                                    nl1.MaThongTinChung = ttc.MaThongTinChung;
                                    nl1.NganhNghe = i.NganhNghe;
                                    nl1.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                    nl1.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                    nl1.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                    nl1.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                    _nanglucRespository.Add(nl1);
                                }
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
                                if (i.TenThietBi_CongNghe != "" && i.TenThietBi_CongNghe != null)
                                {
                                    ThietBi tb = new ThietBi();
                                    tb.MaToChuc = tochuc.MaToChuc;
                                    tb.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                    tb.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                    tb.TinhTrang = i.TinhTrang;
                                    tb.GhiChu = i.GhiChu;
                                    _thietbiRespository.Add(tb);
                                    ThietBi tb1 = new ThietBi();
                                    tb1.MaThongTinChung = ttc.MaThongTinChung;
                                    tb1.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                    tb1.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                    tb1.TinhTrang = i.TinhTrang;
                                    tb1.GhiChu = i.GhiChu;
                                    _thietbiRespository.Add(tb1);
                                }
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
                                if (i.HoTen != "" && i.HoTen != null)
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
                        }
                        ///xóa báo cáo hoạt động có mã tổ chức
                        ///xóa báo cáo hoạt động có mã báo cáo
                        //thêm báo cáo hoạt động mới(1 cho tổ chức + 1 cho thông tin chung)
                        //thêm những row báo cáo công trình mới

                        BaoCaoHoatDong bchd1 = _bchdRespository.GetBaoCaoHoatDongByTC(tochuc.MaToChuc);
                        // bchd1.MaToChuc = tochuc.MaToChuc;
                        bchd1.TuNam = model.TuNam;
                        bchd1.DenNam = model.DenNam;
                        bchd1.DoanhThu = model.DoanhThuNam.GetValueOrDefault(0);
                        bchd1.NopNganSach = model.NopNganSach.GetValueOrDefault(0);
                        _bchdRespository.Update(bchd1);
                        BaoCaoHoatDong bchd2 = new BaoCaoHoatDong();
                        bchd2.MaThongTinChung = ttc.MaThongTinChung;
                        bchd2.TuNam = model.TuNam;
                        bchd2.DenNam = model.DenNam;
                        bchd2.DoanhThu = model.DoanhThuNam.GetValueOrDefault(0);
                        bchd2.NopNganSach = model.NopNganSach.GetValueOrDefault(0);
                        _bchdRespository.Add(bchd2);
                        List<BaoCaoCongTrinh> congtrinhListCu = _bcctRespository.GetBCCTByBCHD(bchd1.MaBaoCao);
                        foreach (var bc in congtrinhListCu)
                        {
                            _bcctRespository.Delete(bc);
                        }

                        IEnumerable<CongTrinhVM> congtrinhList = model.CongTrinhRow;
                        if (congtrinhList != null)
                        {
                            foreach (var i in congtrinhList)
                            {
                                if (i.TenCongTrinh != "" && i.TenCongTrinh != null)
                                {
                                    BaoCaoCongTrinh bc = new BaoCaoCongTrinh();
                                    bc.MaBaoCao = bchd1.MaBaoCao;
                                    bc.TenCongTrinh = i.TenCongTrinh;
                                    bc.ChuDauTu = i.ChuDauTu;
                                    bc.ThoiGianThucHien = i.ThoiGianThucHien;
                                    bc.GiaTriDaThucHien = i.GiaTriThucHien;
                                    bc.GhiChu = i.GhiChu;
                                    _bcctRespository.Add(bc);
                                    BaoCaoCongTrinh bc1 = new BaoCaoCongTrinh();
                                    bc1.MaBaoCao = bchd2.MaBaoCao;
                                    bc1.TenCongTrinh = i.TenCongTrinh;
                                    bc1.ChuDauTu = i.ChuDauTu;
                                    bc1.ThoiGianThucHien = i.ThoiGianThucHien;
                                    bc1.GiaTriDaThucHien = i.GiaTriThucHien;
                                    bc1.GhiChu = i.GhiChu;
                                    _bcctRespository.Add(bc1);
                                }
                            }
                        }

                        HoSoGiayPhep hs = new HoSoGiayPhep();
                        hs.MaToChuc = tochuc.MaToChuc;
                        hs.SoGiayPhep = model.SoGiayPhep;
                        hs.MaThongTinChung = ttc.MaThongTinChung;
                        hs.NgayXinPhep = DateTime.Today;
                        hs.TinhTrang = 6;
                        hs.LoaiGiayPhep = 2;
                        hs.CamKet = model.Camket;
                        hs.LyDo = model.LyDo;
                        if (Request.Files["tepdinhkem"] != null) // If uploaded synchronously
                        {
                            var tep_guid = _fileStore.SaveUploadedFile(Request.Files["tepdinhkem"]);
                            var tep_filename = Request.Files["tepdinhkem"].FileName;
                            hs.TepDinhKem = tep_guid.ToString();
                        }
                        else
                        {
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
                                dk.LanBoSung = _dkhdRespository.getSoLanBoSung(tochuc.MaToChuc);
                                _dkhdRespository.Add(dk);
                            }
                        }

                        scope.Complete();
                        msg = 1;
                    }
                    catch (Exception ex)
                    {
                        //MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "Gửi hồ sơ không thành công" }, HttpContext.Response);
                        msg = 2;
                    }
                }
            }
            else
            {
                try
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
                            _tochucRespository.Update(tc);
                        }

                        ToChuc tochuc = _tochucRespository.GetToChucByTaiKhoan(tk.MaTaiKhoan);
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
                                nl.ThamNien = i.ThamNien;
                                _nhanlucRespository.Add(nl);
                            }
                        }

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
                                nl.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                nl.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                nl.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                nl.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                _nanglucRespository.Add(nl);
                            }
                        }

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
                                tb.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                tb.TinhTrang = i.TinhTrang;
                                tb.GhiChu = i.GhiChu;
                                _thietbiRespository.Add(tb);
                            }
                        }

                        /// cập nhật báo cáo hoạt động có mã tổ chức, xóa hết báo cáo công trình có mã báo cáo vừa update
                        /// thêm bc công trình với mã báo cáo cũ
                        BaoCaoHoatDong bchd1 = _bchdRespository.GetBaoCaoHoatDongByTC(tochuc.MaToChuc);
                        bchd1.MaToChuc = tochuc.MaToChuc;
                        bchd1.TuNam = model.TuNam;
                        bchd1.DenNam = model.DenNam;
                        bchd1.DoanhThu = model.DoanhThuNam.GetValueOrDefault(0);
                        bchd1.NopNganSach = model.NopNganSach.GetValueOrDefault(0);
                        _bchdRespository.Update(bchd1);

                        List<BaoCaoCongTrinh> congtrinhListCu = _bcctRespository.GetBCCTByBCHD(bchd1.MaBaoCao);
                        foreach (var bc in congtrinhListCu)
                        {
                            _bcctRespository.Delete(bc);
                        }

                        IEnumerable<CongTrinhVM> congtrinhList = model.CongTrinhRow;
                        if (congtrinhList != null)
                        {
                            foreach (var i in congtrinhList)
                            {
                                BaoCaoCongTrinh bc = new BaoCaoCongTrinh();
                                bc.MaBaoCao = bchd1.MaBaoCao;
                                bc.TenCongTrinh = i.TenCongTrinh;
                                bc.ChuDauTu = i.ChuDauTu;
                                bc.ThoiGianThucHien = i.ThoiGianThucHien;
                                bc.GiaTriDaThucHien = i.GiaTriThucHien;
                                bc.GhiChu = i.GhiChu;
                                _bcctRespository.Add(bc);
                            }
                        }

                        s2.Complete();
                        msg = 3;
                    }
                }
                catch (Exception ex)
                {
                    msg = 4;
                }
            }
            return RedirectToAction("ThongBao", new { iMsg = msg });

            //HoSoGiayPhep hsgp = new HoSoGiayPhep();
        }

        [Authorize]
        [HttpGet]
        public ActionResult GiaHanGiayPhep()
        {
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
                model.DSHoatDongDaDKs = new List<string> { };
                model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();
                model.CongTrinhs = new List<CongTrinhVM> { };
                ViewData["sogiayphep"] = 0;
            }
            // Da co thong tin to chuc cua tai khoan do
            else
            {
                ToChuc tc = tcs[0];
                var list = _hsgpRepository.GetHSGPByToChuc(tc.MaToChuc);
                
                //kiểm tra xem tổ chức có được đăng ký gia hạn giấy phép không
                int check = _hsgpRepository.Check(tc.MaToChuc);
                if (check == 1 || check == 2 || check == 3 || check == 4 || check == 6 || check == 9 || check == 11 || check == 12)
                    return RedirectToAction("ThongBao", new { iMsg = check });
                if (check == 5 || check == 8)
                {
                    if (list != null && list.Count != 0)
                    {
                        HoSoGiayPhep hs = list[0];
                        //kiểm tra thời gian hết hạn, nếu thỏa 30< thời gian< 60 ngày=> cho gia hạn
                        TimeSpan songay = hs.NgayHetHan.Value.Subtract(DateTime.Today);
                        int k = songay.Days;
                        if (k < 30 || k > 60)
                        {
                            return RedirectToAction("ThongBao", new { iMsg = 13 });
                        }
                    }
                }
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
                    model.VonLuuDong = decimal.ToInt64(tc.VonLuuDong.GetValueOrDefault(0));
                    model.VonPhapDinh = tc.VonPhapDinh.GetValueOrDefault(0);

                    //nếu đã có thông tin tổ chức thì lấy list năng lực, lấy list nhân lực, list thiết bị
                    model.NangLucs = new List<NangLucVM> { };
                    List<NangLucKeKhai> listNangLuc = new List<NangLucKeKhai>();
                    listNangLuc = _nanglucRespository.GetNangLucByTCID(tc.MaToChuc);
                    if (listNangLuc != null && listNangLuc.Count != 0)
                    {
                        foreach (var nl in listNangLuc)
                        {
                            NangLucVM nangluc = new NangLucVM();
                            nangluc.NganhNghe = nl.NganhNghe;
                            nangluc.Daihoc = nl.SoTrenDaiHoc.GetValueOrDefault(0);
                            nangluc.TrungCap = nl.SoTrungCap.GetValueOrDefault(0);
                            nangluc.CongNhan = nl.SoCongNhanKyThuat.GetValueOrDefault(0);
                            nangluc.LoaiKhac = nl.LoaiKhac.GetValueOrDefault(0);
                            model.NangLucs.Add(nangluc);
                        }
                    }
                    //nhân lực
                    model.NhanLucs = new List<NhanLucVM> { };
                    List<NhanLuc> listNhanLuc = new List<NhanLuc>();
                    listNhanLuc = _nhanlucRespository.GetNhanLucByTCID(tc.MaToChuc);
                    if (listNhanLuc != null && listNhanLuc.Count != 0)
                    {
                        foreach (var nl in listNhanLuc)
                        {
                            NhanLucVM nhanluc = new NhanLucVM();
                            nhanluc.HoTen = nl.HoTen;
                            nhanluc.ChucVu = nl.ChucVu;
                            nhanluc.ThamNien = nl.ThamNien;
                            model.NhanLucs.Add(nhanluc);
                        }
                    }
                    //thiết bị
                    model.ThietBis = new List<ThietBiVM> { };
                    List<ThietBi> listThietBi = new List<ThietBi>();
                    listThietBi = _thietbiRespository.GetThietBiByTCID(tc.MaToChuc);
                    if (listThietBi != null && listThietBi.Count != 0)
                    {
                        foreach (var tb in listThietBi)
                        {
                            ThietBiVM thietbi = new ThietBiVM();
                            thietbi.TenThietBi_CongNghe = tb.TenThietBi_CongNghe;
                            thietbi.SoLuong = tb.SoLuong.GetValueOrDefault(0);
                            thietbi.GhiChu = tb.GhiChu;
                            thietbi.TinhTrang = tb.TinhTrang;
                            model.ThietBis.Add(thietbi);
                        }
                    }
                    /// báo cáo hoạt động
                    BaoCaoHoatDong bc = _bchdRespository.GetBaoCaoHoatDongByTC(tc.MaToChuc);
                    model.CongTrinhs = new List<CongTrinhVM> { };
                    if (bc != null)
                    {
                        model.TuNam = bc.TuNam;
                        model.DenNam = bc.DenNam;
                        model.DoanhThuNam = bc.DoanhThu.GetValueOrDefault(0);
                        model.NopNganSach = bc.NopNganSach.GetValueOrDefault(0);

                        List<BaoCaoCongTrinh> bcctList = _bcctRespository.GetBCCTByBCHD(bc.MaBaoCao);
                        if (bcctList.Count != 0)
                        {
                            foreach (var bcct in bcctList)
                            {
                                CongTrinhVM ct = new CongTrinhVM();
                                ct.ChuDauTu = bcct.ChuDauTu;
                                ct.TenCongTrinh = bcct.TenCongTrinh;
                                ct.CongDoanDaThiCong = bcct.CongDoanDaThiCong;
                                ct.ThoiGianThucHien = bcct.ThoiGianThucHien;
                                ct.GiaTriThucHien = bcct.GiaTriDaThucHien;
                                ct.GhiChu = bcct.GhiChu;
                                model.CongTrinhs.Add(ct);
                            }
                        }
                    }

                    ///kiểm tra có hồ sơ tồn tại chưa
                    ///nếu đã tồn tại thì k cho điền số gp trên view, nếu chưa thì cho điền số gp trên view rồi lưu xuống.
                    // lấy danh sách hoạt động đã được cấp (nếu có tổ chức rồi thì có thể là mảng rỗng hoặc không)

                    if (list != null && list.Count != 0)
                    {
                        ViewData["sogiayphep"] = 1;
                        HoSoGiayPhep hs = list[0];
                        model.SoGiayPhep = hs.SoGiayPhep;
                        if (hs.NgayCapPhep != null)
                        {
                            model.NgayCapPhepDoDac = (DateTime)hs.NgayCapPhep;
                        }
                        ///những hoạt động đã được cấp (lúc đăng ký + lúc bổ sung)
                        IList<HoatDongDuocCap> listHDDaCap = _dkhdRespository.GetHDDaCapBySoGP(model.SoGiayPhep, tc.MaToChuc);
                        model.DSHoatDongDaDKs = new List<string>();
                        foreach (var i in listHDDaCap)
                        {
                            model.DSHoatDongDaDKs.Add(i.TenHoatDong);
                        }
                        model.TepDinhKem = hs.TepDinhKem;
                    }
                    else
                    {
                        ViewData["sogiayphep"] = 0;
                        model.SoGiayPhep = "";
                        model.DSHoatDongDaDKs = new List<string> { };
                        model.DSHoatDongs = _hoatdongRespository.GetHoatDongs().ToList();
                    }
                }

                model.DSHoatDongSelecteds = new int[] { };
                model.loaiHinh = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();
                model.Camket = "Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.";
                model.LyDo = "Xin đăng ký gia hạn giấy phép hoạt động";

                return View(model);
            }
        [HttpPost]
        public ActionResult GiaHanGiayPhep(ToChucBoSungViewModel model, int save)
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            int msg = 0;

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
                                _tochucRespository.Update(t);
                            }
                            s1.Complete();
                        }
                        // xoa nhung nangluckekhai co MaToChuc va them vao nangluckekhai co MaToChuc moi
                        // them những nangluckekhai co MaThongTinChung

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
                                if (i.NganhNghe != "" && i.NganhNghe != null)
                                {
                                    NangLucKeKhai nl = new NangLucKeKhai();
                                    nl.MaToChuc = tochuc.MaToChuc;
                                    nl.NganhNghe = i.NganhNghe;
                                    nl.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                    nl.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                    nl.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                    nl.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                    _nanglucRespository.Add(nl);
                                    NangLucKeKhai nl1 = new NangLucKeKhai();
                                    nl1.MaThongTinChung = ttc.MaThongTinChung;
                                    nl1.NganhNghe = i.NganhNghe;
                                    nl1.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                    nl1.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                    nl1.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                    nl1.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                    _nanglucRespository.Add(nl1);
                                }
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
                                if (i.TenThietBi_CongNghe != "" && i.TenThietBi_CongNghe != null)
                                {
                                    ThietBi tb = new ThietBi();
                                    tb.MaToChuc = tochuc.MaToChuc;
                                    tb.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                    tb.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                    tb.TinhTrang = i.TinhTrang;
                                    tb.GhiChu = i.GhiChu;
                                    _thietbiRespository.Add(tb);
                                    ThietBi tb1 = new ThietBi();
                                    tb1.MaThongTinChung = ttc.MaThongTinChung;
                                    tb1.TenThietBi_CongNghe = i.TenThietBi_CongNghe;
                                    tb1.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                    tb1.TinhTrang = i.TinhTrang;
                                    tb1.GhiChu = i.GhiChu;
                                    _thietbiRespository.Add(tb1);
                                }
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
                                if (i.HoTen != "" && i.HoTen != null)
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
                        }
                        ///xóa báo cáo hoạt động có mã tổ chức
                        ///xóa báo cáo hoạt động có mã báo cáo
                        //thêm báo cáo hoạt động mới(1 cho tổ chức + 1 cho thông tin chung)
                        //thêm những row báo cáo công trình mới

                        BaoCaoHoatDong bchd1 = _bchdRespository.GetBaoCaoHoatDongByTC(tochuc.MaToChuc);
                        // bchd1.MaToChuc = tochuc.MaToChuc;
                        bchd1.TuNam = model.TuNam;
                        bchd1.DenNam = model.DenNam;
                        bchd1.DoanhThu = model.DoanhThuNam.GetValueOrDefault(0);
                        bchd1.NopNganSach = model.NopNganSach.GetValueOrDefault(0);
                        _bchdRespository.Update(bchd1);
                        BaoCaoHoatDong bchd2 = new BaoCaoHoatDong();
                        bchd2.MaThongTinChung = ttc.MaThongTinChung;
                        bchd2.TuNam = model.TuNam;
                        bchd2.DenNam = model.DenNam;
                        bchd2.DoanhThu = model.DoanhThuNam.GetValueOrDefault(0);
                        bchd2.NopNganSach = model.NopNganSach.GetValueOrDefault(0);
                        _bchdRespository.Add(bchd2);
                        List<BaoCaoCongTrinh> congtrinhListCu = _bcctRespository.GetBCCTByBCHD(bchd1.MaBaoCao);
                        foreach (var bc in congtrinhListCu)
                        {
                            _bcctRespository.Delete(bc);
                        }

                        IEnumerable<CongTrinhVM> congtrinhList = model.CongTrinhRow;
                        if (congtrinhList != null)
                        {
                            foreach (var i in congtrinhList)
                            {
                                if (i.TenCongTrinh != "" && i.TenCongTrinh != null)
                                {
                                    BaoCaoCongTrinh bc = new BaoCaoCongTrinh();
                                    bc.MaBaoCao = bchd1.MaBaoCao;
                                    bc.TenCongTrinh = i.TenCongTrinh;
                                    bc.ChuDauTu = i.ChuDauTu;
                                    bc.ThoiGianThucHien = i.ThoiGianThucHien;
                                    bc.GiaTriDaThucHien = i.GiaTriThucHien;
                                    bc.GhiChu = i.GhiChu;
                                    _bcctRespository.Add(bc);
                                    BaoCaoCongTrinh bc1 = new BaoCaoCongTrinh();
                                    bc1.MaBaoCao = bchd2.MaBaoCao;
                                    bc1.TenCongTrinh = i.TenCongTrinh;
                                    bc1.ChuDauTu = i.ChuDauTu;
                                    bc1.ThoiGianThucHien = i.ThoiGianThucHien;
                                    bc1.GiaTriDaThucHien = i.GiaTriThucHien;
                                    bc1.GhiChu = i.GhiChu;
                                    _bcctRespository.Add(bc1);
                                }
                            }
                        }

                        HoSoGiayPhep hs = new HoSoGiayPhep();
                        hs.MaToChuc = tochuc.MaToChuc;
                        hs.SoGiayPhep = model.SoGiayPhep;
                        hs.MaThongTinChung = ttc.MaThongTinChung;
                        hs.NgayXinPhep = DateTime.Today;
                        hs.TinhTrang = 9;
                        hs.LoaiGiayPhep = 3;
                        hs.CamKet = model.Camket;
                        hs.LyDo = model.LyDo;
                        if (Request.Files["tepdinhkem"] != null) // If uploaded synchronously
                        {
                            var tep_guid = _fileStore.SaveUploadedFile(Request.Files["tepdinhkem"]);
                            var tep_filename = Request.Files["tepdinhkem"].FileName;
                            hs.TepDinhKem = tep_guid.ToString();
                        }
                        else
                        {
                            hs.TepDinhKem = Request["tepdinhkem_guid"].ToString();
                        }
                        _hsgpRepository.Add(hs);

                        scope.Complete();
                        msg = 1;
                    }
                    catch (Exception ex)
                    {
                        //MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "Gửi hồ sơ không thành công" }, HttpContext.Response);
                        msg = 2;
                    }
                }
            }
            else
            {
                try
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
                            _tochucRespository.Update(tc);
                        }

                        ToChuc tochuc = _tochucRespository.GetToChucByTaiKhoan(tk.MaTaiKhoan);
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
                                nl.ThamNien = i.ThamNien;
                                _nhanlucRespository.Add(nl);
                            }
                        }

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
                                nl.SoTrenDaiHoc = i.Daihoc.GetValueOrDefault(0);
                                nl.SoTrungCap = i.TrungCap.GetValueOrDefault(0);
                                nl.SoCongNhanKyThuat = i.CongNhan.GetValueOrDefault(0);
                                nl.LoaiKhac = i.LoaiKhac.GetValueOrDefault(0);
                                _nanglucRespository.Add(nl);
                            }
                        }

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
                                tb.SoLuong = i.SoLuong.GetValueOrDefault(0);
                                tb.TinhTrang = i.TinhTrang;
                                tb.GhiChu = i.GhiChu;
                                _thietbiRespository.Add(tb);
                            }
                        }

                        /// cập nhật báo cáo hoạt động có mã tổ chức, xóa hết báo cáo công trình có mã báo cáo vừa update
                        /// thêm bc công trình với mã báo cáo cũ
                        BaoCaoHoatDong bchd1 = _bchdRespository.GetBaoCaoHoatDongByTC(tochuc.MaToChuc);
                        bchd1.MaToChuc = tochuc.MaToChuc;
                        bchd1.TuNam = model.TuNam;
                        bchd1.DenNam = model.DenNam;
                        bchd1.DoanhThu = model.DoanhThuNam.GetValueOrDefault(0);
                        bchd1.NopNganSach = model.NopNganSach.GetValueOrDefault(0);
                        _bchdRespository.Update(bchd1);

                        List<BaoCaoCongTrinh> congtrinhListCu = _bcctRespository.GetBCCTByBCHD(bchd1.MaBaoCao);
                        foreach (var bc in congtrinhListCu)
                        {
                            _bcctRespository.Delete(bc);
                        }

                        IEnumerable<CongTrinhVM> congtrinhList = model.CongTrinhRow;
                        if (congtrinhList != null)
                        {
                            foreach (var i in congtrinhList)
                            {
                                BaoCaoCongTrinh bc = new BaoCaoCongTrinh();
                                bc.MaBaoCao = bchd1.MaBaoCao;
                                bc.TenCongTrinh = i.TenCongTrinh;
                                bc.ChuDauTu = i.ChuDauTu;
                                bc.ThoiGianThucHien = i.ThoiGianThucHien;
                                bc.GiaTriDaThucHien = i.GiaTriThucHien;
                                bc.GhiChu = i.GhiChu;
                                _bcctRespository.Add(bc);
                            }
                        }

                        s2.Complete();
                        msg = 3;
                    }
                }
                catch (Exception ex)
                {
                    msg = 4;
                }
            }
            return RedirectToAction("ThongBao", new { iMsg = msg });

            //HoSoGiayPhep hsgp = new HoSoGiayPhep();
        }

        public ActionResult ThongBao(int iMsg)
        {
            var msg = iMsg;
            return View(msg);
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

        public ActionResult Download(string fn)
        {
            string pfn = Server.MapPath("~/App_Data/Upload/HSToChuc/" + fn);
            pfn = pfn.Replace("//", "/");
            if (fn == "" || fn == null)
            {
                throw new ArgumentException("Invalid file name or file not exists!");
            }
            if (!System.IO.File.Exists(pfn))
            {
                throw new ArgumentException("Invalid file name or file not exists!");
            }
            return new BinaryContentResult()
            {
                FileName = fn,
                ContentType = "application/octet-stream",
                Content = System.IO.File.ReadAllBytes(pfn)
            };
        }

        public ActionResult KetQuaHoSo() {
            ThamDinhEditViewModel model = new ThamDinhEditViewModel();
           
            return View(model);
        }
    }
}
