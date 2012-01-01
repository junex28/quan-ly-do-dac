using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;
using GIS.ViewModels;
using System.Linq.Dynamic;
using System.ComponentModel;
using GIS.Models.Repository;

namespace GIS.Models.Repository
{
    public class ThamDinhRespository: IThamDinhRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<ThamDinh> GetThamDinhs()
        {
            return db.ThamDinhs.AsQueryable();
        }

        public ThamDinh GetThamDinhByID(int id)
        {
            return db.ThamDinhs.Single(d => d.MaGiayPhepHoatDong == id);
        }

        public void Add(ThamDinh thamdinh)
        {
            db.ThamDinhs.InsertOnSubmit(thamdinh);
        }

        public void Delete(ThamDinh thamdinh)
        {
            db.ThamDinhs.DeleteOnSubmit(thamdinh);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
