using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ITinhThanhRepository
    {
        IQueryable<TinhThanh> GetTinhThanhs();
        TinhThanh GetTinhThanhByID(int id);

        void Add(TinhThanh TinhThanh);
        void Delete(TinhThanh TinhThanh);
        void Save();
    }
}
