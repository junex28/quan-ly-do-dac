<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.LogOnViewModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng nhập
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
        <% Html.EnableClientValidation(); %>
    <div class="grid_19 alpha">
        <h3>Đăng nhập</h3>
         <div class="box">
          <p>    
        Nhập Tên Tài Khoản và Mật Khẩu. <%= Html.ActionLink("đăng ký", "dangky") %> nếu bạn chưa có tài khoản.
    </p>
          <div class="block">
            <% using (Html.BeginForm()) { %>  
                <%= Html.ValidationSummary(true, "Tài khoản đăng nhập thất bại.") %>
                <fieldset class="login">
                    <legend>Đăng nhập</legend>
                    <p>
                    <label class="grid_4">Tên tài khoản: </label>
                   <%= Html.TextBoxFor(m => m.TenTaiKhoan, new {@class="text"})%>
                   <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                    </p>
                    <p>
                    <label class="grid_4">Mật khẩu: </label>
                    <%= Html.PasswordFor(m => m.MatKhau,new {@class="text"}) %>
                    <%= Html.ValidationMessageFor(m => m.MatKhau) %>
                    </p>
                    <p>
                    <span style="margin:180px"></span>
                    <%= Html.CheckBoxFor(m => m.GhiNho) %>
                    Ghi nhớ
                    <input type="submit" value="Đăng nhập" style="margin-left:30px" class="button redmond"/>
                    </p>
                </fieldset>
            <% } %>
          </div>
         </div>
  </div>
</asp:Content>
