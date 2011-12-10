using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IDangKyHoatDongRepository
    {        
        IQueryable<DangKyHoatDong> GetDangKyHoatDongs();
        DangKyHoatDong GetDangKyHoatDongByID(int id);

        void Add(DangKyHoatDong DangKyHoatDong);
        void Delete(DangKyHoatDong DangKyHoatDong);
        void Save();
    }
}
