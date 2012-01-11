<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.RegisterViewModel>" %>
<%@ Import Namespace="GIS.Helpers" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
   Đăng ký tài khoản
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>     
    <div class="grid_19 alpha">
            <div class="box">
        <h3>Đăng ký tài khoản</h3>

        <div class="block">
            <%= Html.ValidationSummary(true, "Tài khoản tạo thất bại. Xin vui lòng sửa lỗi và nhập lại.") %>
            <% using (Html.BeginForm())
            {  %>                     
                    <p>
                    <label class="w150">Tên tài khoản: </label>
                   <%= Html.TextBoxFor(m => m.TenTaiKhoan, new {@class="text"})%>
                   <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                    </p>
                                <p>
                    <label class="w150">Email: </label>
                    <%= Html.TextBoxFor(m => m.Email, new {@class="text"}) %>
                    <%= Html.ValidationMessageFor(m => m.Email) %>
                    </p>
                                <p>
                    <label class="w150">Mật khẩu: </label>
                   <%= Html.PasswordFor(m => m.MatKhau, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.MatKhau) %>
                    </p>
                                <p>
                    <label class="w150">Nhập lại mật khẩu: </label>
                   <%= Html.PasswordFor(m => m.NhapLaiMatKhau, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.NhapLaiMatKhau) %>
                    </p>
                                <p>
                    <label class="w150">Họ và tên: </label>
                    <%= Html.TextBoxFor(m => m.HoTen, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.HoTen) %>
                    </p>
                                                    <p>
                    <label class="w150">Địa chỉ: </label>
                    <%= Html.TextBoxFor(m => m.DiaChi, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.DiaChi) %>
                    </p>
                                                                       <p>
                    <label class="w150">Số CMND: </label>
                     <%= Html.TextBoxFor(m => m.CMND, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.CMND) %>
                    </p>
                                                                       <p>
                    <label class="w150">Tên cơ quan: </label>
                    <%= Html.TextBoxFor(m => m.Coquan, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.Coquan) %>
                    </p>
                                                                       <p>
                    <label class="w150">Captcha: </label>
                      <%= Html.Captcha("myCaptcha") %>
                    </p>
                                                                                           <p>
                    <label class="w150">Nhập ký tự trên: </label>
                      <%= Html.TextBoxFor(m => m.Captcha, new { @class = "text" })%>
                      <%= Html.ValidationMessageFor( m => m.Captcha  ) %>
                    </p>
                    <div class="box">
                           <div class="block prefix_4 grid_8">
                            <input   type="reset"  value="Làm mới" class="button redmond" />                            
                            <input  type="submit" value="Đăng ký" class="button redmond"/>
                            </div>
                    </div>                    
            <% } %>  
        </div>
        </div>
    </div>   
</asp:Content>
