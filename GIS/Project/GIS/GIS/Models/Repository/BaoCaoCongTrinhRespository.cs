using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;
namespace GIS.Models.Repository
{
    public class BaoCaoCongTrinhRespository : IBaoCaoCongTrinhRespository
    {
        DDBDDataContext db = new DDBDDataContext();
        public IQueryable<BaoCaoCongTrinh> GetBaoCaoCongTrinhs()
        {
            return db.BaoCaoCongTrinhs.AsQueryable();
        }
        public IPagedList<BaoCaoCongTrinh> GetBCCTByBCID(int bcid, int pageNo)
        {
            int soRecord = 5;
            var baocaoList = (from nn in db.BaoCaoCongTrinhs
                              where nn.MaBaoCao == bcid
                               select nn).ToPagedList(pageNo, soRecord);
            return baocaoList;
        }
        public List<BaoCaoCongTrinh> GetBCCTByBCHD(int bcid)
        {
            var list = (from nn in db.BaoCaoCongTrinhs
                        where nn.MaBaoCao == bcid
                        select nn).ToList();
            return list;
        }

        public void Add(BaoCaoCongTrinh baocao)
        {
            db.BaoCaoCongTrinhs.InsertOnSubmit(baocao);
            db.SubmitChanges();
        }

        public void Delete(BaoCaoCongTrinh baocao)
        {
            db.BaoCaoCongTrinhs.DeleteOnSubmit(baocao);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }

    }
}
