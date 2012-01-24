using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace GIS.Models
{
    public interface IThongTinChungRespository
    {
        IQueryable<ThongTinChung> GetThongTinChungs();
        ThongTinChung GetThongTinChungByID(int id);

        void Add(ThongTinChung thongtinchung);
        void Delete(ThongTinChung thongtinchung);
        void Save();
    }
}
