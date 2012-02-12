using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class MocTrongLucRespository : IMocTrongLuc
    {
        QLDDBDDataContext db = new QLDDBDDataContext();

        public IQueryable<MocTrongLuc> GetMocTrongLucs()
        {
            return db.MocTrongLucs.AsQueryable();
        }

        public MocTrongLuc GetMocTrongLucByID(int id)
        {
            return db.MocTrongLucs.SingleOrDefault(d => d.OBJECTID == id);
        }

        public IQueryable<MocTrongLuc> GetMocTLBySearch(string search)
        {
            return (from m in db.MocTrongLucs
                        where m.SoHieu.ToUpper().Contains(search.ToUpper())
                        select m);
        }

        public void Update(MocTrongLuc mocTrongLuc)
        {
            MocTrongLuc moc = this.GetMocTrongLucByID(mocTrongLuc.OBJECTID);
            moc.TinhTrang = mocTrongLuc.TinhTrang;
            db.SubmitChanges();
        }

        public void Delete(MocTrongLuc mocTrongLuc)
        {
            db.MocTrongLucs.DeleteOnSubmit(mocTrongLuc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
