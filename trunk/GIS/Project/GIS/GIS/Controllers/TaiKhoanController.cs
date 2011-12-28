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

namespace GIS.Controllers
{

    [HandleError]
    public class TaiKhoanController : BaseController
    {
        public ITaiKhoanRepository _TaiKhoanRepository { get; set; }
        public IFormsAuthenticationService _FormsService { get; set; }


        public TaiKhoanController()
            : this(new TaiKhoanRepository(), new FormsAuthenticationService())
        {
        }

        public TaiKhoanController(ITaiKhoanRepository taikhoanRepository, IFormsAuthenticationService formService)
        {
            _TaiKhoanRepository = taikhoanRepository;
            _FormsService = formService;
        }

        public ActionResult Index()
        {
            return RedirectToAction("Dangky");
        }

        // 1. Lan dau vao dangky
        [HttpGet]
        public ActionResult Dangky()
        {
            if (Session[Sessions.AccountID.ToString()] != null)
            {
                return View("DangNhaped");
            }
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
                    var tk = new TaiKhoan
                    {
                        TenTaiKhoan = model.TenTaiKhoan,
                        MatKhau = MD5Helper.GetHash(model.MatKhau),
                        Email = model.Email,
                        HoTen = model.HoTen,
                        DiaChi = model.DiaChi,
                        CoQuan = model.Coquan,
                        CMND = model.CMND,
                        TinhTrang = 1
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

        public ActionResult Dangnhap()
        {
            // Form login
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

    }
}
