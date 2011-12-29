using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ILoaiHinhToChucRepository
    {
        IQueryable<LoaiHinhToChuc> GetLoaiHinhToChucs();
        LoaiHinhToChuc GetLoaiHinhToChucByID(int id);
        IEnumerable<LoaiHinhToChuc> GetLoaiHinhToChucs1();
        void Add(LoaiHinhToChuc LoaiHinhToChuc);
        void Delete(LoaiHinhToChuc LoaiHinhToChuc);
        void Save();
    }
}
