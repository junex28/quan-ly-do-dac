<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	NotAllowed
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Truy cập không hợp lệ</h2>
    <br/>
    Bạn không có quyền truy cập vào trang này. <br />
    Xin vui lòng nhấn vào <%= Html.ActionLink("đây", "Index", "TrangChu")%> để về lại Trang Chủ.  

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
  
</asp:Content>

