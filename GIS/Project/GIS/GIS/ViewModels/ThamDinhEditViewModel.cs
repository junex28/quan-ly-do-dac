using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GIS.ViewModels
{
    public class ThamDinhEditViewModel
    {
        [DisplayName("Mã giấy phép hoạt động")]
        public int MaHoSo { get; set; }

        [Required(ErrorMessage = "Đại diện thẩm định không được trống")]
        [DisplayName("Đại diện thẩm định")]
        public string NguoiThamDinh { get; set; }

        [Required(ErrorMessage = "Đại diện phía tổ chức không được trống")]
        [DisplayName("Đại diện tổ chức")]
        public string NguoiPhiaToChuc { get; set; }

        [Required(ErrorMessage = "Chọn ngày thẩm định")]
        [DisplayName("Ngày thẩm định")]
        public DateTime NgayThamDinh { get; set; }

        [Required(ErrorMessage = "Điền nhận xét về tính hợp lệ")]
        [DisplayName("Tính hợp lệ")]
        public string TinhHopLe { get; set; }

        [Required(ErrorMessage = "Nhận xét về năng lực nhân viên")]
        [DisplayName("Năng lực nhân viên")]
        public string NangLucNhanVien { get; set; }

        [Required(ErrorMessage = "Nhận xét về năng lực thiết bị")]
        [DisplayName("Năng lực thiết bị")]
        public string NangLucThietBi { get; set; }

        [Required(ErrorMessage = "Vui lòng điền kết luận")]
        [DisplayName("Kết luận")]
        public string KetLuan { get; set; }

        [Required(ErrorMessage = "Vui lòng điền kiến nghị")]
        [DisplayName("Kiến nghị")]
        public string KienNghi { get; set; }

        [DisplayName("Thẩm định")]
        public ThamDinh ThamDinh { get; set; }

        public HoSoGiayPhep giayphep { get; set; }

        public GiayPhepDetailModel thongtinchung { get; set; }

        public string SoGiayPhep { get; set; } 
    }
}
