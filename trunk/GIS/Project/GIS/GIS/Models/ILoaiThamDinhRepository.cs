using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ILoaiThamDinhRepository
    {
        IQueryable<LoaiThamDinh> GetLoaiThamDinhs();
        LoaiThamDinh GetLoaiThamDinhByID(int id);

        void Add(LoaiThamDinh LoaiThamDinh);
        void Delete(LoaiThamDinh LoaiThamDinh);
        void Save();
    }
}
