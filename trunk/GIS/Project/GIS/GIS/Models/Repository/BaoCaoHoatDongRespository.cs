using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;
namespace GIS.Models.Repository
{
    public class BaoCaoHoatDongRespository : IBaoCaoHoatDongRepository
    {
        DDBDDataContext db = new DDBDDataContext();
        public IQueryable<BaoCaoHoatDong> GetBaoCaoHoatDongs()
        {
            return db.BaoCaoHoatDongs.AsQueryable();
        }
        public IPagedList<BaoCaoHoatDong> GetBaoCaoHoatDongByTCID(int tcid, int pageNo)
        {
            int soRecord = 5;
            var baocaoList = (from nn in db.BaoCaoHoatDongs
                               where nn.MaToChuc == tcid
                               select nn).ToPagedList(pageNo, soRecord);
            return baocaoList;
        }
        public BaoCaoHoatDong GetBaoCaoHoatDongByTC(int tcid)
        {
            var list = (from nn in db.BaoCaoHoatDongs
                        where nn.MaToChuc == tcid
                        select nn).ToList();
            BaoCaoHoatDong baocao = new BaoCaoHoatDong();
            if (list != null)
            {
                baocao = list[0];
            }
            return baocao;
        }

        public void Add(BaoCaoHoatDong baocao)
        {
            db.BaoCaoHoatDongs.InsertOnSubmit(baocao);
            db.SubmitChanges();
        }
        public void Update(BaoCaoHoatDong BaoCaoHoatDong)
        {
            BaoCaoHoatDong temp = new BaoCaoHoatDong();
            temp.MaToChuc = BaoCaoHoatDong.MaToChuc;
            temp.MaThongTinChung = BaoCaoHoatDong.MaThongTinChung;
            temp.TuNam = BaoCaoHoatDong.TuNam;
            temp.DenNam = BaoCaoHoatDong.DenNam;
            temp.DoanhThu = BaoCaoHoatDong.DoanhThu;
            temp.NopNganSach = BaoCaoHoatDong.NopNganSach;
            db.SubmitChanges();
        }

        public void Delete(BaoCaoHoatDong baocao)
        {
            db.BaoCaoHoatDongs.DeleteOnSubmit(baocao);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }

    }
}
