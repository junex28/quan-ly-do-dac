<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="GIS.Models" %>
<%@ Import Namespace="GIS.Helpers" %>
<%
    MessageModel model = null;
    if (Request.Cookies["SystemMessage"] != null)
    {
        model = SerializationHelper.DeSerialize<MessageModel>(Request.Cookies["SystemMessage"].Value) as MessageModel;
    }
    if (model != null && model.Messages.Count() > 0)
    {
        MessageHelper.RemoveMessage(Response);
        
        string @class = string.Empty;
        string alert = string.Empty;
        switch (model.Type)
        {
            case MessageType.Error: 
                @class = "error";
                alert = "Error";
                break;
            case MessageType.Warning:
                @class = "warning";
                alert = "Warning";
                break;
            case MessageType.Highlight:
                @class = "message";
                alert = "Messsage";
                break;
        };
        
        %>
        <dl id="system-message">
            <dt><%= alert %></dt>
            <dd class="<%= @class %>">
                <ul>
                <%
                    foreach (string message in model.Messages)
                    {
                        %>
                        <li><%= message %></li>
                        <%
                    }
                %>
                </ul>
            </dd>
        </dl>        
        <%
    }
%>

    


