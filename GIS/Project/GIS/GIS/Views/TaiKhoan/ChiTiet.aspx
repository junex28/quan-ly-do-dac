<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.RegisterViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Thông tin tài khoản
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <fieldset class="formVertical">
    <div class="span subHeader"><h3>Thông tin tài khoản </h3></div>
    <div class="span subContent">    
        <table class="zebra">
            <tbody>
            <tr>
                <th>Họ và tên</th>
                <td><%= Html.Encode(Model.HoTen)%></td>            
            </tr>            
         
            <tr>
                <th>Tên tài khoản</th>
                <td><%= Html.Encode(Model.TenTaiKhoan)%></td>
            </tr>
            <tr>
                <th>Địa chỉ email</th>
                <td><%= Html.Encode(Model.Email)%></td>            
            </tr>
            <tr>
                <th>Địa chỉ </th>
                <td><%= Html.Encode(Model.DiaChi)%></td>            
            </tr>
             <tr>
                <th>Tên Cơ quan</th>
                <td><%= Html.Encode(Model.Coquan)%></td>            
            </tr>           
            <tr>
                <th>Số CMND </th>
                <td><%= Html.Encode(Model.CMND)%></td>            
            </tr>
            
            </tbody>
        </table>
    </div>    
    </fieldset>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
      $(function() {
        $("table.zebra tr:even").addClass("alt");
        $("table.zebra tr td:empty").text("[Trống]");        
      });
    </script>
</asp:Content>
