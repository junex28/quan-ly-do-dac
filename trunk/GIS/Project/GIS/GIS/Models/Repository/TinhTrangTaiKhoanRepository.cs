using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class TinhTrangTaiKhoanRepository : ITinhTrangTaiKhoanRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<TinhTrangTaiKhoan> GetTinhTrangTaiKhoans()
        {
            return db.TinhTrangTaiKhoans.AsQueryable();
        }

        public TinhTrangTaiKhoan GetTinhTrangTaiKhoanByID(int id)
        {
            return db.TinhTrangTaiKhoans.SingleOrDefault(d => d.MaTinhTrang == id);
        }

        public void Add(TinhTrangTaiKhoan TinhTrangTaiKhoan)
        {
            db.TinhTrangTaiKhoans.InsertOnSubmit(TinhTrangTaiKhoan);
        }

        public void Delete(TinhTrangTaiKhoan TinhTrangTaiKhoan)
        {
             db.TinhTrangTaiKhoans.DeleteOnSubmit(TinhTrangTaiKhoan);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
