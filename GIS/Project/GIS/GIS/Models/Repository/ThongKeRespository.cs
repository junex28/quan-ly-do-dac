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
    public class ThongKeRespository
    {
        DDBDDataContext db = new DDBDDataContext();
        //public int getThongKe(String strNam)
        //{
        //    var val = from p in db.HoSoGiayPheps
        //    let cCount =
        //               (
        //                 from c in db.HoSoGiayPheps
        //                 where c.TinhTrangGiayPhep.MaTinhTrang == 5
        //                 select c
        //               ).Count()
        //    select new { Count = cCount } ;
        //    return val;
        //}
//        {
//            var list = from p in db.ThamDinhs
//                       let cCount =
//                       (
//                         from c in db
//                         where p.ParentId == c.ChildParentId
//                         select c
//                       ).Count()
//                       select new { ParentId = p.Key, Count = cCount };

//            return list;
//        }
        
//        from p in context.ParentTable 
//let cCount = p.Children.Count()
//select new { ParentId = p.Key, Count = cCount } ;

    }
}
