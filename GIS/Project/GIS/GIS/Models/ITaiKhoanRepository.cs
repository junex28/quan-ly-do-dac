using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ITaiKhoanRepository
    {
        IQueryable<TaiKhoan> GetTaiKhoans();
        TaiKhoan GetTaiKhoanByID(int id);

        void Add(TaiKhoan TaiKhoan);
        void Delete(TaiKhoan TaiKhoan);
        void Save();
    }
}
