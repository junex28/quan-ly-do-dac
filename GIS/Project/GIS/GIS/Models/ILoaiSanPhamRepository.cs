using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ILoaiSanPhamRepository
    {
        IQueryable<LoaiSanPham> GetLoaiSanPhams();
        LoaiSanPham GetLoaiSanPhamByID(int id);

        void Add(LoaiSanPham LoaiSanPham);
        void Delete(LoaiSanPham LoaiSanPham);
        void Save();
    }
}
