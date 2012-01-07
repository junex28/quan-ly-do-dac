﻿using System;
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
        
        [DisplayName("Kích hoạt")]
        public string KichHoat { get; set; }
        
        [DisplayName("Ngày xin phép")]
        public DateTime NgayXinPhep { get; set; }
        
        [DisplayName("Mã tổ chức")]
        public int MaToChuc { get; set; }
        
        [DisplayName("Mã loại hình tổ chức")]
        public int MaLoaiHinhToChuc { get; set; }

        public ToChuc toChuc { get; set; }
        [DisplayName("Danh sách loại hình")]
        public IList<LoaiHinhToChuc> loaiHinh { get; set; }
     }
}