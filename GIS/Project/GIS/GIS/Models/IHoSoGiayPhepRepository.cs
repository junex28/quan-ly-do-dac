﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IHoSoGiayPhepRepository
    {
        IQueryable<HoSoGiayPhep> GetHoSoGiayPheps(string strSearch);
        IQueryable<HoSoGiayPhep> GetGPHDByTinhTrang(int Id, string strSearch);
        HoSoGiayPhep GetHoSoGiayPhepByID(int id);
        IList<HoSoGiayPhep> GetHSGPByToChuc(int tcId);
        List<HoSoGiayPhep> GetHSListByTCID(int tcId);
        //HoSoGiayPhep GetHoSoGiayPhepByID(int id);
        HoSoGiayPhep GetHSGPByToChucId(int tcId);
        HoSoGiayPhep GetHSListBySoGP(string sogp);
        int Check(int tcId);
        int Check(IList<HoSoGiayPhep> list);
        void Add(HoSoGiayPhep HoSoGiayPhep);
        void Delete(HoSoGiayPhep HoSoGiayPhep);
        void Update(HoSoGiayPhep HoSoGiayPhep);
        void Save();
    }
}
