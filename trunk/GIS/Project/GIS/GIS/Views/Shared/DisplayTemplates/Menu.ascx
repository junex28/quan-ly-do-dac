<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MvcSiteMapProvider.Web.Html.Models.SiteMapNodeModelList>" %>
<%
    Writer.Write("<ul>");
    foreach (var node in Model)
    {
        Writer.Write("<li>");
        if (node.IsInCurrentPath)
        {
            Writer.Write(Html.ActionLink(node.Title, node.Action, node.Controller, null, new { @class = "selected" }));
        }
        else
        {
            Writer.Write(Html.ActionLink(node.Title, node.Action, node.Controller));
        }
        if (node.Children.Any())
        {
            Writer.Write(Html.DisplayFor(m => node.Children, "Menu"));
        }
        Writer.Write("</li>");
    }
    Writer.Write("</ul>");
%>