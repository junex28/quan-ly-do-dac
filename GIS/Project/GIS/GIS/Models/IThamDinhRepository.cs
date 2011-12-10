using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IThamDinhRepository
    {
        IQueryable<ThamDinh> GetThamDinhs();
        ThamDinh GetThamDinhByID(int id);

        void Add(ThamDinh ThamDinh);
        void Delete(ThamDinh ThamDinh);
        void Save();
    }
}
