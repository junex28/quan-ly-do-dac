using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

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

        //public void Add(TaiKhoan TaiKhoan)
        //{
        //    db.TaiKhoans.InsertOnSubmit(TaiKhoan);
        //}

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
            if (tk.TenTaiKhoan == null || tk.TenTaiKhoan.Length  == 0) {
                return MembershipCreateStatus.InvalidUserName;
            }
 
            if(tk.MatKhau ==  null || tk.MatKhau.Length == 0)  {
                return MembershipCreateStatus.InvalidPassword;
            }

            if (tk.Email == null || tk.Email.Length == 0) {
                return MembershipCreateStatus.InvalidEmail;
            }

            int countUser = (from a in db.TaiKhoans
                       where a.TenTaiKhoan == tk.TenTaiKhoan
                            select a).Count();
            if (countUser > 0) {
                return MembershipCreateStatus.DuplicateUserName;
            }

            int countEmail = (from a in db.TaiKhoans
                              where a.Email == tk.Email
                              select a).Count();
            if (countEmail > 0) {
                return MembershipCreateStatus.DuplicateEmail;
            }

            try
            {
                db.TaiKhoans.InsertOnSubmit(tk);
                db.SubmitChanges();
                return MembershipCreateStatus.Success;
            }
            catch (Exception) {
                return MembershipCreateStatus.ProviderError;
            }

        }
    }
}
