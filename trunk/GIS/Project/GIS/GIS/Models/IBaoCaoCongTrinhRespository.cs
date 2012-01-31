using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IBaoCaoCongTrinhRespository
    {
        IQueryable<BaoCaoCongTrinh> GetBaoCaoCongTrinhs();
        IPagedList<BaoCaoCongTrinh> GetBCCTByBCID(int bcid, int pageNo);
        List<BaoCaoCongTrinh> GetBCCTByBCHD(int bcid);

        void Add(BaoCaoCongTrinh BaoCaoCongTrinh);
        void Delete(BaoCaoCongTrinh BaoCaoCongTrinh);
        void Save();
    }
}
