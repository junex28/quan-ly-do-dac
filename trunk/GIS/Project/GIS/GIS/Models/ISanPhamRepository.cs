using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ISanPhamRepository
    {
        IQueryable<SanPham> GetSanPhams();
        SanPham GetSanPhamByID(int id);

        void Add(SanPham SanPham);
        void Delete(SanPham SanPham);
        void Save();
    }
}
