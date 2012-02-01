using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace GIS.Models
{
    public interface ITaiKhoanRepository
    {
        IQueryable<TaiKhoan> GetTaiKhoans();
        TaiKhoan GetTaiKhoanByID(int id);
        TaiKhoan GetTaiKhoanByName(String tentaikhoan);

        int Add(TaiKhoan TaiKhoan);
        void Delete(TaiKhoan TaiKhoan);
        void Save();

        bool IsExistUserName(string tentaikhoan);
        MembershipCreateStatus CreateUser(TaiKhoan tk);
        TaiKhoan ValidateUser(String tentaikhoan, String matkhau);
        bool IsInRole(TaiKhoan taikhoan, string nhomquyen);
        //MembershipUser CreateUser(TaiKhoan tk);
        //MembershipUser GetUser(String TenTaiKhoan);
    }
}
