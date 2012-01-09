using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface INhanLucRepository
    {
        IQueryable<NhanLuc> GetNhanLucs();
        IPagedList<NhanLuc> GetNhanLucByID(int tcid, int pageNo);
        void Add(NhanLuc NhanLuc);
        void Delete(NhanLuc NhanLuc);
        void Save();
    }
}
