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

        public ToChuc GetToChucByTaiKhoan(int tkId)
        {
            return db.ToChucs.SingleOrDefault(d => d.MaTaiKhoan == tkId);
        }

        public void Add(ToChuc tochuc)
        {
            db.ToChucs.InsertOnSubmit(tochuc);
            db.SubmitChanges();
        }

        public void Delete(ToChuc tochuc)
        {
            db.ToChucs.DeleteOnSubmit(tochuc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
       
    }
}
