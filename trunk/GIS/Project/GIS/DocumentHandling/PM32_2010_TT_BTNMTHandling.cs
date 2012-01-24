using System;
using System.Text;
using System.Collections;
using System.Collections.Generic;

namespace DocumentHandling
{
    public class PM32_2010_TT_BTNMTHandling : DocumentHandling
    {
        static public string DIADIEMTOP = "DiaDiemTop";
        static public string NGAYTOP = "NgayTop";
        static public string THANGTOP = "ThangTop";
        static public string NAMTOP = "NamTop";

        static public string DIADIEM = "DiaDiem";
        static public string NGAY = "Ngay";
        static public string THANG = "Thang";
        static public string NAM = "Nam";

        static public string TENTOCHUC = "TenToChuc";
        static public string TPCOQUANTHAMDINH = "TPCoQuanThamDinh";
        static public string TPTOCHUC = "TPToChuc";
        public void settingInfo(string diaDiem, DateTime ngayKy, string tenToChuc, List<string> tpCoQuanThamDinh, List<string> tpToChuc)
        {
            Parameters = new Hashtable();
            Parameters[DIADIEMTOP] = diaDiem;
            Parameters[NGAYTOP] = ngayKy.Day.ToString();
            Parameters[THANGTOP] = ngayKy.Month.ToString();
            Parameters[NAMTOP] = ngayKy.Year.ToString();

            Parameters[DIADIEM] = diaDiem;
            Parameters[NGAY] = ngayKy.Day.ToString();
            Parameters[THANG] = ngayKy.Month.ToString();
            Parameters[NAM] = ngayKy.Year.ToString();

            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < tpCoQuanThamDinh.Count; i++)
            {
                builder.Append((i + 1) + ". " + tpCoQuanThamDinh[i]);
                if (i != tpCoQuanThamDinh.Count - 1)
                {
                    builder.Append(System.Environment.NewLine);
                }
            }
            Parameters[TPCOQUANTHAMDINH] = builder.ToString();

            builder = new StringBuilder();
            for (int i = 0; i < tpToChuc.Count; i++)
            {
                builder.Append((i + 1) + ". " + tpCoQuanThamDinh[i]);
                if (i != tpToChuc.Count - 1)
                {
                    builder.Append(System.Environment.NewLine);
                }
            }
            Parameters[TPTOCHUC] = builder.ToString();
        }
    }
}
