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

        int Add(TaiKhoan TaiKhoan);
        void Delete(TaiKhoan TaiKhoan);
        void Save();

        MembershipCreateStatus CreateUser(TaiKhoan tk);
    }
}
