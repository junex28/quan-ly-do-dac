using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IQuyenCuaNhomRepository
    {
        IQueryable<QuyenCuaNhom> GetQuyenCuaNhoms();
        QuyenCuaNhom GetQuyenCuaNhomByID(int id);

        void Add(QuyenCuaNhom QuyenCuaNhom);
        void Delete(QuyenCuaNhom QuyenCuaNhom);
        void Save();
    }
}
