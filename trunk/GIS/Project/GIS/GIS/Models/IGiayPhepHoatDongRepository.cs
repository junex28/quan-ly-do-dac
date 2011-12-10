using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IGiayPhepHoatDongRepository
    {        
        IQueryable<GiayPhepHoatDong> GetGiayPhepHoatDongs();
        GiayPhepHoatDong GetGiayPhepHoatDongByID(int id);

        void Add(GiayPhepHoatDong GiayPhepHoatDong);
        void Delete(GiayPhepHoatDong GiayPhepHoatDong);
        void Save();
    }
}
