using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using GIS.Models;

namespace GIS.Models
{
    public class ToChucRepository : IToChucRepository
    {
        DDBDDataContext db = new DDBDDataContext();

        public IQueryable<ToChuc> GetToChucs()
        {
            return db.ToChucs.AsQueryable();
        }

        public ToChuc GetToChucByID(int id)
        {
            return db.ToChucs.SingleOrDefault(d => d.MaToChuc == id);
        }

        public ToChuc GetToChucByTaiKhoan(int tkId)
        {
            return db.ToChucs.SingleOrDefault(d => d.MaTaiKhoan == tkId);
        }

        public void Add(ToChuc tochuc)
        {
            db.ToChucs.InsertOnSubmit(tochuc);
            db.SubmitChanges();
        }

        public void Update(ToChuc tochuc)
        {
            ToChuc tc = this.GetToChucByID(tochuc.MaToChuc);
            tc.HangDoanhNghiep = tochuc.HangDoanhNghiep;
            tc.MaLoaiHinhToChuc = tochuc.MaLoaiHinhToChuc;
            tc.SoTaiKhoan = tochuc.SoTaiKhoan;
            tc.NguoiDaiDien = tochuc.NguoiDaiDien;
            tc.TruSoChinh = tochuc.TruSoChinh;
            tc.VonPhapDinh = tochuc.VonPhapDinh;
            tc.VonLuuDong = tochuc.VonLuuDong;
            tc.DienThoai = tochuc.DienThoai;
            tc.Email = tochuc.Email;
            tc.Fax = tochuc.Fax;
            tc.TongSoCanBo = tochuc.TongSoCanBo;

            db.SubmitChanges();
        }

        public void Delete(ToChuc tochuc)
        {
            db.ToChucs.DeleteOnSubmit(tochuc);
            db.SubmitChanges();
        }

        public void Save()
        {
            db.SubmitChanges();
        }
       
    }
}
