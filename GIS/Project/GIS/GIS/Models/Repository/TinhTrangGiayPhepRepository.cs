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
    public class TinhTrangGiayPhepRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<TinhTrangGiayPhep> GetTinhTrangGiayPheps()
        {
            return db.TinhTrangGiayPheps.AsQueryable();
        }

        public TinhTrangGiayPhep GetTinhTrangGiayPhepByID(int Id)
        {
            return db.TinhTrangGiayPheps.SingleOrDefault(t => t.MaTinhTrang == Id);
        }

        public void Add(TinhTrangGiayPhep tinhTrangGP)
        {
            db.TinhTrangGiayPheps.InsertOnSubmit(tinhTrangGP);
        }

        public void Delete(TinhTrangGiayPhep GiayPhepHoatDong)
        {
            
        }

        public void Save()
        {
            db.SubmitChanges();
        }
        }
}
