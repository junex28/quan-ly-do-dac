using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IGiayPhepHoatDongRepository
    {        
        IQueryable<GiayPhepHoatDong> GetGiayPhepHoatDongs();
        IQueryable<GiayPhepHoatDong> GetGPHDByTinhTrang(int Id);
        /*IQueryable<GiayPhepHoatDong> GetGPMois();
        IQueryable<GiayPhepHoatDong> GetGPMoiThatBais();
        IQueryable<GiayPhepHoatDong> GetGPHetHans();
        IQueryable<GiayPhepHoatDong> GetGPMoiThanhCongs();
        IQueryable<GiayPhepHoatDong> GetGPDaDuocCaps();
        IQueryable<GiayPhepHoatDong> GetGPBSHDs();
        IQueryable<GiayPhepHoatDong> GetGPBSHDThatBais();
        IQueryable<GiayPhepHoatDong> GetGPBSHDThanhCongs();
        IQueryable<GiayPhepHoatDong> GetGPGiaHans();
        IQueryable<GiayPhepHoatDong> GetGPGiaHanThatBais();
        IQueryable<GiayPhepHoatDong> GetGPGiaHanThanhCongs();
        */
        GiayPhepHoatDong GetGiayPhepHoatDongByID(int id);
        void Add(GiayPhepHoatDong GiayPhepHoatDong);
        void Delete(GiayPhepHoatDong GiayPhepHoatDong);
        void Save();
    }
}
