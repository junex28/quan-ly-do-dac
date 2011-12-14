<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MvcSiteMapProvider.Web.Html.Models.MenuHelperModel>" %>

<%
    Writer.Write("<ul class='sf-menu'>");
    foreach (var node in Model)
    {
        Writer.Write("<li>");
        if (node.Controller.Equals("TaiKhoan"))
        {
            continue;
        }
        if (node.IsCurrentNode || (node.IsInCurrentPath && !node.IsRootNode))
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