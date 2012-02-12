using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class MocToaDoRespository : IMocToaDo
    {
        QLDDBDDataContext db = new QLDDBDDataContext();

        public IQueryable<MocToaDo> GetMocToaDos()
        {
            return db.MocToaDos.AsQueryable();
        }

        public MocToaDo GetMocToaDoByID(int id)
        {
            return db.MocToaDos.SingleOrDefault(d => d.OBJECTID == id);
        }

        public IQueryable<MocToaDo> GetMocTDBySearch(string search)
        {
            return (from m in db.MocToaDos
                        where m.SoHieu.ToUpper().Contains(search.ToUpper())
                        select m);
        }

        public void Update(MocToaDo mocToaDo)
        {
            MocToaDo moc = this.GetMocToaDoByID(mocToaDo.OBJECTID);
            moc.TinhTrang = mocToaDo.TinhTrang;
            db.SubmitChanges();
        }
        public void Delete(MocToaDo mocToaDo)
        {
            db.MocToaDos.DeleteOnSubmit(mocToaDo);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
