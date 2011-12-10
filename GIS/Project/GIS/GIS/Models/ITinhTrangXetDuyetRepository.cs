using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface ITinhTrangXetDuyetRepository
    {
        IQueryable<TinhTrangXetDuyet> GetTinhTrangXetDuyets();
        TinhTrangXetDuyet GetTinhTrangXetDuyetByID(int id);

        void Add(TinhTrangXetDuyet TinhTrangXetDuyet);
        void Delete(TinhTrangXetDuyet TinhTrangXetDuyet);
        void Save();
    }
}
