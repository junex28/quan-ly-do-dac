using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ITinhTrangGiayPhepRepository
    {
        IQueryable<TinhTrangGiayPhep> GetTinhTrangGiayPheps();
        TinhTrangGiayPhep GetTinhTrangGiayPhepByID(int id);

        void Add(TinhTrangGiayPhep TinhTrangGiayPhep);
        void Delete(TinhTrangGiayPhep TinhTrangGiayPhep);
        void Save();
    }
}
