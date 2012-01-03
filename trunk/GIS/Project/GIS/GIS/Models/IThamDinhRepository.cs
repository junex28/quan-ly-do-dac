using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IThamDinhRepository
    {
        IQueryable<ThamDinh> GetThamDinhs();
        IQueryable<ThamDinh> GetThamDinhByGPID(int id);
        ThamDinh GetThamDinhById(int id);
        ThamDinh GetThamDinhMoiById(int id, int maTinhTrang);
        //ThamDinh GetThamDinhHoatDongById(int id);
        void Add(ThamDinh ThamDinh);
        void Delete(ThamDinh ThamDinh);
        void Save();
    }
}
