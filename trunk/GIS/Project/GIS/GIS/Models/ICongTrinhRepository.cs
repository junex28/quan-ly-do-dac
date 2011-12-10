using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ICongTrinhRepository
    {        
        IQueryable<CongTrinh> GetCongTrinhs();
        CongTrinh GetCongTrinhByID(int id);

        void Add(CongTrinh CongTrinh);
        void Delete(CongTrinh CongTrinh);
        void Save();
    }
}
