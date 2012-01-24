using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models
{
    public interface IThongKeRepository
    {
        int[] GetSoLieu(string nam);
    }
}
