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
using System.Web.Hosting;
using System.IO;
using DocumentHandling;

namespace GIS.Controllers
{
    public class QLGiayPhepController : Controller
    {
        private IToChucRepository _tochucRepository;
        private ITaiKhoanRepository _taikhoanRepository;
        private IHoSoGiayPhepRepository _gphdRepository;
        private ITinhTrangGiayPhepRepository _ttgpRepository;
        private IDangKyHoatDongRepository _dkhdRespository;
        private IHoatDongRepository _hoatdongRespository;
        private INangLucKeKhaiRespository _nanglucRespository;
        //private IBaoCaoHoatDongRepository _bchdRespository;

       public QLGiayPhepController()
            : this(new ToChucRepository(), new TaiKhoanRepository(), new HoSoGiayPhepRepository(),
                        new TinhTrangGiayPhepRepository(), new DangKyHoatDongRespository(),
                        new HoatDongRespository(), new NangLucKeKhaiRespository())
        {
        }

       public QLGiayPhepController(IToChucRepository tochucRepository, ITaiKhoanRepository taikhoanRepository,
           IHoSoGiayPhepRepository gphdRepository, ITinhTrangGiayPhepRepository ttgpRepository, 
           IDangKyHoatDongRepository dkhdRespository, IHoatDongRepository hoatdongRepository,
           INangLucKeKhaiRespository nanglucRespository)
        {
            this._tochucRepository = tochucRepository;
            this._taikhoanRepository = taikhoanRepository;
            this._gphdRepository = gphdRepository;
            this._ttgpRepository = ttgpRepository;
            this._dkhdRespository = dkhdRespository;
            this._hoatdongRespository = hoatdongRepository;
           this._nanglucRespository = nanglucRespository;
          // this._bchdRespository = bchdRespository;
        }
        //
        // GET: /GiayPhep/
        [Authorize]
        [RoleFilter(Roles="4")]
       public ActionResult Index([DefaultValue(1)] int page)
       {
           ViewData["page"] = page;
           return View();
       }
      [Authorize]
        [RoleFilter(Roles = "4")]
       public ActionResult ListData(int sId, string sidx, string search, string sord, int page, int rows)
       {
           int i = sId;
           var listGiayPhep = _gphdRepository.GetHoSoGiayPheps(search);

           switch(i)
           {
               case 0: listGiayPhep = _gphdRepository.GetHoSoGiayPheps(search); break;
               case 1: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(1, search); break;
               case 2: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(2, search); break;
               case 3: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(3, search); break;
               case 4: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(4, search); break;
               case 5: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(5, search); break;
               case 6: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(6, search); break;
               case 7: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(7, search); break;
               case 8: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(8, search); break;
               case 9: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(9, search); break;
               case 10: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(10, search); break;
               case 11: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(11, search); break;
               case 12: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(12, search); break;
           }

           var pageIndex = Convert.ToInt32(page) - 1;
           var pageSize = rows;
           var totalRecords = listGiayPhep.Count();
           var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

           var models = listGiayPhep
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
                       id = u.MaHoSo,
                       cell = new string[] {
                           u.MaHoSo.ToString(),
                           u.ThongTinChung.TenToChuc,
                           u.NgayXinPhep.ToString(),
                           u.TinhTrangGiayPhep.DienGiai
                        }
                   })
           };

           return Json(jsonData, JsonRequestBehavior.AllowGet);
       }
      [Authorize]
      [RoleFilter(Roles = "4")]
        public ActionResult ChiTiet(int id){
            HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(id);
            if (gphd == null)
            {
                return RedirectToAction("ThongBao", new {iMsg = 2});
            }
            BaoCaoHoatDong bc = new BaoCaoHoatDong();
            bc = gphd.ThongTinChung.BaoCaoHoatDongs.SingleOrDefault(m=>m.MaThongTinChung == gphd.MaThongTinChung);
            int k = 0;
            if (bc != null)
            {
                k = bc.MaBaoCao;
            }
            var dangkyMoi = _dkhdRespository.GetDangKyHDMoi(id);
            var dangkyDuocCap = _dkhdRespository.GetDKHDDaCap(id);
            var dangkyBS = _dkhdRespository.GetDKHDBoSung(id);
            var model = new GiayPhepDetailModel
            {
                DangKy = dangkyMoi,
                DangKyDaCap = dangkyDuocCap,
                DangKyBoSung = dangkyBS,
                giayphep = gphd,
                MaBaoCao = k
                //hoatdong = hoatdongList
               // nangluc = nanglucList
            };
            return View(model);
        }
      [Authorize]
      [RoleFilter(Roles = "4")]
       public ActionResult Edit(int id)
       {
           HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(id);
           if (gphd == null)
           {
               return RedirectToAction("ThongBao", new { iMsg = 2 });
           }
           BaoCaoHoatDong bc = new BaoCaoHoatDong();
           bc = gphd.ThongTinChung.BaoCaoHoatDongs.SingleOrDefault(m => m.MaThongTinChung == gphd.MaThongTinChung);
           int k = 0;
           if (bc != null)
           {
               k = bc.MaBaoCao;
           }
           var dangkyMoi = _dkhdRespository.GetDangKyHDMoi(id);
           var dangkyDuocCap = _dkhdRespository.GetHDDaCapBySoGP(gphd.SoGiayPhep, gphd.ToChuc.MaToChuc);
           var dangkyBS = _dkhdRespository.GetDKHDBoSung(id);
           var model = new GiayPhepDetailModel
           {
               DangKy = dangkyMoi,
               DangKyDaCap = dangkyDuocCap.AsQueryable(),
               DangKyBoSung = dangkyBS,
               giayphep = gphd,
               MaBaoCao = k
               //hoatdong = hoatdongList
               // nangluc = nanglucList
           };
           return View(model);
       }
      [Authorize]
      [RoleFilter(Roles = "4")]
       public ActionResult HuyGiayPhep(int[] ids)
       {
           foreach (int i in ids)
           {
               HoSoGiayPhep hs = _gphdRepository.GetHoSoGiayPhepByID(i);
               _gphdRepository.Delete(hs);
           }
           return Redirect("Index");
       }
      [Authorize]
      [RoleFilter(Roles = "4")]
       public ActionResult Download(string fn) 
       {
           string pfn = Server.MapPath("~/App_Data/Upload/HSToChuc/" + fn);
           pfn = pfn.Replace("//", "/");
           if (!System.IO.File.Exists(pfn))
           {
               return RedirectToAction("ThongBao", new {iMsg = 1});
           }
           return new BinaryContentResult()
           {
               FileName = fn,
               ContentType = "application/octet-stream",
               Content = System.IO.File.ReadAllBytes(pfn)
           };
       }
       public ActionResult ThongBao(int iMsg)
       {
           var msg= iMsg;
           return View(msg);
       }

        public ActionResult DownloadBaoCao(int id)
        {
            HoSoGiayPhep hs = _gphdRepository.GetHoSoGiayPhepByID(id);
            if (hs.MaThongTinChung == null || !hs.MaThongTinChung.HasValue)
            {
                return RedirectToAction("ChiTiet", new { id = id });
            }

            IBaoCaoHoatDongRepository bchdRepo = new BaoCaoHoatDongRespository();
            IBaoCaoCongTrinhRespository bcctRepo = new BaoCaoCongTrinhRespository();
            BaoCaoHoatDong bchd = bchdRepo.GetBaoCaoHoatDongByTC(hs.MaThongTinChung.Value);
            if (bchd == null) {
                return RedirectToAction("ChiTiet", new { id = id });
            }

            List<BaoCaoCongTrinh> bccts = bcctRepo.GetBCCTByBCHD(bchd.MaBaoCao);

            String outputName = HttpContext.Session.SessionID + DateTime.Now.Ticks + ".docx";
            String tmpPath = Path.Combine(HostingEnvironment.MapPath("~/App_Data/Templates"), "PM32-2010-TT-BTNMT7.docx");
            String outPath = Path.Combine(HostingEnvironment.MapPath("~/App_Data/Download"), outputName);
            DocumentHandling.DocumentHandling handling = new PM32_2010_TT_BTNMT7Handling();

            DateTime ngayBaoCao = DateTime.Now;
            List<List<string>> congTrinhs = new List<List<string>>();
            for (int i = 0; i < bccts.Count; i++)
            {
                List<string> congTrinh = new List<string>();
                BaoCaoCongTrinh bcct = bccts[i];

                congTrinh.Add((i + 1).ToString());
                congTrinh.Add(bcct.TenCongTrinh);
                congTrinh.Add(bcct.ChuDauTu);
                congTrinh.Add(bcct.CongDoanDaThiCong);
                congTrinh.Add(bcct.GiaTriDaThucHien);
                congTrinh.Add(bcct.ThoiGianThucHien);
                congTrinh.Add(bcct.GhiChu);

                congTrinhs.Add(congTrinh);
            }

            handling.SettingParam(PM32_2010_TT_BTNMT7Handling.DIADIEM, "Hồ Chí Minh");
            handling.SettingParam(PM32_2010_TT_BTNMT7Handling.NGAY, ngayBaoCao.Day);
            handling.SettingParam(PM32_2010_TT_BTNMT7Handling.THANG, ngayBaoCao.Month);
            handling.SettingParam(PM32_2010_TT_BTNMT7Handling.NAM, ngayBaoCao.Year);
            if (bchd.TuNam != null && bchd.TuNam.HasValue)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT7Handling.TUNAM, bchd.TuNam.Value);
            }
            if (bchd.DenNam != null && bchd.DenNam.HasValue)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT7Handling.DENNAM, bchd.DenNam.Value);
            }
            if (bchd.ToChuc != null)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT7Handling.TOCHUCDUOCCAPGIAYPHEP, bchd.ToChuc.TenToChuc);
                handling.SettingParam(PM32_2010_TT_BTNMT7Handling.TENTOCHUC, bchd.ToChuc.TenToChuc);
                if (bchd.ToChuc.GiayPhepKinhDoanh != null)
                {
                    handling.SettingParam(PM32_2010_TT_BTNMT7Handling.GIAYPHEPHOATDONGSO, bchd.ToChuc.GiayPhepKinhDoanh);
                    handling.SettingParam(PM32_2010_TT_BTNMT7Handling.GIAYPHEPHOATDONGCAPNGAY, "......");
                }
            }
            if (bchd.DoanhThu != null && bchd.DoanhThu.HasValue)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT7Handling.DOANHTHUNAM, bchd.DoanhThu.Value);
            }
            if (bchd.NopNganSach != null && bchd.NopNganSach.HasValue)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT7Handling.NOPNGANSACHNAM, bchd.NopNganSach.Value);
            }
            handling.SettingParam(PM32_2010_TT_BTNMT7Handling.CONGTRINHDODACBANDO, congTrinhs);

            handling.Generate(tmpPath, outPath);

            // Download
            // Open the file.
            Stream iStream = null;
            try
            {
                iStream = new FileStream(outPath, FileMode.Open, FileAccess.Read, FileShare.Read);
                // Total bytes to read:
                long dataToRead = iStream.Length;

                // Buffer to read 10K bytes in chunk:
                byte[] buffer = new Byte[10000];

                Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "PM32-2010-TT-BTNMT.docx");

                // Read the bytes.
                while (dataToRead > 0)
                {
                    // Verify that the client is connected.
                    if (Response.IsClientConnected)
                    {
                        // Read the data in buffer.
                        int length = iStream.Read(buffer, 0, 10000);

                        // Write the data to the current output stream.
                        Response.OutputStream.Write(buffer, 0, length);

                        // Flush the data to the HTML output.
                        Response.Flush();

                        buffer = new Byte[10000];
                        dataToRead = dataToRead - length;
                    }
                    else
                    {
                        //prevent infinite loop if user disconnects
                        dataToRead = -1;
                    }
                }
            }
            catch (Exception ex)
            {
                // Trap the error, if any.
                Response.Write("Error : " + ex.Message);
            }
            finally
            {
                Response.Close();
                if (iStream != null)
                {
                    //Close the file.
                    iStream.Close();
                }
                if (System.IO.File.Exists(outPath))
                {
                    System.IO.File.Delete(outPath);
                }
            }
            return RedirectToAction("ChiTiet", new { id = id });
        }

        public ActionResult DownloadBanDangKy(int id)
        {
            HoSoGiayPhep hs = _gphdRepository.GetHoSoGiayPhepByID(id);
            if (hs.MaThongTinChung == null || !hs.MaThongTinChung.HasValue)
            {
                return RedirectToAction("ChiTiet", new { id = id });
            }

            INangLucKeKhaiRespository nlkkRepo = new NangLucKeKhaiRespository();
            INhanLucRepository nlRepo = new NhanLucRespository();
            IThietBiRepository tbRepo = new ThietBiRespository();
            IHoatDongRepository hdRepo = new HoatDongRespository();

            String outputName = HttpContext.Session.SessionID + DateTime.Now.Ticks + ".docx";
            String tmpPath = Path.Combine(HostingEnvironment.MapPath("~/App_Data/Templates"), "PM32-2010-TT-BTNMT1.docx");
            String outPath = Path.Combine(HostingEnvironment.MapPath("~/App_Data/Download"), outputName);
            DocumentHandling.DocumentHandling handling = new PM32_2010_TT_BTNMT1Handling();

            ThongTinChung thongTinChung = hs.ThongTinChung;
            if (thongTinChung != null)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.TOCHUCCANHAN, thongTinChung.TenToChuc);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.GPDKKD, thongTinChung.GiayPhepKinhDoanh);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.HANGDOANHNGHIEP, thongTinChung.HangDoanhNghiep);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.VONPHAPDINH, thongTinChung.VonPhapDinh);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.VONLUUDONG, thongTinChung.VonLuuDong);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.SOTAIKHOAN, thongTinChung.SoTaiKhoan);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.SONHANVIEN, thongTinChung.TongSoCanBo);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.TRUSOCHINH, thongTinChung.TruSoChinh);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.DIENTHOAI, thongTinChung.DienThoai);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.FAX, thongTinChung.Fax);
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.EMAIL, thongTinChung.Email);
            }

            List<List<string>> nganhNghes = new List<List<string>>();
            List<NangLucKeKhai> nlkks = nlkkRepo.GetNangLucKeKhaiByTTC(thongTinChung.MaThongTinChung);
            for (int i = 0; i < nlkks.Count; i++)
            {
                List<string> nganhNghe = new List<string>();

                nganhNghe.Add((i + 1).ToString());
                nganhNghe.Add(nlkks[i].NganhNghe);
                nganhNghe.Add(nlkks[i].SoTrenDaiHoc.ToString());
                nganhNghe.Add(nlkks[i].SoTrungCap.ToString());
                nganhNghe.Add(nlkks[i].SoCongNhanKyThuat.ToString());
                nganhNghe.Add(nlkks[i].LoaiKhac.ToString());

                nganhNghes.Add(nganhNghe);
            }
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.LUCLUONGKYTHUATNGANHNGHE, nganhNghes);

            List<List<string>> nhanLucs = new List<List<string>>();
            List<NhanLuc> nls = nlRepo.GetNhanLucByTTC(thongTinChung.MaThongTinChung);
            for (int i = 0; i < nls.Count; i++)
            {
                List<string> nhanLuc = new List<string>();

                nhanLuc.Add((i + 1).ToString());
                nhanLuc.Add(nls[i].HoTen);
                nhanLuc.Add(nls[i].ChucVu);
                nhanLuc.Add(nls[i].TrinhDoHocVan);
                nhanLuc.Add(nls[i].ThamNien);

                nhanLucs.Add(nhanLuc);
            }
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.LUCLUONGKYTHUATNGUOICHIUTRACHNHIEM, nhanLucs);

            List<List<string>> thietBis = new List<List<string>>();
            List<ThietBi> tbs = tbRepo.GetThietBiByTTC(thongTinChung.MaThongTinChung);
            for (int i = 0; i < tbs.Count; i++)
            {
                List<string> thietBi = new List<string>();

                thietBi.Add((i + 1).ToString());
                thietBi.Add(tbs[i].TenThietBi_CongNghe);
                thietBi.Add(tbs[i].SoLuong.ToString());
                thietBi.Add(tbs[i].TinhTrang);
                thietBi.Add(tbs[i].GhiChu);

                thietBis.Add(thietBi);
            }
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.THIETBICONGNGHE, thietBis);

            List<List<string>> hoatDongs = new List<List<string>>();
            List<DangKyHoatDong> dkhds = hs.DangKyHoatDongs.Where(m => m.LanBoSung != null && m.LanBoSung.Value == 0).ToList();
            for (int i = 0; i < dkhds.Count; i++) {
                List<string> hoatDong = new List<string>();

                hoatDong.Add((i + 1).ToString());
                hoatDong.Add(dkhds[i].HoatDong.TenHoatDong);

                hoatDongs.Add(hoatDong);
            }
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.NOIDUNGHOATDONG, hoatDongs); // check
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.BANDANGKYSO, hs.MaHoSo); // check
            DateTime ngayHieuLuc = DateTime.Now;
            if (hs.NgayCapPhep != null && hs.NgayCapPhep.HasValue) {
                ngayHieuLuc = hs.NgayCapPhep.Value;
            }
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.NGAY, ngayHieuLuc.Day); // check
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.THANG, ngayHieuLuc.Month); // check
            handling.SettingParam(PM32_2010_TT_BTNMT1Handling.NAM, ngayHieuLuc.Year); // check
            DangKyHoatDong boSung1 = hs.DangKyHoatDongs.SingleOrDefault(m => m.LanBoSung != null && m.LanBoSung.Value == 1);
            if (boSung1 != null)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.BOSUNG1, boSung1.HoatDong.TenHoatDong);
            }
            DangKyHoatDong boSung2 = hs.DangKyHoatDongs.SingleOrDefault(m => m.LanBoSung != null && m.LanBoSung.Value == 2);
            if (boSung2 != null)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.BOSUNG2, boSung2.HoatDong.TenHoatDong);
            }
            DangKyHoatDong boSung3 = hs.DangKyHoatDongs.SingleOrDefault(m => m.LanBoSung != null && m.LanBoSung.Value == 3);
            if (boSung2 != null)
            {
                handling.SettingParam(PM32_2010_TT_BTNMT1Handling.BOSUNG3, boSung3.HoatDong.TenHoatDong);
            }

            handling.Generate(tmpPath, outPath);

            // Download
            // Open the file.
            Stream iStream = null;
            try
            {
                iStream = new FileStream(outPath, FileMode.Open, FileAccess.Read, FileShare.Read);
                // Total bytes to read:
                long dataToRead = iStream.Length;

                // Buffer to read 10K bytes in chunk:
                byte[] buffer = new Byte[10000];

                Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "PM32-2010-TT-BTNMT.docx");

                // Read the bytes.
                while (dataToRead > 0)
                {
                    // Verify that the client is connected.
                    if (Response.IsClientConnected)
                    {
                        // Read the data in buffer.
                        int length = iStream.Read(buffer, 0, 10000);

                        // Write the data to the current output stream.
                        Response.OutputStream.Write(buffer, 0, length);

                        // Flush the data to the HTML output.
                        Response.Flush();

                        buffer = new Byte[10000];
                        dataToRead = dataToRead - length;
                    }
                    else
                    {
                        //prevent infinite loop if user disconnects
                        dataToRead = -1;
                    }
                }
            }
            catch (Exception ex)
            {
                // Trap the error, if any.
                Response.Write("Error : " + ex.Message);
            }
            finally
            {
                Response.Close();
                if (iStream != null)
                {
                    //Close the file.
                    iStream.Close();
                }
                if (System.IO.File.Exists(outPath))
                {
                    System.IO.File.Delete(outPath);
                }
            }
            return RedirectToAction("ChiTiet", new { id = id });
        }
    }
}
