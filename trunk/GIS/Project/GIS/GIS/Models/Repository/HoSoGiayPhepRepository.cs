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

        public HoSoGiayPhep GetHoSoGiayPhepByID(int id)
        {
            return db.HoSoGiayPheps.SingleOrDefault(d => d.MaHoSo == id);
        }

        public void Add(HoSoGiayPhep HoSoGiayPhep)
        {
            db.HoSoGiayPheps.InsertOnSubmit(HoSoGiayPhep);
        }

        public void Delete(HoSoGiayPhep HoSoGiayPhep)
        {
            //db.DangKyHoatDongs.DeleteAllOnSubmit(HoSoGiayPhep);
            //db.ThamDinhs.DeleteAllOnSubmit(HoSoGiayPhep.ThamDinhs);
            db.HoSoGiayPheps.DeleteOnSubmit(HoSoGiayPhep);
            db.SubmitChanges();
        }

        public void Update(HoSoGiayPhep hoSoGiayPhep)
        {
            HoSoGiayPhep tmp = GetHoSoGiayPhepByID(hoSoGiayPhep.MaHoSo);
            //tmp.MaToChuc = hoSoGiayPhep.MaToChuc;
            //tmp.MaThongTinChung = hoSoGiayPhep.MaThongTinChung;
            tmp.NgayCapPhep = hoSoGiayPhep.NgayCapPhep;
            tmp.NgayHetHan = hoSoGiayPhep.NgayHetHan;
            tmp.NgayXinPhep = hoSoGiayPhep.NgayXinPhep;
            tmp.SoGiayPhep = hoSoGiayPhep.SoGiayPhep;
            tmp.TepDinhKem = hoSoGiayPhep.TepDinhKem;
            tmp.TinhTrang = hoSoGiayPhep.TinhTrang;
            //tmp.ToChuc = hoSoGiayPhep.ToChuc;
            tmp.LyDo = hoSoGiayPhep.LyDo;
            tmp.CamKet = hoSoGiayPhep.CamKet;
            // ... them dum M roi chay lại thử xem
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
