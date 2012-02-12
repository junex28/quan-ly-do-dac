using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IMocDoCao
    {
        IQueryable<MocDoCao> GetMocDoCaos();
        MocDoCao GetMocDoCaoByID(int id);
        IQueryable<MocDoCao> GetMocDCBySearch(string search);

        void Update(MocDoCao mocDoCao);
        void Delete(MocDoCao mocDoCao);
        void Save();
    }
}
