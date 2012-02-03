using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models.Repository
{
    public class ThietBiRespository: IThietBiRepository
    {

        DDBDDataContext db = new DDBDDataContext();
        public IQueryable<ThietBi> GetThietBis()
        {
            return db.ThietBis.AsQueryable();
        }
        public IPagedList<ThietBi> GetThietBiByTTCID(int ttcid, int pageNo)
        {
            int soRecord = 5;
            var nanglucList = (from nn in db.ThietBis
                               where nn.MaThongTinChung == ttcid
                               select nn).ToPagedList(pageNo, soRecord);
            return nanglucList;
        }
        public List<ThietBi> GetThietBiByTTC(int ttcid)
        {
            var nanglucList = (from nn in db.ThietBis
                               where nn.MaThongTinChung == ttcid
                               select nn).ToList();
            return nanglucList;
        }
        public List<ThietBi> GetThietBiByTCID(int tcid)
        {
            var list =(from nn in db.ThietBis
                               where nn.MaToChuc == tcid
                               select nn).ToList();
            return list;
        }

        public void Add(ThietBi kknangluc)
        {
            db.ThietBis.InsertOnSubmit(kknangluc);
            db.SubmitChanges();
        }

        public void Delete(ThietBi kknangluc)
        {
            db.ThietBis.DeleteOnSubmit(kknangluc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }

    }
}
