using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IMocTrongLuc
    {
        IQueryable<MocTrongLuc> GetMocTrongLucs();
        MocTrongLuc GetMocTrongLucByID(int id);
        IQueryable<MocTrongLuc> GetMocTLBySearch(string search);

        void Update(MocTrongLuc mocTrongLuc);
        void Delete(MocTrongLuc mocTrongLuc);
        void Save();
    }
}
