using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ITinhTrangTaiKhoanRepository
    {
        IQueryable<TinhTrangTaiKhoan> GetTinhTrangTaiKhoans();
        TinhTrangTaiKhoan GetTinhTrangTaiKhoanByID(int id);

        //void Add(TinhTrangTaiKhoan TinhTrangTaiKhoan);
        //void Delete(TinhTrangTaiKhoan TinhTrangTaiKhoan);
        //void Save();
    }
}
