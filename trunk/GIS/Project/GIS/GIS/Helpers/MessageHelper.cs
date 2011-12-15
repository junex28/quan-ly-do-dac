using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.Web.Mvc;

namespace GIS.Helpers
{
    public class MessageHelper
    {
        static public void CreateMessage(MessageType messageType, string messageTitle, List<string> messageDetails, HttpResponseBase response)
        {
            MessageModel message = new MessageModel(messageType, messageTitle, messageDetails);
            response.SetCookie(new HttpCookie("SystemMessage", SerializationHelper.Serialization<MessageModel>(message)));
        }

        static public void RemoveMessage(HttpResponseBase response)
        {
            HttpCookie cookie = new HttpCookie("SystemMessage");
            cookie.Expires = DateTime.Now.AddDays(-1);
            response.SetCookie(cookie);
        }

        static public void CreateMessage(MessageType messageType, string messageTitle, List<string> messageDetails, HttpResponse response)
        {
            MessageModel message = new MessageModel(messageType, messageTitle, messageDetails);
            response.SetCookie(new HttpCookie("SystemMessage", SerializationHelper.Serialization<MessageModel>(message)));
        }

        static public void RemoveMessage(HttpResponse response)
        {
            HttpCookie cookie = new HttpCookie("SystemMessage");
            cookie.Expires = DateTime.Now.AddDays(-1);
            response.SetCookie(cookie);
        }
    }
}
