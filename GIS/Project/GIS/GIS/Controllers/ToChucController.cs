using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;
using GIS.ViewModels;
using System.Linq.Dynamic;
using System.ComponentModel;
using GIS.Controllers;

namespace GIS.Controllers
{
    public class ToChucController : BaseController
    {
        private IToChucRepository _tochucRepository;
        private ILoaiHinhToChucRepository _loaihinhtochucRepository;
        private ITaiKhoanRepository _taikhoanRepository;
        private IFileStore _fileStore;

        public ToChucController()
            : this(new ToChucRepository(), new LoaiHinhToChucRepository(),
                   new TaiKhoanRepository(), new DiskFileStore("~/App_Data/Upload/HSToChuc"))
        {
        }

        public ToChucController(IToChucRepository tochucRepository,
                ILoaiHinhToChucRepository loaihinhtochucRepository,
                            ITaiKhoanRepository taikhoanRepository,
                            IFileStore fileStore)
        {
            this._tochucRepository = tochucRepository;
            this._loaihinhtochucRepository = loaihinhtochucRepository;
            this._taikhoanRepository = taikhoanRepository;
            this._fileStore = fileStore;
        }

        [Authorize]
        [RoleFilter(Roles = "4")]
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
                           u.NguoiDaiDien,                      
                           u.TruSoChinh,
                           u.DienThoai
                        }
                    })
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        //
        // GET: /tochuc/{id}/chitiet
        [Authorize]
        [RoleFilter(Roles = "2,4")]
        public ActionResult ChiTiet(int id)
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            if (tk.NhomNguoiDung != null && tk.NhomNguoiDung == 2)
            {
                return RedirectToAction("thongbao",new {iMsg = 1 });
            }

            ToChuc tochuc = _tochucRepository.GetToChucByID(id);

            if (tochuc == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            var modelview = new ToChucDetailViewModel { toChuc = tochuc };
            modelview.toChuc.VonLuuDong.GetValueOrDefault(0);
            modelview.toChuc.VonPhapDinh.GetValueOrDefault(0);
            modelview.toChuc.TongSoCanBo.GetValueOrDefault(0);

            return View(modelview);
        }


        //
        // GET: /tochuc/{id}/capnhat
        [HttpGet]
        [Authorize]
        [RoleFilter(Roles = "4")]
        public ActionResult CapNhat(int id)
        {
            var EditedToChuc = _tochucRepository.GetToChucByID(id);
            var LoaiHinhToChucList = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();

            var viewmodel = new ToChucDetailViewModel
            {
                toChuc = EditedToChuc,
                loaiHinh = LoaiHinhToChucList
            };
            viewmodel.toChuc.TongSoCanBo = EditedToChuc.TongSoCanBo.GetValueOrDefault(0);
            viewmodel.toChuc.VonLuuDong = EditedToChuc.VonLuuDong.GetValueOrDefault(0);
            viewmodel.toChuc.VonPhapDinh = EditedToChuc.VonPhapDinh.GetValueOrDefault(0);
            return View(viewmodel);
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CapNhat(ToChucDetailViewModel model, int id)
        {
            ToChuc tochuc = _tochucRepository.GetToChucByID(id);

            try
            {
                tochuc.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                tochuc.TruSoChinh = model.toChuc.TruSoChinh;
                tochuc.TongSoCanBo = model.toChuc.TongSoCanBo;
                tochuc.SoTaiKhoan = model.toChuc.SoTaiKhoan;
                tochuc.GiayPhepKinhDoanh = model.toChuc.GiayPhepKinhDoanh;
                tochuc.NguoiDaiDien = model.toChuc.NguoiDaiDien;
                tochuc.DienThoai = model.toChuc.DienThoai;
                tochuc.Email = model.toChuc.Email;
                tochuc.Fax = model.toChuc.Fax;
                tochuc.HangDoanhNghiep = model.toChuc.HangDoanhNghiep;
                tochuc.VonPhapDinh = model.toChuc.VonPhapDinh;
                tochuc.VonLuuDong = model.toChuc.VonLuuDong;
                _tochucRepository.Update(tochuc);
                return RedirectToAction("ChiTiet", new { id = tochuc.MaToChuc });
            }
            catch
            {
                MessageHelper.CreateMessage(MessageType.Error, "error", new List<string> {"Lỗi: cập nhật thông tin tổ chức không thành công, vui lòng kiểm tra lại thông tin"},HttpContext.Response);
                return View(model);
            }
        }


        // Users declare ToChuc's info
        // GET: /tochuc/taomoi

        [Authorize]
        [HttpGet]
        public ActionResult TaoMoi()
        {
            if (this.CurrentUser.ToChucs.Count == 0)
            {
                ToChucDetailViewModel model = new ToChucDetailViewModel();
                model.loaiHinh = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();
                return View(model);
            }
            return RedirectToAction("Index", "ToChuc");
        }

        //
        // POST: /Dinners/Create

        [AcceptVerbs(HttpVerbs.Post), Authorize]
        public ActionResult TaoMoi(ToChucDetailViewModel model)
        {
            try
            {
                if (this.CurrentUser.ToChucs.Count == 0)
                {
                    TaiKhoan tk = this.CurrentUser;
                    ToChuc tc = new ToChuc();
                    tc.TenToChuc = model.TenToChuc;
                    tc.DienThoai = model.DienThoai;
                    tc.Email = model.Email;
                    tc.Fax = model.Fax;
                    tc.GiayPhepKinhDoanh = model.GiayPhepKinhDoanh;
                    tc.MaLoaiHinhToChuc = model.MaLoaiHinhToChuc;
                    tc.NguoiDaiDien = model.NguoiDaiDien;
                    tc.SoTaiKhoan = model.SoTaiKhoan;
                    tc.TongSoCanBo = model.TongSoCanBo;
                    tc.MaTaiKhoan = tk.MaTaiKhoan;
                    tc.TruSoChinh = model.TruSoChinh;
                    tc.HangDoanhNghiep = model.HangDoanhNghiep;
                    tc.VonPhapDinh = model.VonPhapDinh;
                    tc.VonLuuDong = model.VonLuuDong;
                    _tochucRepository.Add(tc);
                }
                return RedirectToAction("Index", "TrangChu");
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when create new" }, HttpContext.Response);
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Xoa(int[] ids)
        {
            try
            {
                //List<String> listMsg = new List<string>();
                for (int i = 0; i < ids.Length; i++)
                {
                    ToChuc tochuc = _tochucRepository.GetToChucByID(ids[i]);
                    //String strName = tochuc.TenToChuc;
                    _tochucRepository.Delete(tochuc);
                    //listMsg.Add("đã xóa tổ chức " + strName);
                }
                _tochucRepository.Save();
                //MessageHelper.CreateMessage(MessageType.Highlight, "Title", listMsg, HttpContext.Response);
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when deleting" }, HttpContext.Response);
            }
            return View("Index");
        }

        public string Uploader()
        {
            return _fileStore.SaveUploadedFile(Request.Files[0]);
        }

        public ActionResult ThongBao(int iMsg)
        {
            var msg = iMsg;
            return View(msg);
        }

             

    }
}