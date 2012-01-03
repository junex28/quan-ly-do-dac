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
    public class LoaiThamDinhResposiroty : ILoaiThamDinhRepository
    {
          DDBDDataContext db = new DDBDDataContext();

        public IQueryable<LoaiThamDinh> GetLoaiThamDinhs()
        {
            return db.LoaiThamDinhs.AsQueryable();
        }

        public LoaiThamDinh GetLoaiThamDinhByID(int id)
        {
            return db.LoaiThamDinhs.SingleOrDefault(d => d.MaLoaiThamDinh == id);
        }

        public void Add(LoaiThamDinh loaithamdinh)
        {
            db.LoaiThamDinhs.InsertOnSubmit(loaithamdinh);
            db.SubmitChanges();
        }

        public void Delete(LoaiThamDinh loaithamdinh)
        {
            db.LoaiThamDinhs.DeleteOnSubmit(loaithamdinh);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
