<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.LogOnViewModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng nhập
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Đăng nhập</h2>
    <p>
        Nhập Tên Tài Khoản và Mật Khẩu. <%= Html.ActionLink("đăng ký", "DangKy") %> nếu bạn chưa có tài khoản.
    </p>

    <% using (Html.BeginForm()) { %>
        <%= Html.ValidationSummary(true, "Đăng nhập thật bại. Xin vui lòng kiểm tra và nhập lại thông tin.") %>
        <div>
            <fieldset>
                <legend>Đăng nhập</legend>
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
                    Mật khẩu
                    <%= Html.LabelFor(m => m.MatKhau) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.MatKhau) %>
                    <%= Html.ValidationMessageFor(m => m.MatKhau) %>
                </div>                
                </div>
                <div class="editor-row">
                <div class="editor-label">
                    <%= Html.CheckBoxFor(m => m.GhiNho) %>
                    <%= Html.LabelFor(m => m.GhiNho) %>
                </div>
                
                <p>
                    <input type="submit" value="Đăng nhập"/>
                </p>
                </div>
            </fieldset>
        </div>
    <% } %>
</asp:Content>
