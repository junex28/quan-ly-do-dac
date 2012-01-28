﻿using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

namespace GIS.Models
{
    public interface INangLucKeKhaiRespository
    {
        IQueryable<NangLucKeKhai> GetNangLucKeKhais();
        IPagedList<NangLucKeKhai> GetNangLucKeKhaiByID(int tcid, int pageNo);
        List<NangLucKeKhai> GetNangLucByTCID(int tcId);
        void Add(NangLucKeKhai NangLucKeKhai);
        void Delete(NangLucKeKhai NangLucKeKhai);
        void Save();
    }
}
