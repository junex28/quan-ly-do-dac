<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="GIS.Models" %>
<% if (Request.IsAuthenticated) { %>
    Chào <b><%=  Html.Encode(((EnhancedPrincipal)Page.User).Data.HoTen) %></b>! |
    <%= Html.ActionLink("Đăng xuất", "DangXuat", "TaiKhoan",null, new { onclick = "DangXuatConfirm()" })%>
<% } else { %> 
    <%= Html.ActionLink("Đăng nhập", "DangNhap", "TaiKhoan") %> |
    <%= Html.ActionLink("Đăng ký", "DangKy", "TaiKhoan")%>
<% } %>


<script type="text/javascript">
   function DangXuatConfirm(){
            if(!confirm("Bạn có muốn thoát khỏi website không ? "))
            return false; // to cancel the default action of the link
            else
            return true; 
             
    }
</script>
