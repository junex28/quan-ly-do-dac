using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.ViewModels
{
    public class ToChucListViewModel
    {
        public int page { get; private set; }

        public ToChucListViewModel(int page) {
            this.page = page;
        }
    }
}
