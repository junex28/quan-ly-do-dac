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

        [Required(ErrorMessage = "Không được trống")]
        [DisplayName("Đại diện thẩm định")]
        public string NguoiThamDinh { get; set; }

        [Required(ErrorMessage = "Không được trống")]
        [DisplayName("Đại diện tổ chức")]
        public string NguoiPhiaToChuc { get; set; }

        [Required(ErrorMessage = "Chọn ngày thẩm định")]
        [DisplayName("Ngày thẩm định")]
        public DateTime NgayThamDinh { get; set; }

        [Required(ErrorMessage = "Điền nhận xét")]
        [DisplayName("Tính hợp lệ")]
        public string TinhHopLe { get; set; }

        [Required(ErrorMessage = "Điền nhận xét")]
        [DisplayName("Năng lực nhân viên")]
        public string NangLucNhanVien { get; set; }

        [Required(ErrorMessage = "Điền nhận xét")]
        [DisplayName("Năng lực thiết bị")]
        public string NangLucThietBi { get; set; }

        [Required(ErrorMessage = "Điền kết luận")]
        [DisplayName("Kết luận")]
        public string KetLuan { get; set; }

        [Required(ErrorMessage = "Điền kiến nghị")]
        [DisplayName("Kiến nghị")]
        public string KienNghi { get; set; }

        [DisplayName("Thẩm định")]
        public ThamDinh ThamDinh { get; set; }

        public HoSoGiayPhep giayphep { get; set; }

        public GiayPhepDetailModel thongtinchung { get; set; }

        public string SoGiayPhep { get; set; }

        [DisplayName("Ngày cấp phép")]
        public DateTime NgayCapPhep { get; set; }

        [DisplayName("Ngày hết hạn")]
        public DateTime NgayHetHan { get; set; }
    }
}
