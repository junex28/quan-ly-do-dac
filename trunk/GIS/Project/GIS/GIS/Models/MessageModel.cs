using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public enum MessageType
    {
        Highlight,
        Warning,
        Error
    }

    [Serializable]
    public class MessageModel
    {
        public MessageType Type { get; set; }
        public string Title { get; set; }
        public List<string> Messages { get; set; }

        public MessageModel()
        {
            Type = MessageType.Highlight;
            Messages = new List<string>();
        }

        public MessageModel(MessageModel model)
        {
            Type = model.Type;
            Title = model.Title;
            Messages = model.Messages;
        }

        public MessageModel(MessageType type, String title, List<string> messages)
        {
            Type = type;
            Title = title;
            Messages = messages;
        }

        public void AddMessage(String message)
        {
            Messages.Add(message);
        }
    }
}
