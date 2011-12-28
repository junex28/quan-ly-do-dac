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
    [Serializable]
    [PropertiesMustMatch("MatKhau", "NhapLaiMatKhau", ErrorMessage = "Mật khẩu nhập lại không khớp.")]
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
        [ValidatePasswordLength]
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
    
    [AttributeUsage(AttributeTargets.Class, AllowMultiple =true , Inherited = true)]
    public sealed class PropertiesMustMatchAttribute : ValidationAttribute {
        private const string _defaultErrorMessage = "'{0}' and '{1}' do not match.";
        private readonly object _typeId = new object();

        public PropertiesMustMatchAttribute(string originalProperty, string confirmProperty)
            : base(_defaultErrorMessage)
        {
            OriginalProperty = originalProperty;
            ConfirmProperty = confirmProperty;
        }

        public string ConfirmProperty { get; private set; }
        public string OriginalProperty { get; private set; }

        public override object TypeId
        {
            get
            {
                return _typeId;
            }
        }

        public override string FormatErrorMessage(string name)
        {
            return String.Format(CultureInfo.CurrentUICulture, ErrorMessageString,
                OriginalProperty, ConfirmProperty);
        }

        public override bool IsValid(object value)
        {
            PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(value);
            object originalValue = properties.Find(OriginalProperty, true /* ignoreCase */).GetValue(value);
            object confirmValue = properties.Find(ConfirmProperty, true /* ignoreCase */).GetValue(value);
            return Object.Equals(originalValue, confirmValue);
        }

        
    }

    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false, Inherited = true)]
    public sealed class ValidatePasswordLengthAttribute : ValidationAttribute
    {
        private const string _defaultErrorMessage = "'{0}' must be at least {1} characters long.";
        private readonly int _minCharacters = 6;        // Should get by Membership Provider

        public ValidatePasswordLengthAttribute()
            : base(_defaultErrorMessage)
        {
        }

        public override string FormatErrorMessage(string name)
        {
            return String.Format(CultureInfo.CurrentUICulture, ErrorMessageString,
                name, _minCharacters);
        }

        public override bool IsValid(object value)
        {
            string valueAsString = value as string;
            return (valueAsString != null && valueAsString.Length >= _minCharacters);
        }
    }
    #endregion
}
