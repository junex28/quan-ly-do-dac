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
        ToChuc GetToChucByTaiKhoan(int tkId);
        void Update(ToChuc tochuc);
        void Add(ToChuc tochuc);
        void Delete(ToChuc tochuc);
        void Save();

   }
}
