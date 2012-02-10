using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class TinhTrangTaiKhoanRespository  : ITinhTrangTaiKhoanRepository
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

        //public void Add(LoaiHinhToChuc LoaiHinhToChuc)
        //{
        //    db.LoaiHinhToChucs.InsertOnSubmit(LoaiHinhToChuc);
        //}

        //public void Delete(LoaiHinhToChuc LoaiHinhToChuc)
        //{
        //     db.LoaiHinhToChucs.DeleteOnSubmit(LoaiHinhToChuc);
        //}

        //public void Save()
        //{
        //    db.SubmitChanges();
        //}
    }
}
