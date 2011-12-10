using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IHoatDongRepository
    {        
        IQueryable<HoatDong> GetHoatDongs();
        HoatDong GetHoatDongByID(int id);

        void Add(HoatDong HoatDong);
        void Delete(HoatDong HoatDong);
        void Save();
    }
}
