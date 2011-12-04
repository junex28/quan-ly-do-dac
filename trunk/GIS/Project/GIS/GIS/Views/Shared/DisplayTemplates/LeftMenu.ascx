<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MvcSiteMapProvider.Web.Html.Models.MenuHelperModel>" %>

<%
    foreach (var node in Model) {
        if (node.IsInCurrentPath && !node.IsRootNode)
        {
            Writer.Write("<ul class='leftMenu'>");
            foreach (var child in node.Children)
            {
                string cssClass;
                if (child.IsCurrentNode)
                {
                    cssClass = "button selected";
                }
                else
                {
                    cssClass = "button";
                }
                Writer.Write("<li>");
                Writer.Write(Html.ActionLink(child.Title, child.Action, child.Controller, null, new { @class = cssClass }));
                Writer.Write("</li>");
            }
            Writer.Write("</ul>");
            break;
        }
    }
%>