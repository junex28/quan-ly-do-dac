using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IHoSoGiayPhepRepository
    {        
        IQueryable<HoSoGiayPhep> GetHoSoGiayPheps();
        IQueryable<HoSoGiayPhep> GetGPHDByTinhTrang(int Id);
        HoSoGiayPhep GetHoSoGiayPhepByID(int id);
        void Add(HoSoGiayPhep HoSoGiayPhep);
        void Delete(HoSoGiayPhep HoSoGiayPhep);
        void Save();
    }
}
