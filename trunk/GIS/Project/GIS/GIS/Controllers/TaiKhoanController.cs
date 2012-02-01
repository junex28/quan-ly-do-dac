using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using GIS.Models;
using GIS.ViewModels;
using GIS.Helpers;
using Microsoft.Web.Mvc;
using System.Linq.Dynamic;
using System.ComponentModel;

namespace GIS.Controllers
{

    [HandleError]
    public class TaiKhoanController : BaseController
    {
        public ITaiKhoanRepository _TaiKhoanRepository { get; set; }
        public IFormsAuthenticationService _FormsService { get; set; }
        public IToChucRepository _ToChucRepository { get; set; }

        public TaiKhoanController()
            : this(new TaiKhoanRepository(), new FormsAuthenticationService(), new ToChucRepository())
        {
        }

        public TaiKhoanController(ITaiKhoanRepository taikhoanRepository, IFormsAuthenticationService formService, IToChucRepository tochucRepository)
        {
            _TaiKhoanRepository = taikhoanRepository;
            _FormsService = formService;
            _ToChucRepository = tochucRepository;
        }

        public ActionResult Index([DefaultValue(1)] int page)
        {
            ViewData["page"] = page;
            return View();
        }
        
        // 1. Lan dau vao dangky
        [HttpGet]
        public ActionResult Dangky()
        {
            return View();
        }

        // 2. Nhan thong tin tra ve va xu ly
        [HttpPost]
        public ActionResult Dangky(RegisterViewModel model)
        {
            var myCaptcha = Request.Form["myCaptcha"];
            if (CaptchaHelper.VerifyAndExpireSolution(HttpContext, myCaptcha, model.Captcha))
            {
                // In a real app, actually register the user now
                if (ModelState.IsValid)
                {
                    if (_TaiKhoanRepository.IsExistUserName(model.TenTaiKhoan))
                    {
                        ModelState.AddModelError("", "Tài khoản đã tồn tại");
                        return View(model);
                    }

                    var tk = new TaiKhoan
                    {
                        TenTaiKhoan = model.TenTaiKhoan,
                        MatKhau = MD5Helper.GetHash(model.MatKhau),
                        Email = model.Email,
                        HoTen = model.HoTen,
                        DiaChi = model.DiaChi,
                        CoQuan = model.Coquan,
                        CMND = model.CMND,
                        TinhTrang = 1,
                        NhomNguoiDung = 1
                    };

                    var createStatus = _TaiKhoanRepository.CreateUser(tk);

                    if (createStatus == MembershipCreateStatus.Success) //success 
                    {
                        // Sign in 
                        return RedirectToAction("Index", "TrangChu");
                    }
                    else
                    {
                        ModelState.AddModelError("", AccountValidation.ErrorCodeToString(createStatus));
                    }
                }
            }
            else
            {
                // Redisplay the view with an error message
                ModelState.AddModelError("", "Captcha nhập sai - Xin vui lòng nhập lại");
            }


            return View(model);

        }
        


        // **************************************
        // URL: /Taikhoan/Dangxuat
        // **************************************

        // 3. Dang xuat
        public ActionResult DangXuat()
        {
            _FormsService.SignOut();
            Session[Sessions.AccountID.ToString()] = null;
            return RedirectToAction("Index", "TrangChu");
        }

        // **************************************
        // URL: /Account/LogOn
        // **************************************
        [HttpGet]
        public ActionResult Dangnhap()
        {
            // Form login
            if (Request.IsAuthenticated) {
                return RedirectToAction("Index","TrangChu");
            }

            return View();
        }

        [HttpPost]
        public ActionResult DangNhap(LogOnViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid) {
                return View(model);
            }

            TaiKhoan user = _TaiKhoanRepository.ValidateUser(model.TenTaiKhoan, MD5Helper.GetHash(model.MatKhau));
            if (null != user) {
                if (user.TinhTrang == 2)
                {
                    _FormsService.SignIn(user.MaTaiKhoan.ToString(), model.GhiNho);
                    Session[Sessions.AccountID.ToString()] = user.MaTaiKhoan;
                    Session[Sessions.UserName.ToString()] = user.TenTaiKhoan;
                    Session[Sessions.RoleID.ToString()] = user.NhomNguoiDung1.TenNhom;
                     if (returnUrl != null)
                     {
                         return Redirect(returnUrl);
                     }
                     else
                     {
                         return RedirectToAction("Index", "TrangChu");
                     }
                }
                else {
                    ModelState.AddModelError("", "Tài khoản đăng nhập chưa được kích hoạt.");
                }
            }
            ModelState.AddModelError("", "Tài khoản đăng nhập không hợp lệ");
            return View(model);
    
        }

        // Hien thi thong tin chi tiet mot tai khoan
        // taikhoan/chitiet
        // taikhoan/chitiet/id
        [HttpGet]
        public ActionResult ChiTiet(int? id) {
            // Authenticated
                try
                {
                    // Neu la chu tai khoan thi hien thi edit tai khoan                    
                     if (Request.IsAuthenticated) {
                         //TaiKhoan user  = this.CurrentUser;
                         TaiKhoan user = _TaiKhoanRepository.GetTaiKhoanByID(id.GetValueOrDefault(this.CurrentUser.MaTaiKhoan));
                         RegisterViewModel Model = new RegisterViewModel();
                         
                         if (null!=user) {
                             Model.MaTaiKhoan = user.MaTaiKhoan;
                             Model.TenTaiKhoan = user.TenTaiKhoan;
                             Model.HoTen = user.HoTen;
                             Model.DiaChi = user.DiaChi;
                             Model.Email = user.Email;
                             Model.CMND = user.CMND;
                             Model.Coquan = user.CoQuan;
                             Model.MatKhau = user.MatKhau;
                         }

                         return View(Model);
                        }
                }
                catch (Exception) { 
                    MessageHelper.CreateMessage(MessageType.Error, "",new List<string>{"error when display user"}, HttpContext.Response);
                }
            return RedirectToLogin();
        }

        [HttpGet]
        [Authorize]
        public ActionResult CapNhat(int id) {
            try
            {
                // Neu la chu tai khoan hoac admin thi hien thi edit tai khoan                    
                    //TaiKhoan user  = this.CurrentUser;
                    TaiKhoan user = _TaiKhoanRepository.GetTaiKhoanByID(id);
                    TaiKhoan editor = this.CurrentUser;
                    if (editor.MaTaiKhoan == user.MaTaiKhoan || editor.NhomNguoiDung1.TenNhom.Equals("SuperAdmin"))
                    {
                        RegisterViewModel Model = new RegisterViewModel();

                        if (null != user)
                        {
                            Model.MaTaiKhoan = user.MaTaiKhoan;
                            Model.TenTaiKhoan = user.TenTaiKhoan;
                            Model.HoTen = user.HoTen;
                            Model.DiaChi = user.DiaChi;
                            Model.Email = user.Email;
                            Model.CMND = user.CMND;
                            Model.Coquan = user.CoQuan;
                            Model.MatKhau = user.MatKhau;
                            Model.NhapLaiMatKhau = user.MatKhau;
                        }

                        return View(Model);
                    }
                    else {
                        return View("NotAllowed"); 
                    }

                    // return 
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when update user" }, HttpContext.Response);
                return RedirectToAction("Index","TrangChu");
            }
        }

        [Authorize]       
        [HttpPost]
        public ActionResult CapNhat(RegisterViewModel model, int id)
        {
            try
            {
                // Neu la chu tai khoan hoac admin thi hien thi edit tai khoan                    
                //TaiKhoan user  = this.CurrentUser;
                           var myCaptcha = Request.Form["myCaptcha"];
                           if (CaptchaHelper.VerifyAndExpireSolution(HttpContext, myCaptcha, model.Captcha))
                           {

                               if (ModelState.IsValid)
                               {
                                   TaiKhoan user = _TaiKhoanRepository.GetTaiKhoanByID(id);
                                   TaiKhoan editor = this.CurrentUser;
                                   if (editor.MaTaiKhoan == user.MaTaiKhoan || editor.NhomNguoiDung1.TenNhom.Equals("SuperAdmin"))
                                   {
                                       user.HoTen = model.HoTen;
                                       user.CoQuan = model.Coquan;
                                       user.CMND = model.CMND;
                                       user.DiaChi = model.DiaChi;
                                       user.Email = model.Email;

                                       _TaiKhoanRepository.Save();
                                       return RedirectToAction("ChiTiet", "TaiKhoan", new { id = id});
                                   }
                                   else
                                   {
                                       return View("NotAllowed");
                                   }
                               }
                           }
                return View(model);
                // return 
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when update user" }, HttpContext.Response);
            }
            return RedirectToLogin();
        }


        public ActionResult ListData(string sidx, string sord, int page, int rows)
        {
            var listTaiKhoans = _TaiKhoanRepository.GetTaiKhoans();
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
                           u.NhomNguoiDung1.TenNhom,
                           u.HoTen,
                           u.Email,
                           u.TinhTrangTaiKhoan.DienGiai                           
                        }
                        })
                };

                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }

        }
    }

