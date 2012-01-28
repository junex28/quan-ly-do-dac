using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;


namespace GIS.Models.Repository
{
    public class NangLucKeKhaiRespository: INangLucKeKhaiRespository
    {
        DDBDDataContext db = new DDBDDataContext();
        //public IList<NangLucKeKhai> DSKKNangLuc { get; set; }
        public IQueryable<NangLucKeKhai> GetNangLucKeKhais()
        {
            return db.NangLucKeKhais.AsQueryable();
        }
        public IPagedList<NangLucKeKhai> GetNangLucKeKhaiByID(int tcid, int pageNo)
        {
            int soRecord =5;
            var nanglucList= (from nn in db.NangLucKeKhais
                    where nn.MaToChuc == tcid
                    select nn).ToPagedList(pageNo,soRecord);
            return nanglucList;
        }

       public List<NangLucKeKhai> GetNangLucByTCID(int tcId)
        {
            var nanglucList = (from nn in db.NangLucKeKhais
                               where nn.MaToChuc == tcId
                               select nn).ToList();
            return nanglucList;
        }

        public void Add(NangLucKeKhai kknangluc)
        {
            db.NangLucKeKhais.InsertOnSubmit(kknangluc);
            db.SubmitChanges();
        }

        public void Delete(NangLucKeKhai kknangluc)
        {
            db.NangLucKeKhais.DeleteOnSubmit(kknangluc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }

    }
}
