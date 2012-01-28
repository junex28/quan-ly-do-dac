using System.Collections.Generic;

namespace DocumentHandling
{
    public class PM32_2010_TT_BTNMT6Handling : DocumentHandling
    {
        public const string DIADIEM = "DiaDiem";
        public const string NGAY = "Ngay";
        public const string THANG = "Thang";
        public const string NAM = "Nam";

        public const string TINHHINHGIAYPHEPHOATDONG = "TinhHinhGiayPhepHoatDong";

        public PM32_2010_TT_BTNMT6Handling()
            : base()
        {
            Parameters[TINHHINHGIAYPHEPHOATDONG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[DIADIEM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NGAY] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[THANG] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
            Parameters[NAM] = BookmarkReplacedFactory.getInLineValue(DEFAULT_VALUE);
        }

        public override void SettingParam(string name, object value)
        {
            switch (name)
            {
                case DIADIEM:
                case NGAY:
                case THANG:
                case NAM:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
                case TINHHINHGIAYPHEPHOATDONG:
                    Parameters[name] = BookmarkReplacedFactory.getTableValue((List<List<string>>)value);
                    break;
                default:
                    Parameters[name] = BookmarkReplacedFactory.getInLineValue(value.ToString());
                    break;
            }
        }
    }
}