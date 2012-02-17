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
    public class ThamDinhRespository: IThamDinhRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<ThamDinh> GetThamDinhs()
        {
            return db.ThamDinhs.AsQueryable();
        }

        public List<string> GetNguoiThamDinh(string nguoithamdinh)
        {
            if (nguoithamdinh != null)
            {
                String[] arr = nguoithamdinh.Split(';');
                return arr.ToList();
            }
            return null;
        }

        public List<string> GetDaiDienTC(string nguoidaidien)
        {
            if (nguoidaidien != null)
            {
                String[] arr = nguoidaidien.Split(';');
                return arr.ToList();
            }
            return null;
        }

        public ThamDinh GetThamDinhByGPID(int id)
        {
            var list = from td in db.ThamDinhs
                           where td.MaHoSo == id
                           select td;
            if (list != null && list.Count()!= 0)
                return list.ToList()[0];
            return null;
        }
        public ThamDinh GetThamDinhByGP(HoSoGiayPhep hs)
        {
            return db.ThamDinhs.SingleOrDefault(d => d.MaHoSo == hs.MaHoSo);
        }
        public ThamDinh GetThamDinhById(int id)
        {
            return db.ThamDinhs.SingleOrDefault(d => d.MaThamDinh == id);
        }
        public ThamDinh GetThamDinhMoiById(int id, int maTinhTrang)
        {
            if (maTinhTrang == 1 || maTinhTrang == 6 || maTinhTrang == 9)
            {
                return null;
            }
            var q = from p in db.ThamDinhs
                    where p.HoSoGiayPhep.TinhTrangGiayPhep.MaTinhTrang == 2 || (p.HoSoGiayPhep.TinhTrangGiayPhep.MaTinhTrang > 3 && p.HoSoGiayPhep.TinhTrangGiayPhep.MaTinhTrang < 6)
                            || (p.HoSoGiayPhep.TinhTrangGiayPhep.MaTinhTrang > 6 && p.HoSoGiayPhep.TinhTrangGiayPhep.MaTinhTrang < 9) || p.HoSoGiayPhep.TinhTrangGiayPhep.MaTinhTrang > 9
                    group p by p.MaHoSo into grp
                    select grp.OrderByDescending(g => g.NgayThamDinh).First();
            ThamDinh td = q.FirstOrDefault();
            return td;
        }      

        public void Add(ThamDinh thamdinh)
        {
            db.ThamDinhs.InsertOnSubmit(thamdinh);
            db.SubmitChanges();
        }

        public void Delete(ThamDinh thamdinh)
        {
            db.ThamDinhs.DeleteOnSubmit(thamdinh);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
