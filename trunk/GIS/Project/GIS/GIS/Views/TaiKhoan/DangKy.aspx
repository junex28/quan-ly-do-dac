<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.RegisterViewModel>" %>
<%@ Import Namespace="GIS.Helpers" %>
<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>
<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Đăng ký tài khoản mới</h2>
    <% using (Html.BeginForm())
       { %>
    <%= Html.ValidationSummary(true, "Tài khoản tạo thất bại. Xin vui lòng sửa lỗi và nhập lại.") %>
    <div>
        <fieldset>
            <legend>Đăng ký tài khoản</legend>
             <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.TenTaiKhoan) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.TenTaiKhoan) %>
                    <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.Email) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.Email) %>
                    <%= Html.ValidationMessageFor(m => m.Email) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.MatKhau) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.MatKhau) %>
                    <%= Html.ValidationMessageFor(m => m.MatKhau) %>
                </div>
            </div>

            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.NhapLaiMatKhau) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.NhapLaiMatKhau) %>
                    <%= Html.ValidationMessageFor(m => m.NhapLaiMatKhau) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.HoTen) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.HoTen)%>
                    <%= Html.ValidationMessageFor(m => m.HoTen) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.DiaChi) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.DiaChi)%>
                    <%= Html.ValidationMessageFor(m => m.DiaChi) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.CMND) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.CMND)%>
                    <%= Html.ValidationMessageFor(m => m.CMND) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.Coquan) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.Coquan)%>
                    <%= Html.ValidationMessageFor(m => m.Coquan) %>
                </div>
            </div>
            <div class="editor-row">
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.Captcha) %>
                </div>
                <div class="editor-field">
                      <%= Html.Captcha("myCaptcha") %>
                    <div>Nhập ký tự ở trên : <%= Html.TextBoxFor(m => m.Captcha) %></div>
                    <%= Html.ValidationMessageFor( m => m.Captcha  ) %>
                </div>
            </div>
            <p>
                <input type="submit" value="Đăng ký" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>
