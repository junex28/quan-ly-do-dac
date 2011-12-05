using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IToChucRepository : IDisposable
    {
        IEnumerable<ToChuc> GetToChucs();
        ToChuc GetToChucByID(int tochucID);
        void InsertToChuc(ToChuc tochuc);
        void DeleteToChuc(int tochucID);
        void SubmitChanges();

    }
}
