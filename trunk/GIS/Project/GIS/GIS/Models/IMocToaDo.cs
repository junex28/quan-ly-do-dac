using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IMocToaDo
    {
        IQueryable<MocToaDo> GetMocToaDos();
        MocToaDo GetMocToaDoByID(int id);
        IQueryable<MocToaDo> GetMocTDBySearch(string search);

        void Update(MocToaDo mocToaDo);
        void Delete(MocToaDo mocToaDo);
        void Save();
    }
}
