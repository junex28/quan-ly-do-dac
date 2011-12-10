using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IQuanHuyenRepository
    {
        IQueryable<QuanHuyen> GetQuanHuyens();
        QuanHuyen GetQuanHuyenByID(int id);

        void Add(QuanHuyen QuanHuyen);
        void Delete(QuanHuyen QuanHuyen);
        void Save();
    }
}
