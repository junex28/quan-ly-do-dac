using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IHoSoGiayPhepRepository
    {
        IQueryable<HoSoGiayPhep> GetHoSoGiayPheps(string strSearch);
        IQueryable<HoSoGiayPhep> GetGPHDByTinhTrang(int Id, string strSearch);
        HoSoGiayPhep GetHoSoGiayPhepByID(int id);
        IList<HoSoGiayPhep> GetHSGPByToChuc(int tcId);
        int Check(int tcId);
        void Add(HoSoGiayPhep HoSoGiayPhep);
        void Delete(HoSoGiayPhep HoSoGiayPhep);
        void Update(HoSoGiayPhep HoSoGiayPhep);
        void Save();
    }
}
