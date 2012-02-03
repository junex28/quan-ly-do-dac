using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface INhanLucRepository
    {
        IQueryable<NhanLuc> GetNhanLucs();
        IPagedList<NhanLuc> GetNhanLucByTTCID(int ttcid, int pageNo);
        List<NhanLuc> GetNhanLucByTTC(int ttcid);
        List<NhanLuc> GetNhanLucByTCID(int tcid);
        void Add(NhanLuc NhanLuc);
        void Delete(NhanLuc NhanLuc);
        void Save();
    }
}

