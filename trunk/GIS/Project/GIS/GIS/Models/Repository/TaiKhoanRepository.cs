using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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

        public void Add(TaiKhoan TaiKhoan)
        {
            db.TaiKhoans.InsertOnSubmit(TaiKhoan);
        }

        public void Delete(TaiKhoan TaiKhoan)
        {
            db.TaiKhoans.DeleteOnSubmit(TaiKhoan);
        }

        public void Save()
        {
            db.SubmitChanges();
        }

        public TaiKhoan getLoaiHinh(TaiKhoan TaiKhoan)
        {
            return db.TaiKhoans.SingleOrDefault(d => d.MaTaiKhoan == TaiKhoan.MaTaiKhoan);
        }
    }
}
