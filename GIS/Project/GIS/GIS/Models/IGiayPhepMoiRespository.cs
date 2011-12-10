using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Xml.Linq;

namespace GIS.Models
{
    public interface IGiayPhepMoiRepository
    {
        IQueryable<GiayPhepHoatDong> GetDSMoi();
        IQueryable<GiayPhepHoatDong> GetDSMoiChoCapGP();
        GiayPhepHoatDong GetGPById(int Id);
        GiayPhepHoatDong GetGPBySoGP(string soGiayPhep);
        //IQueryable<v_DSGP> DSGP();
        //IQueryable<v_DSGP> DSChoXetDuyet();

        //v_DSChoThamDinh TimGPChoCanPhep(int id);

        void Insert(GiayPhepHoatDong gpChoThamDinh);
        void Edit(GiayPhepHoatDong gpChoCapPhep);
        void Delete(GiayPhepHoatDong gpChoCapPhep);
        void Save();
    }
}
