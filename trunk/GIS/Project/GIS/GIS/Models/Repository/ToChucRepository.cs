using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class ToChucRepository : IToChucRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<ToChuc> GetToChucs()
        {
            return db.ToChucs.AsQueryable();
        }

        public ToChuc GetToChucByID(int id)
        {
            return db.ToChucs.SingleOrDefault(d => d.MaToChuc == id);
        }

        public void Add(ToChuc tochuc)
        {
            db.ToChucs.InsertOnSubmit(tochuc);
        }

        public void Delete(ToChuc tochuc)
        {
            db.ThietBis.DeleteAllOnSubmit(tochuc.ThietBis);
            db.GiayPhepHoatDongs.DeleteAllOnSubmit(tochuc.GiayPhepHoatDongs);
            db.BaoCaoHoatDongs.DeleteAllOnSubmit(tochuc.BaoCaoHoatDongs);
            db.NhanLucs.DeleteAllOnSubmit(tochuc.NhanLucs);
            db.ToChucs.DeleteOnSubmit(tochuc);
        }

        public void Save()
        {
            db.SubmitChanges();
        }

        public LoaiHinhToChuc getLoaiHinh(ToChuc tochuc)
        {
            return db.LoaiHinhToChucs.SingleOrDefault(d => d.MaLoaiHinhToChuc == tochuc.MaLoaiHinhToChuc);
        }
    }
}
