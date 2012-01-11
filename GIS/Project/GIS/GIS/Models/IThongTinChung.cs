using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace GIS.Models
{
    public interface IThongTinChung
    {
        IQueryable<ThongTinChung> GetThongTinChungs();
        ThongTinChung GetTThongTinChungByID(int id);

        void Add(ThongTinChung thongtinchung);
        void Delete(ThongTinChung thongtinchung);
        void Save();
    }
}
