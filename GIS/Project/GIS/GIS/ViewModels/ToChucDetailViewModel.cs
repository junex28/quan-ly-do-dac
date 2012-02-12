using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace GIS.ViewModels
{
    public class ToChucDetailViewModel
    {
        [Required(ErrorMessage = "Tên tổ chức không được trống")]
        [DisplayName("Tên tổ chức")]
        public string TenToChuc { get; set; }

        [Required(ErrorMessage = "Giấy phép kinh doanh không được trống")]
        [DisplayName("Giấy phép kinh doanh")]
        public  string GiayPhepKinhDoanh { get; set; }

        [DisplayName("Loại hình tổ chức")]
        public LoaiHinhToChuc LoaiHinhToChuc { get; set; }
        
        [DisplayName("Địa chỉ trụ sở chính")]
        public string TruSoChinh { get; set; }
        
        [DisplayName("Người đại diện")]
        public string NguoiDaiDien { get; set; }

        [RegularExpression(@"[0-9+\(+\)]{10,14}", ErrorMessage = "Số điện thoại không hợp lệ.")]
        [DisplayName("Điện thoại cơ quan")]
        public string DienThoai{ get; set; }

        [RegularExpression(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", ErrorMessage = "Địa chỉ mail không hợp lệ.")]
        [DisplayName("Địa chỉ Email")]
        public string Email { get; set; }
        
        [DisplayName("Số Fax")]
        public string Fax { get; set; }
        
        [DisplayName("Số tài khoản")]
        public string SoTaiKhoan { get; set; }
        
        [DisplayName("Tổng số cán bộ")]
        public int TongSoCanBo { get; set; }
        
        [DisplayName("Tệp đính kèm")]
        public string TepDinhKem { get; set; }
         
        [DisplayName("Mã tổ chức")]
        public int MaToChuc { get; set; }
        
        [DisplayName("Mã loại hình tổ chức")]
        public int MaLoaiHinhToChuc { get; set; }

        public ToChuc toChuc { get; set; }

        [DisplayName("Danh sách loại hình")]
        
        public IList<LoaiHinhToChuc> loaiHinh { get; set; }
        
        public IList<NangLucKeKhai> nangLuc { get; set; }

        public string HangDoanhNghiep { get; set; }

        [RegularExpression(@"^([0-9]*|\d*\.\d{1}?\d*)$", ErrorMessage="Chỉ điền số")]
        public decimal VonPhapDinh { get; set; }

        [RegularExpression(@"^([0-9]*|\d*\.\d{1}?\d*)$", ErrorMessage = "Chỉ điền số")]
        public decimal VonLuuDong { get; set; }

        public string Camket { get; set; }

        public string LyDo { get; set; }

        
        public IList<NangLucVM> NangLucs { get; set; }

        public IList<NhanLucVM> NhanLucs { get; set; }

        public IList<ThietBiVM> ThietBis { get; set; }

        // Danh sach cac hoat dong duoc lua chon
        public IList<int> DSHoatDongSelecteds { get; set; }
       
        // Danh sach day du cac hoat dong
        public IList<HoatDong> DSHoatDongs { get; set; }

        // Lan 1
        public IEnumerable<NangLucVM> NangLucRow{get; set;}
        public IEnumerable<NhanLucVM> NhanLucRow { get; set; }
        public IEnumerable<ThietBiVM> ThietBiRow { get; set; }

    }

    public class NangLucVM {
        [Required(ErrorMessage="Ngành nghề không được để trống")]
        public string NganhNghe { get; set; }
        public int? Daihoc { get; set; }
        public int? TrungCap { get; set; }
        public int? CongNhan { get; set; }
        public int? LoaiKhac { get; set; }
    }

    public class NhanLucVM
    {
        [Required(ErrorMessage = "Họ Tên không được để trống")]
        public string HoTen { get; set; }
        public string ChucVu { get; set; }
        public string TrinhDoHocVan { get; set; }
        public string ThamNien { get; set; }
    }

    public class ThietBiVM {
        [Required(ErrorMessage = "Tên thiết bị không được để trống")]
        public string TenThietBi_CongNghe { get; set; }
        public int? SoLuong { get; set; }
        public string TinhTrang { get; set; }
        public string GhiChu { get; set; }
    }
}
