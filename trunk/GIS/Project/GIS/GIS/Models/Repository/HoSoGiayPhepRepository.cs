using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class HoSoGiayPhepRepository : IHoSoGiayPhepRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<HoSoGiayPhep> GetHoSoGiayPheps(string strSearch)
        {
            if (strSearch != null)
                return from gp in db.HoSoGiayPheps
                       where gp.ToChuc.TenToChuc.Contains(strSearch)
                       select gp;
            return db.HoSoGiayPheps.AsQueryable();
        }

        public IQueryable<HoSoGiayPhep> GetGPHDByTinhTrang(int Id, string strSearch)
        {
            if (strSearch != null)
                return from gp in db.HoSoGiayPheps
                       where gp.ToChuc.TenToChuc.Contains(strSearch) && gp.TinhTrang == Id
                       select gp;
            return from gp in db.HoSoGiayPheps
                   where gp.TinhTrang == Id
                   select gp; 
        }

        public IList<HoSoGiayPhep> GetHSGPByToChuc(int tcId)
        {
            var hs = (from g in db.HoSoGiayPheps
                     where g.MaToChuc == tcId && (g.TinhTrang == 5 || g.TinhTrang == 8 || g.TinhTrang ==11)
                     orderby g.MaHoSo descending
                      select g).ToList() ;
            return hs;
        }

        public HoSoGiayPhep GetHoSoGiayPhepByID(int id)
        {
            return db.HoSoGiayPheps.SingleOrDefault(d => d.MaHoSo == id);
        }

        public int Check(int tcId)
        {
            var m = (from hs in db.HoSoGiayPheps
                    where hs.MaToChuc == tcId
                    orderby hs.MaHoSo descending
                    select hs).ToList();
            if (m != null && m.Count != 0)
            {
                HoSoGiayPhep hs = m[0];
                if (hs.TinhTrang == 1)
                    return 1;
                else if (hs.TinhTrang == 2)
                    return 2;
                else if (hs.TinhTrang == 3)
                    return 3;
                else if (hs.TinhTrang == 4)
                    return 4;
                else if (hs.TinhTrang == 5)
                    return 5;
                else if (hs.TinhTrang == 6)
                    return 6;
                else if (hs.TinhTrang == 7)
                    return 7;
                else if (hs.TinhTrang == 8)
                    return 8;
                else if (hs.TinhTrang == 9)
                    return 9;
                else if (hs.TinhTrang == 10)
                    return 10;
                else if (hs.TinhTrang == 11)
                    return 11;
                else return 12;
            }
            return 0;
        }

        public void Add(HoSoGiayPhep HoSoGiayPhep)
        {
            db.HoSoGiayPheps.InsertOnSubmit(HoSoGiayPhep);
            db.SubmitChanges();
        }

        public void Delete(HoSoGiayPhep hoso)
        {
            //db.DangKyHoatDongs.DeleteAllOnSubmit(HoSoGiayPhep);
            //db.ThamDinhs.DeleteAllOnSubmit(HoSoGiayPhep.ThamDinhs);
            HoSoGiayPhep tmp = GetHoSoGiayPhepByID(hoso.MaHoSo);
            tmp.TinhTrang = 12;
            db.SubmitChanges();
        }

        public void Update(HoSoGiayPhep hoSoGiayPhep)
        {
            HoSoGiayPhep tmp = GetHoSoGiayPhepByID(hoSoGiayPhep.MaHoSo);
            tmp.NgayCapPhep = hoSoGiayPhep.NgayCapPhep;
            tmp.NgayHetHan = hoSoGiayPhep.NgayHetHan;
            tmp.NgayXinPhep = hoSoGiayPhep.NgayXinPhep;
            tmp.SoGiayPhep = hoSoGiayPhep.SoGiayPhep;
            tmp.TepDinhKem = hoSoGiayPhep.TepDinhKem;
            tmp.TinhTrang = hoSoGiayPhep.TinhTrang;
            tmp.LyDo = hoSoGiayPhep.LyDo;
            tmp.CamKet = hoSoGiayPhep.CamKet;
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
