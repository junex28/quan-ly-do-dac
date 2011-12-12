using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;

namespace GIS.ViewModels
{
    public class ToChucDetailViewModel
    {
        public ToChuc toChuc { get; set; }
        public IList<LoaiHinhToChuc> loaiHinh { get; set; }
     }
}
