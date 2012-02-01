using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Mvc;
using System.Security.Principal;
using GIS.Helpers;
using GIS.Models;
using GIS.Controllers;


namespace GIS.Models
{
    public class TaiKhoanRepository:ITaiKhoanRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<TaiKhoan> GetTaiKhoans()
        {
            return db.TaiKhoans.AsQueryable();
        }

        public TaiKhoan GetTaiKhoanByID(int id)
        {
            return db.TaiKhoans.SingleOrDefault(d => d.MaTaiKhoan == id);
        }

        public void Delete(TaiKhoan TaiKhoan)
        {
            db.TaiKhoans.DeleteOnSubmit(TaiKhoan);
        }

        public void Save()
        {
            db.SubmitChanges();
        }

        public int Add(TaiKhoan tk)
        { 
           try
            {
                db.TaiKhoans.InsertOnSubmit(tk);               
                return 1;
            }
            catch (Exception){
                return -1; 
            }

        }

        public MembershipCreateStatus CreateUser(TaiKhoan tk)
        {
            if (tk.TenTaiKhoan == null || tk.TenTaiKhoan.Length == 0)
            {
                return MembershipCreateStatus.InvalidUserName;
            }

            if (tk.MatKhau == null || tk.MatKhau.Length == 0)
            {
                return MembershipCreateStatus.InvalidPassword;
            }

            if (tk.Email == null || tk.Email.Length == 0)
            {
                return MembershipCreateStatus.InvalidEmail;
            }

            int countUser = (from a in db.TaiKhoans
                             where a.TenTaiKhoan == tk.TenTaiKhoan
                             select a).Count();
            if (countUser > 0)
            {
                return MembershipCreateStatus.DuplicateUserName;
            }

            int countEmail = (from a in db.TaiKhoans
                              where a.Email == tk.Email
                              select a).Count();
            if (countEmail > 0)
            {
                return MembershipCreateStatus.DuplicateEmail;
            }

            try
            {
                db.TaiKhoans.InsertOnSubmit(tk);
                db.SubmitChanges();
                return MembershipCreateStatus.Success;
            }
            catch (Exception)
            {
                return MembershipCreateStatus.ProviderError;
            }

        }

        public TaiKhoan ValidateUser(String tentaikhoan, String matkhau) {
            TaiKhoan tk = null;
            try
            {
                if (tentaikhoan != null && !(tentaikhoan.Equals("")))
                {
                    if (matkhau != null && !(matkhau.Equals("")))
                    {
                        tk = (from p in db.TaiKhoans 
                              join c in db.NhomNguoiDungs on p.NhomNguoiDung equals c.MaNhom 
                              where p.TenTaiKhoan == tentaikhoan && p.MatKhau == matkhau
                              select p).SingleOrDefault();
                        if (null != tk)
                        {
                            return tk;
                        }
                    }

                }
                return tk;
            }
            catch (Exception){
                return tk;
            }
        }

        public TaiKhoan GetTaiKhoanByName(String tentaikhoan)
        {
            return db.TaiKhoans.SingleOrDefault(d => d.TenTaiKhoan == tentaikhoan);
        }

        public bool IsInRole(TaiKhoan tk, string role) {
            try
            {
                var rl = db.NhomNguoiDungs.Single(p => p.TenNhom == role);
                int i = rl.MaNhom;
                int c = (from a in db.TaiKhoans
                         where a.MaTaiKhoan == tk.MaTaiKhoan && a.NhomNguoiDung1.MaNhom >= i
                         select a.NhomNguoiDung1.TenNhom).Count();
                if (c>0)
                {
                    return true;
                }
            }
            catch { return false; }
            return false;
        }

        public bool IsExistUserName(string tentaikhoan) {
            try
            {
                int c = (from a in db.TaiKhoans 
                         where a.TenTaiKhoan == tentaikhoan
                             select a.MaTaiKhoan).Count();
                if (c != 0) return true;
                else return false;
            }
            catch { return true; }
        }
    }



    #region services
    public interface IFormsAuthenticationService
    {
        void SignIn(string userName, bool createPersistentCookie);
        void SignOut();
    }

    public class FormsAuthenticationService : IFormsAuthenticationService
    {
        public void SignIn(string userID, bool createPersistentCookie)
        {
            if (String.IsNullOrEmpty(userID)) throw new ArgumentException("Gia tri rong.", "Tên Tài Khoản");

            FormsAuthentication.SetAuthCookie(userID, createPersistentCookie);
        }

        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }

    public class EnhancedPrincipal : IPrincipal
    {
        private readonly IIdentity _identity;
        private readonly TaiKhoan _taikhoan;
        private readonly ITaiKhoanRepository _taikhoanRepository;
        public static readonly EnhancedPrincipal Anonymous = new AnonymousPrincipal();

        public EnhancedPrincipal(IIdentity identity, TaiKhoan userData)
        {
            this._identity = identity;
            this._taikhoan = userData;
            _taikhoanRepository = new TaiKhoanRepository();
        }

        public bool IsInRole(string role)
        {
            return _taikhoanRepository.IsInRole(_taikhoan, role);
        }

        public IIdentity Identity
        {
            get { return _identity; }
        }

        public TaiKhoan Data
        {
            get { return _taikhoan; }
        }

        private class AnonymousIdentity : IIdentity
        {
            public string Name
            {
                get { return "Anonymous"; }
            }

            public string AuthenticationType
            {
                get { return null; }
            }

            public bool IsAuthenticated
            {
                get { return false; }
            }
        }

        private class AnonymousPrincipal : EnhancedPrincipal
        {
            public AnonymousPrincipal()
                : base(new AnonymousIdentity(), new TaiKhoan
                {
                    MaTaiKhoan = 0,
                    TenTaiKhoan = "Anonymous"
                })
            {
            }
        }
    }

    public class RoleFilterAttribute : FilterAttribute, IAuthorizationFilter
    {
        public string Roles { get; set; }

        public void OnAuthorization(AuthorizationContext filterContext)
        {
            var controller = filterContext.Controller as BaseController;
            
            if (controller == null)
                return;
            foreach (string definedRole in this.Roles.Split(','))
            {
                if (definedRole.Equals(controller.CurrentUser.NhomNguoiDung.ToString()))
                    return;
            }

            filterContext.Result = controller.RedirectToLogin();
        }
    }


    #endregion
}
