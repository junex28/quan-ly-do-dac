using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Collections.Generic;
using System.Xml.Linq;

namespace GIS.Models
{
    public class GiayPhepMoiRepository : IGiayPhepMoiRepository
    {
        DDBDDataContext context = new DDBDDataContext();

        public GiayPhepMoiRepository()
        {
        }

        public GiayPhepMoiRepository(DDBDDataContext context)
        {
            this.context = context;
        }

        public IQueryable<GiayPhepHoatDong> GetDSMoi()
        {

            try
            {
                return from gp in context.GiayPhepHoatDongs
                       where gp.TinhTrang == 1 
                       select gp;
            }
            catch { return null; }
        }


        public IQueryable<GiayPhepHoatDong> GetDSMoiChoCapGP()
        {
            try
            {
                return from gp in context.GiayPhepHoatDongs
                       where gp.TinhTrang == 4
                       select gp;
            }
            catch { return null; }
        }


        public GiayPhepHoatDong GetGPById(int id)
        {
            return context.GiayPhepHoatDongs.SingleOrDefault(gp => gp.MaGiayPhepHoatDong == id);
        }



        public GiayPhepHoatDong GetGPBySoGP(string soGiayPhep)
        {
            return context.GiayPhepHoatDongs.SingleOrDefault(gp => gp.SoGiayPhep == soGiayPhep);
        }

        public void Edit(GiayPhepHoatDong gp)
        {

        }
        public void Delete(GiayPhepHoatDong gp)
        {
        }
        public void Insert(GiayPhepHoatDong gp)
        {
            context.GiayPhepHoatDongs.InsertOnSubmit(gp);
        }

        public void Save()
        {
            context.SubmitChanges();
        }
    }
}
