using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GIS.ViewModels
{

    public class TaiKhoanEditViewModel
    {
        [DisplayName("Mã tài khoản")]
        public int MaTaiKhoan { get; set; }

        [Required(ErrorMessage = "Tên tài khoản không được trống")]
        [DisplayName("Tên tài khoản")]
        public string TenTaiKhoan { get; set; }

        [DisplayName("Họ tên")]
        public string HoTen { get; set; }

        [DisplayName("Địa chỉ")]
        public string DiaChi { get; set; }

        [DisplayName("CMND")]
        public string CMND { get; set; }

        [Required(ErrorMessage = "Email không được trống")]
        [RegularExpression(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", ErrorMessage = "Địa chỉ mail không hợp lệ.")]
        [DisplayName("Email")]
        public string Email { get; set; }

        [DisplayName("Cơ quan")]
        public string CoQuan { get; set; }

        [DisplayName("Mật khẩu")]
        public string MatKhau { get; set; }

        [DisplayName("Tình trạng tài khoản")]
        public int MaTinhTrang { get; set; }

        [DisplayName("Nhóm người dùng")]
        public int MaNhom { get; set; }

        public IList<TinhTrangTaiKhoan> tinhtrangTaiKhoan { get; set; }
        public IList<NhomNguoiDung> nhomNguoiDung { get; set; }
    }
}