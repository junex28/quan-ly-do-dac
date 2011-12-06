<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Helpers.PaginatedList<GIS.Models.ToChuc>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
      Danh sách tổ chức
    </h2>

    <ul class="tableToChucs">
    
        <% foreach (var tochuc in Model) { %>
        
            <li>     
                <%= Html.ActionLink(tochuc.TENTOCHUC, "Details", new { id=tochuc.MATOCHUC }) %>
            </li>
        
        <% } %>

    </ul>

    <div class="pagination">

        <% if (Model.HasPreviousPage) { %>

            <%= Html.RouteLink("< Lùi", 
                               "DSToChuc", 
                               new { page=(Model.PageIndex-1) }) %>
          
        <% } %>
        
        <% if (Model.HasNextPage) { %>
        
            <%= Html.RouteLink("Tiếp >", 
                               "DSToChuc", 
                               new { page = (Model.PageIndex + 1) })%>
                              
        
        <% } %>    

    </div>

</asp:Content>
