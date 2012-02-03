using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.Mvc;
using GIS.Models;

namespace GIS.ViewModels
{
   
    public class GiayPhepDetailModel
    {
        DDBDDataContext db = new DDBDDataContext();
        public HoSoGiayPhep giayphep { get; set; }
        public IQueryable<DangKyHoatDong> DangKy{ get; set; }
        public IQueryable<HoatDongDuocCap> DangKyDaCap { get; set; }
        public IQueryable<HoatDongDuocCap> DangKyBoSung { get; set; }
        public IEnumerable<HoatDong> hoatdong { get; set; }
        public IList<NangLucKeKhai> nangluc { get; set; }
        public int MaBaoCao { get; set; }
        //public IEnumerable<SelectListItem> selectListItems{get; set;}
        //public IEnumerable<Stri> availableItems
       
    }
}
