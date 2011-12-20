﻿using System;
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
    public class TaiKhoanController : Controller
    {
        public ITaiKhoanRepository _TaiKhoanRepository { get; set; }
        public IFormsAuthenticationService _FormsService { get; set; }
        

        public TaiKhoanController() : this(new TaiKhoanRepository(), new FormsAuthenticationService()) { 
        }
        
        public TaiKhoanController(ITaiKhoanRepository taikhoanRepository, IFormsAuthenticationService formService) {
            _TaiKhoanRepository = taikhoanRepository;
            _FormsService = formService;
        }

        public ActionResult Index() {
            return RedirectToAction("Dangky"); 
        }

        // 1. Lan dau vao dangky
        [HttpGet]
        public ActionResult Dangky()
        {
            if (!String.IsNullOrEmpty(Session[Sessions.AccountID.ToString()].ToString())) {
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
            int? accountID = null;
            int? roleID = null; 
            string username = String.Empty; 
            if (ModelState.IsValid) {
                if (_TaiKhoanRepository.ValidateUser(model.TenTaiKhoan, MD5Helper.GetHash(model.MatKhau),out accountID,out roleID,out username))
                {

                    _FormsService.SignIn(model.TenTaiKhoan, model.GhiNho);                    
                    Session[Sessions.AccountID.ToString()] = accountID;
                    Session[Sessions.RoleID.ToString()] = roleID;
                    Session[Sessions.UserName.ToString()] = username;
                    
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
                    ModelState.AddModelError("","Tài khoản đăng nhập không hợp lệ");
                }
                     
            }
            return View(model);
        }

    }
}
//public IFormsAuthenticationService FormsService { get; set; }
//public IMembershipService MembershipService { get; set; }

//protected override void Initialize(RequestContext requestContext)
//{
//    if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
//    if (MembershipService == null) { MembershipService = new AccountMembershipService(); }

//    base.Initialize(requestContext);
//}

//// **************************************
//// URL: /Account/LogOn
//// **************************************

//public ActionResult DangNhap()
//{
//    return View();
//}

//[HttpPost]
//public ActionResult DangNhap(LogOnModel model, string returnUrl)
//{
//    if (ModelState.IsValid)
//    {
//        if (MembershipService.ValidateUser(model.UserName, model.Password))
//        {
//            FormsService.SignIn(model.UserName, model.RememberMe);
//            if (!String.IsNullOrEmpty(returnUrl))
//            {
//                return Redirect(returnUrl);
//            }
//            else
//            {
//                return RedirectToAction("Index", "Home");
//            }
//        }
//        else
//        {
//            ModelState.AddModelError("", "The user name or password provided is incorrect.");
//        }
//    }

//    // If we got this far, something failed, redisplay form
//    return View(model);
//}



//// **************************************
//// URL: /Account/Register
//// **************************************
//public ActionResult DangKy()
//{
//    ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
//    return View();
//}

//[HttpPost]
//public ActionResult DangKy(RegisterModel model)
//{
//    if (ModelState.IsValid)
//    {
//        // Attempt to register the user
//        MembershipCreateStatus createStatus = MembershipService.CreateUser(model.UserName, model.Password, model.Email);

//        if (createStatus == MembershipCreateStatus.Success)
//        {
//            FormsService.SignIn(model.UserName, false /* createPersistentCookie */);
//            return RedirectToAction("Index", "Home");
//        }
//        else
//        {
//            ModelState.AddModelError("", AccountValidation.ErrorCodeToString(createStatus));
//        }
//    }

//    // If we got this far, something failed, redisplay form
//    ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
//    return View(model);
//}

//// **************************************
//// URL: /Account/ChangePassword
//// **************************************

//[Authorize]
//public ActionResult DoiMatKhau()
//{
//    ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
//    return View();
//}

//[Authorize]
//[HttpPost]
//public ActionResult DoiMatKhau(ChangePasswordModel model)
//{
//    if (ModelState.IsValid)
//    {
//        if (MembershipService.ChangePassword(User.Identity.Name, model.OldPassword, model.NewPassword))
//        {
//            return RedirectToAction("ChangePasswordSuccess");
//        }
//        else
//        {
//            ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
//        }
//    }

//    // If we got this far, something failed, redisplay form
//    ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
//    return View(model);
//}

//// **************************************
//// URL: /Account/ChangePasswordSuccess
//// **************************************

//public ActionResult DoiMatKhauThanhCong()
//{
//    return View();
//}