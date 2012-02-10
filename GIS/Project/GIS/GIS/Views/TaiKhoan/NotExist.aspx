<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
 Chưa tồn tại thông tin tổ chức của tài khoản này
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Truy cập không hợp lệ</h2>
    <br/>
    Chưa tồn tại thông tin tổ chức của tài khoản này. <br />
    Xin vui lòng nhấn vào <%= Html.ActionLink("đây", "Index", "TrangChu")%> để về lại Trang Chủ.  

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
  
</asp:Content>

