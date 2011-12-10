using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ICongDoanThucHienRepository
    {        
        IQueryable<CongDoanThucHien> GetCongDoanThucHiens();
        CongDoanThucHien GetCongDoanThucHienByID(int id);

        void Add(CongDoanThucHien CongDoanThucHien);
        void Delete(CongDoanThucHien CongDoanThucHien);
        void Save();
    }
}
