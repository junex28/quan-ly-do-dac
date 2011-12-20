<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.LogOnViewModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng nhập
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Đăng nhập</h2>
    <p>
        Tài khoản hiện tại đang sử dụng. Xin vui lòng  <%= Html.ActionLink("đăng xuất", "DangXuat") %> trước khi đăng nhập lại.
    </p>

</asp:Content>
