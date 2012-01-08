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
using System.Collections.Generic;

namespace GIS.Models.Repository
{
    public class NangLucKeKhaiRespository: INangLucKeKhaiRespository
    {
        DDBDDataContext db = new DDBDDataContext();
        //public IList<NangLucKeKhai> DSKKNangLuc { get; set; }
        public IQueryable<NangLucKeKhai> GetNangLucKeKhais()
        {
            return db.NangLucKeKhais.AsQueryable();
        }
        public IQueryable<NangLucKeKhai> GetNangLucKeKhaiByID(int tcid)
        {
            return from nn in db.NangLucKeKhais
                    where nn.MaToChuc == tcid
                    select nn;
        }

        public void Add(NangLucKeKhai kknangluc)
        {
            db.NangLucKeKhais.InsertOnSubmit(kknangluc);
            db.SubmitChanges();
        }

        public void Delete(NangLucKeKhai kknangluc)
        {
            db.NangLucKeKhais.DeleteOnSubmit(kknangluc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }

    }
}
