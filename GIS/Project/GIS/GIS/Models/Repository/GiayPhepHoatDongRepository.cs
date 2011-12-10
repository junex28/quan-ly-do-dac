using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class GiayPhepHoatDongRepository : IGiayPhepHoatDongRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<GiayPhepHoatDong> GetGiayPhepHoatDongs()
        {
            return db.GiayPhepHoatDongs.AsQueryable();
        }

        public GiayPhepHoatDong GetGiayPhepHoatDongByID(int id)
        {
            return db.GiayPhepHoatDongs.SingleOrDefault(d => d.MaGiayPhepHoatDong == id);
        }

        public void Add(GiayPhepHoatDong GiayPhepHoatDong)
        {
            db.GiayPhepHoatDongs.InsertOnSubmit(GiayPhepHoatDong);
        }

        public void Delete(GiayPhepHoatDong GiayPhepHoatDong)
        {
            db.DangKyHoatDongs.DeleteAllOnSubmit(GiayPhepHoatDong.DangKyHoatDongs);
            db.ThamDinhs.DeleteAllOnSubmit(GiayPhepHoatDong.ThamDinhs);
            db.GiayPhepHoatDongs.DeleteOnSubmit(GiayPhepHoatDong);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
