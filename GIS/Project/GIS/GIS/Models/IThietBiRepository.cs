using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IThietBiRepository
    {
        IQueryable<ThietBi> GetThietBis();
        ThietBi GetThietBiByID(int id);

        void Add(ThietBi ThietBi);
        void Delete(ThietBi ThietBi);
        void Save();
    }
}
