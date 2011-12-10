using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IKieuSanPhamRepository
    {
        IQueryable<KieuSanPham> GetKieuSanPhams();
        KieuSanPham GetKieuSanPhamByID(int id);

        void Add(KieuSanPham KieuSanPham);
        void Delete(KieuSanPham KieuSanPham);
        void Save();
    }
}
