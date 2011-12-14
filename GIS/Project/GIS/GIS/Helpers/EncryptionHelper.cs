using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;


namespace GIS.Helpers
{
    public class MD5Helper
    {
        /// <summary>
        /// Gets the hash.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <returns></returns>
        public static string GetHash(string data)
        {
            byte[] b = System.Text.Encoding.Default.GetBytes(data);

            return GetHash(b);
        }

        /// <summary>
        /// Gets the hash.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <returns></returns>
        public static string GetHash(byte[] data)
        {
            // This is one implementation of the abstract class MD5.
            MD5 md5 = new MD5CryptoServiceProvider();

            return BitConverter.ToString(md5.ComputeHash(data)).Replace("-", String.Empty);
        }
    }

}
