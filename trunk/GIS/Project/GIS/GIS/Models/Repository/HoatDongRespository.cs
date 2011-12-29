using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections;

namespace GIS.Models.Repository
{
    public class HoatDongRespository: IHoatDongRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<HoatDong> GetHoatDongs()
        {
            return db.HoatDongs.AsQueryable();
        }

       
        /*
        public IEnumerable<HoatDong> GetDSHoatDongByID(int id )
        {
            return from hd in db.HoatDongs (from dk in db.DangKyHoatDongs where dk.MaGiayPhepHoatDong == id select dk.MaHoatDong)
                   
        }
        */
        public HoatDong GetHoatDongByID(int id)
        {
            return db.HoatDongs.SingleOrDefault(d => d.MaHoatDong == id);
        }

        public void Add(HoatDong hoatdong)
        {
            db.HoatDongs.InsertOnSubmit(hoatdong);
        }

        public void Delete(HoatDong hoatdong)
        {
            db.HoatDongs.DeleteOnSubmit(hoatdong);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
