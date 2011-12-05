using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class ToChucRepository : IToChucRepository,IDisposable
    {
        private DDBDDataContext context;
        
        public ToChucRepository(DDBDDataContext context)
        {
            this.context = context;
        }

        public IEnumerable<ToChuc> GetToChucs()
        {
            var tochucs = from m in context.ToChucs
                         select m;

            return tochucs.ToList();
        }

        public ToChuc GetToChucByID(int id)
        {
            ToChuc tochuc = context.ToChucs.Single(m => m.MATOCHUC == id);
            return tochuc;
        }

        public void InsertToChuc(ToChuc tochuc)
        {
            context.ToChucs.InsertOnSubmit(tochuc);
        }

        public void DeleteToChuc(int tochucID)
        {
            ToChuc tochuc = context.ToChucs.Single(m => m.MATOCHUC == tochucID);
            context.ToChucs.DeleteOnSubmit(tochuc);
        }

        public void DeleteToChuc(ToChuc tochuc) {
            context.ToChucs.DeleteOnSubmit(tochuc);
        }

        public void SubmitChanges()
        {
            context.SubmitChanges();
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

    }
}
