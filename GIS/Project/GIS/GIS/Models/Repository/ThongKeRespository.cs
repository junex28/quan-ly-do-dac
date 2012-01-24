using System;
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

namespace GIS.Models.Repository
{
    public class ThongKeRespository : IThongKeRepository
    {
        DDBDDataContext db = new DDBDDataContext();
        public int[] GetSoLieu(string nam)
        {
            int sogpMoi_1 = (from hs in db.HoSoGiayPheps
                             where hs.TinhTrangGiayPhep.MaTinhTrang == 5 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                   && hs.ThongTinChung.MaLoaiHinhToChuc == 1
                             select hs).Count();
            int sogpGiaHan_1 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 11 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 1
                                select hs).Count();
            int sogpBoSung_1 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 8 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 1
                                select hs).Count();

            int sogpMoi_2 = (from hs in db.HoSoGiayPheps
                             where hs.TinhTrangGiayPhep.MaTinhTrang == 5 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                   && hs.ThongTinChung.MaLoaiHinhToChuc == 2
                             select hs).Count();
            int sogpGiaHan_2 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 11 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 2
                                select hs).Count();
            int sogpBoSung_2 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 8 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 2
                                select hs).Count();

            int sogpMoi_3 = (from hs in db.HoSoGiayPheps
                             where hs.TinhTrangGiayPhep.MaTinhTrang == 5 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                   && hs.ThongTinChung.MaLoaiHinhToChuc == 3
                             select hs).Count();
            int sogpGiaHan_3 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 11 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 3
                                select hs).Count();
            int sogpBoSung_3 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 8 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 3
                                select hs).Count();

            int sogpMoi_4 = (from hs in db.HoSoGiayPheps
                             where hs.TinhTrangGiayPhep.MaTinhTrang == 5 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                   && hs.ThongTinChung.MaLoaiHinhToChuc == 4
                             select hs).Count();
            int sogpGiaHan_4 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 11 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 4
                                select hs).Count();
            int sogpBoSung_4 = (from hs in db.HoSoGiayPheps
                                where hs.TinhTrangGiayPhep.MaTinhTrang == 8 && hs.NgayCapPhep.Value.Year.ToString() == nam
                                      && hs.ThongTinChung.MaLoaiHinhToChuc == 4
                                select hs).Count();

            //int tong_ = sogpBoSung_4 + sogpGiaHan_4 + sogpMoi_4;
            //int tong_4 = sogpBoSung_4 + sogpGiaHan_4 + sogpMoi_4;
            //int tong_4 = sogpBoSung_4 + sogpGiaHan_4 + sogpMoi_4;

            int[] arrSoLieu = new int[12];
            arrSoLieu[0] = sogpMoi_1;
            arrSoLieu[1] = sogpGiaHan_1;
            arrSoLieu[2] = sogpBoSung_1;

            arrSoLieu[3] = sogpMoi_2;
            arrSoLieu[4] = sogpGiaHan_2;
            arrSoLieu[5] = sogpBoSung_2;

            arrSoLieu[6] = sogpMoi_3;
            arrSoLieu[7] = sogpGiaHan_3;
            arrSoLieu[8] = sogpBoSung_3;

            arrSoLieu[9] = sogpMoi_4;
            arrSoLieu[10] = sogpGiaHan_4;
            arrSoLieu[11] = sogpBoSung_4;

            return arrSoLieu;
        }

    }
}
