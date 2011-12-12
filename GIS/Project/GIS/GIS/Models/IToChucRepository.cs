using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IToChucRepository
    {        
        IQueryable<ToChuc> GetToChucs();
        ToChuc GetToChucByID(int id);

        void Add(ToChuc tochuc);
        void Delete(ToChuc tochuc);
        void Save();

        LoaiHinhToChuc getLoaiHinh(ToChuc tochuc);
    }
}
