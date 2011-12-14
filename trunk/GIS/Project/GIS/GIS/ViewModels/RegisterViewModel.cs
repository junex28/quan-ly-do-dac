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
    //[PropertiesMustMatch("Password", "ConfirmPassword", ErrorMessage = "The password and confirmation password do not match.")]
    public class RegisterViewModel
    {

        [Required(ErrorMessage = "Tên tài khoản không được trống")]
        [DisplayName("Tên tài khoản")]
        public string TenTaiKhoan { get; set; }

        [Required(ErrorMessage = "Địa chỉ email không được trống")]
        [RegularExpression(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", ErrorMessage = "Địa chỉ mail không hợp lệ.")]
        [DisplayName("Địa chỉ Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Mật khẩu không được trống")]
        //[ValidatePasswordLength]
        [DataType(DataType.Password)]
        [DisplayName("Mật khẩu")]
        public string MatKhau { get; set; }

        [Required(ErrorMessage = "Nhập lại mật khẩu không được trống")]
        [DataType(DataType.Password)]
        [DisplayName("Nhập lại mật khẩu")]
        public string NhapLaiMatKhau { get; set; }

        [Required(ErrorMessage = "Họ và tên không được trống")]
        [DisplayName("Họ và tên")]
        public string HoTen { get; set; }
        // Chuoi so
        [DisplayName("CMND")]
        public string CMND { get; set; }

        [DisplayName("Địa chỉ")]
        public string DiaChi { get; set; }
        [DisplayName("Cơ quan")]
        public string Coquan { get; set; }
        [Required(ErrorMessage = "Captcha không được trống")]
        public string Captcha { get; set; }
    }

    #region Validation
    public static class AccountValidation
    {
        public static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Tài khoản đã tồn tại. Xin vui lòng tạo một tài khoản mới";

                case MembershipCreateStatus.DuplicateEmail:
                    return "Địa chỉ email này đã được sử dụng. Xin vui lòng nhập địa chỉ email mới.";

                case MembershipCreateStatus.InvalidPassword:
                    return "Mật khẩu nhập không hợp lệ. ";

                case MembershipCreateStatus.InvalidEmail:
                    return "Địa chỉ email không hợp lệ";

                case MembershipCreateStatus.InvalidAnswer:
                    return "Câu trả lời không hợp lệ";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "Tài khoản không hợp lệ.";

                case MembershipCreateStatus.ProviderError:
                    return "Đăng ký / Đăng nhập xuất hiện lỗi. Xin vui lòng thông báo ban quản trị để sửa lỗi này";

                case MembershipCreateStatus.UserRejected:
                    return "Người dùng đã thoát";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
   
        //Ten tai khoan
        //    Mat khau
        //        Ghi nho
    }
    #endregion
}
