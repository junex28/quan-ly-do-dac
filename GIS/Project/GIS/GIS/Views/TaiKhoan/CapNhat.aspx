<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.RegisterViewModel>" %>

<%@ Import Namespace="GIS.Helpers" %>
<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Cập nhật tài khoản
</asp:Content>
<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <%= Html.ValidationSummary(true, "Cập nhật Tài Khoản thất bại. Xin vui lòng sửa lỗi và nhập lại.") %>
    <% using (Html.BeginForm("CapNhat","TaiKhoan",FormMethod.Post))
       {  %>
    <div class="grid_19 alpha">
        <h3>
            Cập Nhật Tài Khoản</h3>
        <div class="clear">
        </div>
        <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Điền thông tin</a>
            </h2>
            <div class="block">
                <p>
                    <label class="grid_6">
                        Tên tài khoản
                    </label>
                    <%= Html.TextBoxFor(m => m.TenTaiKhoan, new { disabled = "true", @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                </p>
                                <p>
                    <label class="grid_6">
                        Địa chỉ email
                    </label>
                            <%= Html.TextBoxFor(m => m.Email, new { @class = "text" })%>
                            <%= Html.ValidationMessageFor(m => m.Email) %>
                </p>
                                                <p>
                    <label class="grid_6">
                        Họ và tên
                    </label>
                            <%= Html.TextBoxFor(m => m.HoTen, new { @class = "text" })%>
                            <%= Html.ValidationMessageFor(m => m.HoTen) %>
                </p>
                                                <p>
                    <label class="grid_6">
                        Địa chỉ
                    </label>
                            <%= Html.TextBoxFor(m => m.DiaChi, new { @class = "text" })%>
                            <%= Html.ValidationMessageFor(m => m.DiaChi) %>
                </p>
                                                <p>
                    <label class="grid_6">
                        Số CMND
                    </label>
                       <%= Html.TextBoxFor(m => m.CMND, new { @class = "text" })%>
                            <%= Html.ValidationMessageFor(m => m.CMND) %>
                </p>
                                                <p>
                    <label class="grid_6">
                       Địa chỉ cơ quan
                    </label>
                          <%= Html.TextBoxFor(m => m.Coquan, new { @class = "text" })%>
                            <%= Html.ValidationMessageFor(m => m.Coquan) %>
                </p>
                 <p>
                    <label class="grid_6">
                      Captcha
                    
                    </label>
                     <%= Html.Captcha("myCaptcha") %>
     </p>
                                 <p>
                    <label class="grid_6">
                      Nhập ký tự ở trên
                    </label>
                            <%= Html.TextBoxFor(m => m.Captcha, new { @class = "text" })%>
                            <%= Html.ValidationMessageFor( m => m.Captcha  ) %>
                </p>
                <div class="block prefix_4">
                    <input type="reset" value="Làm mới" class="button redmond" />
                        <input type="submit" value="Lưu lại" class="button redmond" /></div>
            </div>
        </div>

        <% } %>
</asp:Content>
