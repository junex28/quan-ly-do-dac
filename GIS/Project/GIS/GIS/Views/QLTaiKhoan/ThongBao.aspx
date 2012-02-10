<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ThongBao
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Thông báo</h2>

<% string str = Model.ToString();
   string id = ViewData["id"].ToString();
   switch (str)
   {
       case "1": { %>Cập nhật tài khoản thành công <%break; }
       case "2": {%>Có lỗi trong quá trình cập nhật tài khoản.
                    Vui lòng nhấn vào <a href='/CapNhat?id='+ <%=id%>>đây</a> để thử lại<% break; }
   } %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
