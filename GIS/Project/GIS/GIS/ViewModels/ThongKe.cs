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

namespace GIS.ViewModels
{
    public class ThongKe
    {
        public String LoaiCapPhep { get; set; }
        public int[] SoLieu { get; set; }
    }
}
