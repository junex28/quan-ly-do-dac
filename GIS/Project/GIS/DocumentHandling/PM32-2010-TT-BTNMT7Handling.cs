using System.Collections.Generic;

namespace DocumentHandling
{
    public class PM32_2010_TT_BTNMT7Handling : DocumentHandling
    {
        public const string COQUANCHUQUAN = "CoQuanChuQuan";
        public const string TOCHUCDUOCCAPGIAYPHEP = "ToChucDuocCapGiayPhep";

        public const string DIADIEM = "DiaDiem";
        public const string NGAY = "Ngay";
        public const string THANG = "Thang";
        public const string NAM = "Nam";

        public const string TUNAM = "TuNam";
        public const string DENNAM = "DenNam";

        public const string TENTOCHUC = "TenToChuc";
        public const string GIAYPHEPHOATDONGSO = "GiayPhepHoatDongSo";
        public const string GIAYPHEPHOATDONGCAPNGAY = "GiayPhepHoatDongCapNgay";
        public const string DOANHTHUNAM = "DoanhThuNam";
        public const string NOPNGANSACHNAM = "NopNganSachNam";

        public const string CONGTRINHDODACBANDO = "CongTrinhDoDacBanDo";

        public PM32_2010_TT_BTNMT7Handling() : base() {
            Parameters[COQUANCHUQUAN] = BookmarkReplacedFactory.getInLineValue(DEFAULT_BLANK);
            Parameters[TOCHUCDUOCCAPGIAYPHEP] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            Parameters[DIADIEM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NGAY] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[THANG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            Parameters[TUNAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[DENNAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            Parameters[TENTOCHUC] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[GIAYPHEPHOATDONGSO] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[GIAYPHEPHOATDONGCAPNGAY] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[DOANHTHUNAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NOPNGANSACHNAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);

            Parameters[CONGTRINHDODACBANDO] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
        }

        public override void SettingParam(string name, object value) {
            switch (name) {
                case COQUANCHUQUAN:
                case TOCHUCDUOCCAPGIAYPHEP:
                case DIADIEM:
                case NGAY:
                case THANG:
                case NAM:
                case TUNAM:
                case DENNAM:
                case TENTOCHUC:
                case GIAYPHEPHOATDONGSO:
                case GIAYPHEPHOATDONGCAPNGAY:
                case DOANHTHUNAM:
                case NOPNGANSACHNAM:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
                case CONGTRINHDODACBANDO:
                    Parameters[name] = BookmarkReplacedFactory.getTableValue((List<List<string>>)value);
                    break;
                default:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
            }
        }
    }
}