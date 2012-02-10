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
    public class QLTaiKhoanController : Controller
    {
        private ITaiKhoanRepository _taikhoanRepository;
        private ITinhTrangTaiKhoanRepository _tttkRespository;
        private INhomNguoiDungRepository _nhomnguoidungRespository;

        public QLTaiKhoanController()
            : this(new TaiKhoanRepository(), new TinhTrangTaiKhoanRepository(), new NhomNguoiDungRepository())
        {
        }

        public QLTaiKhoanController(ITaiKhoanRepository taikhoanRepository, ITinhTrangTaiKhoanRepository tttkRespository,
                                    INhomNguoiDungRepository nhomnguoidungRespository)
        {
            this._taikhoanRepository = taikhoanRepository;
           this._nhomnguoidungRespository = nhomnguoidungRespository;
            this._tttkRespository = tttkRespository;
        }

        [Authorize]
        [RoleFilter(Roles = "4")]
        public ActionResult Index([DefaultValue(1)] int page)
        {
            ViewData["page"] = page;
            return View();
        }

        public ActionResult ListData(string sidx, string search, string sord, int page, int rows)
        {
            var listTaiKhoans = _taikhoanRepository.GetTaiKhoanBySearch(search);
            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = listTaiKhoans.Count();
            var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

            // This is possible because I'm using the LINQ Dynamic Query Library
            var models = listTaiKhoans
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
                        id = u.MaTaiKhoan,
                        cell = new string[] {
                           u.MaTaiKhoan.ToString(),
                           u.TenTaiKhoan,
                           u.HoTen,  
                           u.CoQuan,
                           u.DiaChi,
                           u.Email
                        }
                    })
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        [Authorize]
        [RoleFilter(Roles="4")]
        public ActionResult ChiTiet(int? id)
        {
            // Authenticated
            TaiKhoan model = new TaiKhoan();
            TaiKhoan tk = new TaiKhoan();
            tk = (id == null ? null : _taikhoanRepository.GetTaiKhoanByID(id));
            try
            {
                if (tk != null)
                {
                    model = tk;
                    return View(model);
                }
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when display user" }, HttpContext.Response);
            }
            return RedirectToAction("Index","QLTaiKhoan");
        }

        [HttpGet]
        [Authorize]
        [RoleFilter(Roles = "4")]
        public ActionResult CapNhat(int? id)
        {
            TaiKhoan tk = new TaiKhoan();
            if (id != null)
            {
                 tk = _taikhoanRepository.GetTaiKhoanByID(id);
            }
            TaiKhoanEditViewModel model = new TaiKhoanEditViewModel
            {
                MaTaiKhoan = tk.MaTaiKhoan,
                HoTen = tk.HoTen,
                TenTaiKhoan = tk.TenTaiKhoan,
                Email = tk.Email,
                DiaChi = tk.DiaChi,
                CMND = tk.CMND,
                CoQuan = tk.CoQuan,
                MaNhom = (int)tk.NhomNguoiDung,
                MaTinhTrang = (int)tk.TinhTrang,
            
                //MatKhau = MD5Helper.Equals(
                tinhtrangTaiKhoan = _tttkRespository.GetTinhTrangTaiKhoans().ToList(),
                nhomNguoiDung = _nhomnguoidungRespository.GetNhomNguoiDungs().ToList()
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult CapNhat(int id, TaiKhoanEditViewModel model)
        {
            try
            {
                TaiKhoan tk = new TaiKhoan();
                tk = _taikhoanRepository.GetTaiKhoanByID(id);
                tk.TenTaiKhoan = model.TenTaiKhoan;
                tk.HoTen = model.HoTen;
                tk.CMND = model.CMND;
                tk.DiaChi = model.DiaChi;
                tk.Email = model.Email;
                tk.CoQuan = model.CoQuan;
                tk.TinhTrang = model.MaTinhTrang;
                tk.NhomNguoiDung = model.MaNhom;
                _taikhoanRepository.Save();
                return RedirectToAction("thongbao", "qltaikhoan", new { iMsg = 1, id= id });
            }
            catch (Exception ex)
            {
                return RedirectToAction("thongbao", "qltaikhoan", new { iMsg = 2 , id = id});
            }
        }

        public ActionResult ThongBao(int iMsg, int id)
        {
            var msg = iMsg;
            ViewData["id"]= id;
            return View(msg);
        }
    }
}
