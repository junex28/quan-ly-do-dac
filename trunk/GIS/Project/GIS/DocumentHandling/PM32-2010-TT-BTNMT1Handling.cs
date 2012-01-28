using System.Collections.Generic;

namespace DocumentHandling
{
    public class PM32_2010_TT_BTNMT1Handling : DocumentHandling
    {
        public const string TOCHUCCANHAN = "ToChucCaNhan";
        public const string GPDKKD = "GPDKKD";
        public const string HANGDOANHNGHIEP = "HangDoanhNghiep";
        public const string VONPHAPDINH = "VonPhapDinh";
        public const string VONLUUDONG = "VonLuuDong";
        public const string SOTAIKHOAN = "SoTaiKhoan";
        public const string SONHANVIEN = "SoNhanVien";
        public const string TRUSOCHINH = "TruSoChinh";
        public const string DIENTHOAI = "DienThoai";
        public const string FAX = "Fax";
        public const string EMAIL = "Email";
        
        public const string LUCLUONGKYTHUATNGANHNGHE = "LucLuongKyThuatNganhNghe";
        public const string LUCLUONGKYTHUATNGUOICHIUTRACHNHIEM = "LucLuongKyThuatNguoiChiuTrachNhiem";
        public const string THIETBICONGNGHE = "ThietBiCongNghe";
        public const string NOIDUNGHOATDONG = "NoiDungHoatDong";

        public const string BANDANGKYSO = "BanDangKySo";
        public const string NGAY = "Ngay";
        public const string THANG = "Thang";
        public const string NAM = "Nam";

        public const string BOSUNG1 = "BoSung1";
        public const string BOSUNG2 = "BoSung2";
        public const string BOSUNG3 = "BoSung3";

        public PM32_2010_TT_BTNMT1Handling() : base() {
            Parameters[TOCHUCCANHAN] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[GPDKKD] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[HANGDOANHNGHIEP] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[VONPHAPDINH] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[VONLUUDONG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[SOTAIKHOAN] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[SONHANVIEN] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[TRUSOCHINH] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[DIENTHOAI] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[FAX] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[EMAIL] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            Parameters[LUCLUONGKYTHUATNGANHNGHE] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[LUCLUONGKYTHUATNGUOICHIUTRACHNHIEM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[THIETBICONGNGHE] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NOIDUNGHOATDONG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            Parameters[BANDANGKYSO] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NGAY] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[THANG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            string line = ".....................................";
            string defaultLine = line + System.Environment.NewLine + line + System.Environment.NewLine + line + System.Environment.NewLine + line;
            Parameters[BOSUNG1] = BookmarkReplacedFactory.getInLineValue(defaultLine);
            Parameters[BOSUNG2] = BookmarkReplacedFactory.getInLineValue(defaultLine);
            Parameters[BOSUNG3] = BookmarkReplacedFactory.getInLineValue(defaultLine);
        }

        public override void SettingParam(string name, object value) {
            switch (name) {
                case TOCHUCCANHAN:
                case GPDKKD:
                case HANGDOANHNGHIEP:
                case VONPHAPDINH:
                case VONLUUDONG:
                case SOTAIKHOAN:
                case SONHANVIEN:
                case TRUSOCHINH:
                case DIENTHOAI:
                case FAX:
                case EMAIL:
                case BANDANGKYSO:
                case NGAY:
                case THANG:
                case NAM:
                case BOSUNG1:
                case BOSUNG2:
                case BOSUNG3:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue((string)value);
                    break;
                case LUCLUONGKYTHUATNGANHNGHE:
                case LUCLUONGKYTHUATNGUOICHIUTRACHNHIEM:
                case THIETBICONGNGHE:
                case NOIDUNGHOATDONG:
                    Parameters[name] = BookmarkReplacedFactory.getTableValue((List<List<string>>)value);
                    break;
                default:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
            }
        }
    }
}