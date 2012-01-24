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

namespace GIS.Models.Repository
{
    public class ThongTinChungRespository: IThongTinChungRespository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<ThongTinChung> GetThongTinChungs()
        {
            return db.ThongTinChungs.AsQueryable();
        }

        public ThongTinChung GetThongTinChungByID(int id)
        {
            return db.ThongTinChungs.SingleOrDefault(d => d.MaThongTinChung == id);
        }

        public void Add(ThongTinChung ThongTinChung)
        {
            db.ThongTinChungs.InsertOnSubmit(ThongTinChung);
            db.SubmitChanges();
        }

        public void Delete(ThongTinChung ThongTinChung)
        {
            db.ThongTinChungs.DeleteOnSubmit(ThongTinChung);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
       
    }
}
