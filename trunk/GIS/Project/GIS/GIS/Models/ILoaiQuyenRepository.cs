using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ILoaiQuyenRepository
    {
        IQueryable<LoaiQuyen> GetLoaiQuyens();
        LoaiQuyen GetLoaiQuyenByID(int id);

        void Add(LoaiQuyen LoaiQuyen);
        void Delete(LoaiQuyen LoaiQuyen);
        void Save();
    }
}
