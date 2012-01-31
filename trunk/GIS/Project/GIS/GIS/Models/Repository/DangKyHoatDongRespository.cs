using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Collections;
using GIS.Models;

namespace GIS.Models.Repository
{
    public class DangKyHoatDongRespository: IDangKyHoatDongRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<DangKyHoatDong> GetDangKyHDs(int gpId)
        {
            return from dk in db.DangKyHoatDongs
                   where dk.MaHoSo == gpId 
                   select dk; 
        }
        public IQueryable<DangKyHoatDong> GetDangKyHDMoi(int gpId)
        {
            return from dk in db.DangKyHoatDongs
                   where dk.MaHoSo == gpId 
                   select dk;
        }
        public IQueryable<HoatDongDuocCap> GetDKHDDaCap(int gpId)
        {
            HoSoGiayPhep hs = db.HoSoGiayPheps.SingleOrDefault(d => d.MaHoSo == gpId);
            return from dk in db.HoatDongDuocCaps
                   where dk.SoGiayPhep == hs.SoGiayPhep && dk.LanBoSung == 0
                   select dk;
        }

        public IQueryable<HoatDongDuocCap> GetDKHDBoSung(int gpId)
        {
            HoSoGiayPhep hs = db.HoSoGiayPheps.SingleOrDefault(d => d.MaHoSo == gpId);
            return from dk in db.HoatDongDuocCaps
                   where dk.SoGiayPhep == hs.SoGiayPhep && dk.LanBoSung > 0
                   select dk;
        }

        public IList<HoatDongDuocCap> GetHDDaCapBySoGP(string sogp, int tcId)
        {
            return (from dk in db.HoatDongDuocCaps
                   where dk.SoGiayPhep == sogp && dk.MaToChuc == tcId
                   select dk).ToList();
        }

        public DangKyHoatDong GetDangKysHDByID(int id)
        {
            return db.DangKyHoatDongs.SingleOrDefault(d => d.MaDangKyHoatDong == id);
        }

        public List<int> getSelectedHD(List<DangKyHoatDong> dk)
        {
            List<int> listMaHD = new List<int>();
            foreach (DangKyHoatDong d in dk)
            {
                listMaHD.Add((int)d.MaHoatDong);
            }
            return listMaHD;
        }
        public int getSoLanBoSung(int tcId)
        {
            var i = (int)(from hd in db.HoatDongDuocCaps
                     where hd.MaToChuc == tcId
                     select hd.LanBoSung).Max();
            return (i + 1);
        }

      /*  public  IEnumerable<HoatDong> GetHoatDongByDangKy(List<DangKyHoatDong> dk)
        {
            List<int> listMaHD = new List<int>();
            foreach (DangKyHoatDong d in dk)
            {
                listMaHD.Add((int)d.MaHoatDong);
            }
           // return from d in db.HoatDongs
             //      where d.MaHoatDong in dk
        }
        */
        public void Add(DangKyHoatDong DangKy)
        {
            db.DangKyHoatDongs.InsertOnSubmit(DangKy);
            db.SubmitChanges();
        }

        public void Delete(DangKyHoatDong DangKy)
        {
            db.DangKyHoatDongs.DeleteOnSubmit(DangKy);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
