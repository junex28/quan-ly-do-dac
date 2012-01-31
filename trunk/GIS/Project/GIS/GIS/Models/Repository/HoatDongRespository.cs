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

        public HoatDong GetHoatDongByID(int id)
        {
            return db.HoatDongs.SingleOrDefault(d => d.MaHoatDong == id);
        }

        public bool checkContain(int i)
        {
            var k = from hd in db.HoatDongs
                    where hd.MaHoatDong == i
                    select hd;
            if (k != null)
                return true;
            return false;
        }

        public void Add(HoatDong hoatdong)
        {
            db.HoatDongs.InsertOnSubmit(hoatdong);
            db.SubmitChanges();
        }

        public void Delete(HoatDong hoatdong)
        {
            db.HoatDongs.DeleteOnSubmit(hoatdong);
            db.SubmitChanges();
        }
        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
