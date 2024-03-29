﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IThietBiRepository
    {
        IQueryable<ThietBi> GetThietBis();
        IPagedList<ThietBi> GetThietBiByTTCID(int ttcid, int pageNo);
        List<ThietBi> GetThietBiByTTC(int ttcid);
        List<ThietBi> GetThietBiByTCID(int tcid);
        void Add(ThietBi ThietBi);
        void Delete(ThietBi ThietBi);
        void Save();
    }
}
