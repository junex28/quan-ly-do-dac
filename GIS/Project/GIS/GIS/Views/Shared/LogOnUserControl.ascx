<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% if (Request.IsAuthenticated) { %>
    Chào <b><%= Html.Encode(Page.User.Identity.Name) %></b>! |
    <%= Html.ActionLink("Đăng xuất", "DangXuat", "TaiKhoan")%>
<% } else { %> 
    <%= Html.ActionLink("Đăng nhập", "DangNhap", "TaiKhoan") %> |
    <%= Html.ActionLink("Đăng ký", "DangKy", "TaiKhoan")%>
<% } %>
