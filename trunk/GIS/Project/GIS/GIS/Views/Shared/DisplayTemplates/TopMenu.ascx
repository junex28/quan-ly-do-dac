<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MvcSiteMapProvider.Web.Html.Models.MenuHelperModel>" %>

<ul class="topMenu">
<% foreach (var node in Model.Nodes) { %>
    <li><%=Html.ActionLink(node.Title, node.Action, node.Controller) %>
    <% if (node.Children.Any()) { %>
        <%= Html.DisplayFor(m => node.Children) %>
    <% } %>
    </li>
<% } %>
</ul>