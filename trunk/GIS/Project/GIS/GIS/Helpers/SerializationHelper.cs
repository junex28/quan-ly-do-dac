using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.Xml;
using System.IO;
using System.Text;
using System.Runtime.Serialization.Formatters.Binary;

namespace GIS.Helpers
{
    public class SerializationHelper
    {
        static public string Serialization<T>(T obj)
        {
            BinaryFormatter formatter = new BinaryFormatter();
            MemoryStream stream = new MemoryStream();
            formatter.Serialize(stream, obj);
            stream.Flush();
            stream.Position = 0;
            return Convert.ToBase64String(stream.ToArray());
        }

        static public T DeSerialize<T>(string objectString)
        {
            byte[] b = Convert.FromBase64String(objectString);
            BinaryFormatter formatter = new BinaryFormatter();
            MemoryStream stream = new MemoryStream(b);
            stream.Seek(0, SeekOrigin.Begin);
            return (T)formatter.Deserialize(stream);
        }
    }
}
