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

        //
        // GET: /tochuc/{id}/chitiet

        public ActionResult ChiTiet(int id)
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
        // GET: /tochuc/{id}/capnhat
        [HttpGet]
        public ActionResult CapNhat(int id)
        {
            var EditedToChuc = _tochucRepository.GetToChucByID(id);
            var LoaiHinhToChucList = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();

            var viewmodel = new ToChucDetailViewModel
            {
                toChuc = EditedToChuc,
                loaiHinh = LoaiHinhToChucList
            };

            var file = from f in System.IO.Directory.GetFiles(Server.MapPath("~/AppData/Upload/HSToChuc"), "1e29dab2-7f20-4a7a-a9b6-728bb934a649.rar", SearchOption.AllDirectories)
                       select System.IO.Path.GetFileName(f);
            ViewData["file"]= file;
            return View(viewmodel);
        }

        
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CapNhat(int id, FormCollection collection)
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
                _tochucRepository.Save();
                return RedirectToAction("Details", new { id = tochuc.MaToChuc });
            }
            catch
            {
                return View();
            }
        }


        // Users declare ToChuc's info
        // GET: /tochuc/taomoi

        [Authorize]
        [HttpGet]
        public ActionResult TaoMoi()
        {
            // Neu da co to chuc            
            if (this.CurrentUser.ToChucs.Count == 0 ) {
                ToChucDetailViewModel model = new ToChucDetailViewModel();
                model.loaiHinh = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();        
                return View(model);
            }
             return RedirectToAction("Index","ToChuc");
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
                    if (Request.Files["tepdinhkem"] != null) // If uploaded synchronously
                    {
                        var tep_guid = _fileStore.SaveUploadedFile(Request.Files["tepdinhkem"]);
                        var tep_filename = Request.Files["tepdinhkem"].FileName;
                        tc.TepDinhKem = tep_guid.ToString();                    
                    }
                    tc.TruSoChinh = model.TruSoChinh;
                    _tochucRepository.Add(tc);
                }
                return RedirectToAction("Index","TrangChu");
            }
            catch (Exception) {
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
                MessageHelper.CreateMessage(MessageType.Error, "",new List<string>{"error when deleting"}, HttpContext.Response);
            }
            return View("Index");
        }

        public string Uploader()
        {
            return _fileStore.SaveUploadedFile(Request.Files[0]);
        }

        public ActionResult Download(string fn)
        {

            string pfn = Server.MapPath("~/App_Data/Upload/HSToChuc/" + fn);
            pfn = pfn.Replace("//","/" );

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
    }
}