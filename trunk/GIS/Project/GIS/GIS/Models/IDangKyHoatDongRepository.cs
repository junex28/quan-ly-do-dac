using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace GIS.Models
{
    public interface IDangKyHoatDongRepository
    {
        IQueryable<DangKyHoatDong> GetDangKyHDs(int id);
        IQueryable<DangKyHoatDong> GetDangKyHDMoi(int id);
        IQueryable<HoatDongDuocCap> GetDKHDDaCap(int id);
        IQueryable<HoatDongDuocCap> GetDKHDBoSung(int id);
        //IEnumerable<HoatDong> GetHoatDongByDangKy(List<DangKyHoatDong> dk);
        IList<HoatDongDuocCap> GetHDDaCapBySoGP(string sogp, int tcId);
        List<int> getSelectedHD(List<DangKyHoatDong> dk);
        int getSoLanBoSung(int tcId);
       
        void Add(DangKyHoatDong DangKyHoatDong);
        void Delete(DangKyHoatDong DangKyHoatDong);
        void Save();
    }
}
