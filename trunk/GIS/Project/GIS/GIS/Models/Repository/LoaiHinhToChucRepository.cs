using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class LoaiHinhToChucRepository : ILoaiHinhToChucRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<LoaiHinhToChuc> GetLoaiHinhToChucs()
        {
            return db.LoaiHinhToChucs.AsQueryable();
        }

        public LoaiHinhToChuc GetLoaiHinhToChucByID(int id)
        {
            return db.LoaiHinhToChucs.SingleOrDefault(d => d.MaLoaiHinhToChuc == id);
        }

        public void Add(LoaiHinhToChuc LoaiHinhToChuc)
        {
            db.LoaiHinhToChucs.InsertOnSubmit(LoaiHinhToChuc);
        }

        public void Delete(LoaiHinhToChuc LoaiHinhToChuc)
        {
             db.LoaiHinhToChucs.DeleteOnSubmit(LoaiHinhToChuc);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
