using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace GIS.Models
{
    public interface IThamDinhRepository
    {
        IQueryable<ThamDinh> GetThamDinhs();
        ThamDinh GetThamDinhByGPID(int id);
        List<string> GetNguoiThamDinh(string nguoithamdinh);
        List<string> GetDaiDienTC(string nguoidaidien);
        ThamDinh GetThamDinhByGP(HoSoGiayPhep hs);
        ThamDinh GetThamDinhById(int id);
        ThamDinh GetThamDinhMoiById(int id, int maTinhTrang);

        //ThamDinh GetThamDinhHoatDongById(int id);
        void Add(ThamDinh ThamDinh);
        void Delete(ThamDinh ThamDinh);
        void Save();
    }
}
