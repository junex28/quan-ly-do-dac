using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IBaoCaoHoatDongRepository
    {        
        IQueryable<BaoCaoHoatDong> GetBaoCaoHoatDongs();
        BaoCaoHoatDong GetBaoCaoHoatDongByID(int id);

        void Add(BaoCaoHoatDong BaoCaoHoatDong);
        void Delete(BaoCaoHoatDong BaoCaoHoatDong);
        void Save();
    }
}
