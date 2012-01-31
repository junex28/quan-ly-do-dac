using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IBaoCaoHoatDongRepository
    {
        IQueryable<BaoCaoHoatDong> GetBaoCaoHoatDongs();
        IPagedList<BaoCaoHoatDong> GetBaoCaoHoatDongByTCID(int tcid, int pageNo);
        BaoCaoHoatDong GetBaoCaoHoatDongByTC(int tcid);

        void Add(BaoCaoHoatDong BaoCaoHoatDong);
        void Delete(BaoCaoHoatDong BaoCaoHoatDong);
        void Update(BaoCaoHoatDong BaoCaoHoatDong);
        void Save();
    }
}
