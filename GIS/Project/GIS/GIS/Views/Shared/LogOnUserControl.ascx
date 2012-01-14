<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LogOnViewModel>" %>
<%@ Import Namespace="GIS.Models" %>
<%@ Import Namespace="GIS.ViewModels" %>
<% if (Request.IsAuthenticated) { %>
    Chào <b><%=  Html.Encode(((EnhancedPrincipal)Page.User).Data.HoTen) %></b>! |
    <%= Html.ActionLink("Đăng xuất", "DangXuat", "TaiKhoan",null, new { onclick = "DangXuatConfirm()" })%>
<% } else { %> 
    <%= Html.ActionLink("Đăng nhập", "DangNhap", "TaiKhoan") %> |
    <%= Html.ActionLink("Đăng ký", "DangKy", "TaiKhoan")%>

     <div class="block login">
            <% using (Html.BeginForm()) { %>  
        <fieldset>
                    Tài khoản
                   <%= Html.TextBoxFor(m => m.TenTaiKhoan)%>
                   <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                    </p>
                    <p>
                    <label class="grid_4" style="text-align:left">Mật khẩu: </label>
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
        
 <%} %>
 </div>
<% } %>


<script type="text/javascript">
   function DangXuatConfirm(){
            if(!confirm("Bạn có muốn thoát khỏi website không ? "))
            return false; // to cancel the default action of the link
            else
            return true; 
             
    }
</script>
