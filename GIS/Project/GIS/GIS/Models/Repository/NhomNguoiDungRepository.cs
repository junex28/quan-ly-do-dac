using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class NhomNguoiDungRepository : INhomNguoiDungRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<NhomNguoiDung> GetNhomNguoiDungs()
        {
            return db.NhomNguoiDungs.AsQueryable();
        }

        public NhomNguoiDung GetNhomNguoiDungByID(int id)
        {
            return db.NhomNguoiDungs.SingleOrDefault(d => d.MaNhom == id);
        }

        public void Add(NhomNguoiDung NhomNguoiDung)
        {
            db.NhomNguoiDungs.InsertOnSubmit(NhomNguoiDung);
        }

        public void Delete(NhomNguoiDung NhomNguoiDung)
        {
             db.NhomNguoiDungs.DeleteOnSubmit(NhomNguoiDung);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
