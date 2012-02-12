using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace GIS.ViewModels
{
    public class Moc
    {
     [DisplayName("ObjectID")]
        public int objId { get; set;}
        [DisplayName("Số hiệu")]
     public string soHieu { get; set; }
        [DisplayName("Năm thành lập")]
        public string namThanhLap { get; set; }
        [DisplayName("Mã sản phẩm")]
        public int maSP { get; set; }
        [DisplayName("Cấp hạng mốc")]
        public int capHang { get; set; }
        [DisplayName("Loại mốc")]
        public int loaiMoc { get; set; }
        [DisplayName("Hệ quy chiếu")]
        public string heQuyChieu { get; set; }
        [DisplayName("Tình trạng")]
        public int tinhTrang { get; set; }

        //public Hashtable dsTinhTrang { get; set; }
        //public Hashtable dsLoaiMoc { get; set; }
        //public Hashtable dsCapHangMoc { get; set; }
    }
}