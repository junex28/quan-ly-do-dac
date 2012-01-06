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
    public class ThamDinhRespository: IThamDinhRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<ThamDinh> GetThamDinhs()
        {
            return db.ThamDinhs.AsQueryable();
        }

        public IQueryable<ThamDinh> GetThamDinhByGPID(int id)
        {
            return from td in db.ThamDinhs
                   where td.MaGiayPhepHoatDong == id
                   select td;
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
                    where p.GiayPhepHoatDong.TinhTrangGiayPhep.MaTinhTrang == 2 || (p.GiayPhepHoatDong.TinhTrangGiayPhep.MaTinhTrang > 3 && p.GiayPhepHoatDong.TinhTrangGiayPhep.MaTinhTrang < 6)
                            || (p.GiayPhepHoatDong.TinhTrangGiayPhep.MaTinhTrang > 6 && p.GiayPhepHoatDong.TinhTrangGiayPhep.MaTinhTrang < 9) || p.GiayPhepHoatDong.TinhTrangGiayPhep.MaTinhTrang > 9
                    group p by p.MaGiayPhepHoatDong into grp
                    select grp.OrderByDescending(g => g.NgayThamDinh).First();
            ThamDinh td = q.FirstOrDefault();
            return td;
        }      

        //public ThamDinh GetThamDinhHoatDongById(int id)
        //{
        //    var td = from t in db.ThamDinhs
        //             where t.MaGiayPhepHoatDong == id
        //             group t by t.MaGiayPhepHoatDong into g
        //             select new { MaGiayPhepHoatDong = g.Key, NgayThamDinh = g.Max(t => t.NgayThamDinh) };
        //    return (ThamDinh)td;
        //}

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
