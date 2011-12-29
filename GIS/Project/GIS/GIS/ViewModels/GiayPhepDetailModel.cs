using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;

namespace GIS.ViewModels
{
    public class GiayPhepDetailModel
    {
        public GiayPhepHoatDong gphd { get; set; }
        public IQueryable<DangKyHoatDong> DangKy { get; set; }
        public IQueryable<HoatDong> HoatDong { get; set; }
    }
}
