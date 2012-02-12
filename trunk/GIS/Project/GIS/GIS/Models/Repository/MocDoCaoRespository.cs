using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class MocDoCaoRespository : IMocDoCao
    {
        QLDDBDDataContext db = new QLDDBDDataContext();

        public IQueryable<MocDoCao> GetMocDoCaos()
        {
            return db.MocDoCaos.AsQueryable(); 
        }

        public MocDoCao GetMocDoCaoByID(int id)
        {
            return db.MocDoCaos.SingleOrDefault(d => d.OBJECTID == id);
        }

        public IQueryable<MocDoCao> GetMocDCBySearch(string search)
        {
            return (from m in db.MocDoCaos
                        where m.SoHieu.ToUpper().Contains(search.ToUpper())
                        select m);
        }

        public void Update(MocDoCao mocDoCao)
        {
            MocDoCao moc = this.GetMocDoCaoByID(mocDoCao.OBJECTID);
            moc.TinhTrang = mocDoCao.TinhTrang;
            db.SubmitChanges();
        }

        public void Delete(MocDoCao mocDoCao)
        {
            db.MocDoCaos.DeleteOnSubmit(mocDoCao);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
