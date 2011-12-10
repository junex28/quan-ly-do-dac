using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface INhomNguoiDungRepository
    {
        IQueryable<NhomNguoiDung> GetNhomNguoiDungs();
        NhomNguoiDung GetNhomNguoiDungByID(int id);

        void Add(NhomNguoiDung NhomNguoiDung);
        void Delete(NhomNguoiDung NhomNguoiDung);
        void Save();
    }
}
