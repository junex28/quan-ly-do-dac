using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IQuyenRepository
    {
        IQueryable<Quyen> GetQuyens();
        Quyen GetQuyenByID(int id);

        void Add(Quyen Quyen);
        void Delete(Quyen Quyen);
        void Save();
    }
}
