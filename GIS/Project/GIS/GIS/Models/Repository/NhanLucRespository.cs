using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models.Repository
{
    public class NhanLucRespository :INhanLucRepository
    {
        DDBDDataContext db = new DDBDDataContext();
        public IQueryable<NhanLuc> GetNhanLucs()
        {
            return db.NhanLucs.AsQueryable();
        }

        public IPagedList<NhanLuc> GetNhanLucByTTCID(int ttcid, int pageNo)
        {
            int soRecord = 5;
            var nhanlucList = (from nn in db.NhanLucs
                               where nn.MaThongTinChung == ttcid
                               select nn).ToPagedList(pageNo, soRecord);
            return nhanlucList;
        }

        public List<NhanLuc> GetNhanLucByTTC(int ttcid)
        {
            var nhanlucList = (from nn in db.NhanLucs
                               where nn.MaThongTinChung == ttcid
                               select nn).ToList();
            return nhanlucList;
        }
        public List<NhanLuc> GetNhanLucByTCID(int tcid)
        {
            return  (from nn in db.NhanLucs
                     where nn.MaToChuc == tcid
                     select nn).ToList();
        }

        public void Add(NhanLuc nhanluc)
        {
            db.NhanLucs.InsertOnSubmit(nhanluc);
            db.SubmitChanges();
        }

        public void Delete(NhanLuc nhanluc)
        {
            db.NhanLucs.DeleteOnSubmit(nhanluc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
