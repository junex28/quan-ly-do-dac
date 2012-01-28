using System.Collections.Generic;

namespace DocumentHandling
{
    public class PM32_2010_TT_BTNMT2Handling : DocumentHandling
    {
        public const string DIADIEMTOP = "DiaDiemTop";
        public const string NGAYTOP = "NgayTop";
        public const string THANGTOP = "ThangTop";
        public const string NAMTOP = "NamTop";

        public const string DIADIEM = "DiaDiem";
        public const string NGAY = "Ngay";
        public const string THANG = "Thang";
        public const string NAM = "Nam";

        public const string TENTOCHUC = "TenToChuc";

        public const string TPCOQUANTHAMDINH = "TPCoQuanThamDinh";
        public const string TPTOCHUC = "TPToChuc";

        public const string TINHHOPLEHOSO = "TinhHopLeHoSo";
        public const string KEKHAILUCLUONGKYTHUAT = "KeKhaiLucLuongKyThuat";
        public const string KEKHAITHIETBICONGNGHE = "KeKhaiThietBiCongNghe";

        public const string KETLUAN = "KetLuan";
        public const string KIENNGHI = "KienNghi";

        private const string LIST_STYLE_1 = "ListStyle1";
        private const string LIST_STYLE_2 = "ListStyle2";

        public PM32_2010_TT_BTNMT2Handling()
            : base()
        {
            Parameters[DIADIEMTOP] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NGAYTOP] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[THANGTOP] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NAMTOP] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[DIADIEM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NGAY] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[THANG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[TENTOCHUC] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[TPCOQUANTHAMDINH] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[TPTOCHUC] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[TINHHOPLEHOSO] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[KEKHAILUCLUONGKYTHUAT] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[KEKHAITHIETBICONGNGHE] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[KETLUAN] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[KIENNGHI] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
        }

        public override void SettingParam(string name, object value)
        {
            switch (name)
            {
                case DIADIEMTOP:
                case NGAYTOP:
                case THANGTOP:
                case NAMTOP:
                case DIADIEM:
                case NGAY:
                case THANG:
                case NAM:
                case KEKHAILUCLUONGKYTHUAT:
                case KEKHAITHIETBICONGNGHE:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
                case TPCOQUANTHAMDINH:
                case TPTOCHUC:
                    Parameters[name] = BookmarkReplacedFactory.getListValue(LIST_STYLE_2, 2, (List<string>)value);
                    break;
                case TINHHOPLEHOSO:
                case KETLUAN:
                case KIENNGHI:
                    Parameters[name] = BookmarkReplacedFactory.getListValue(LIST_STYLE_1, 3, (List<string>)value);
                    break;
                default:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
            }
        }
    }
}