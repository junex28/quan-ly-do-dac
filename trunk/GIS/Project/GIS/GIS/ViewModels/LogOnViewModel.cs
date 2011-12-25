using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
namespace GIS.ViewModels
{
    public class LogOnViewModel
    {
        [Required(ErrorMessage = "Tên tài khoản không được trống")]
        [DisplayName("Tên tài khoản")]
        public string TenTaiKhoan { get; set; }

        [Required(ErrorMessage = "Mật khẩu không được trống")]
        //[ValidatePasswordLength]
        [DataType(DataType.Password)]
        [DisplayName("Mật khẩu")]
        public string MatKhau { get; set; }

        [DisplayName("Ghi Nhớ")]
        public bool GhiNho { get; set; }
    }
}
