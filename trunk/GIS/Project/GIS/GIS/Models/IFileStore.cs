using System;
using System.Web;

namespace GIS.Models
{
    public interface IFileStore
    {
        string SaveUploadedFile(HttpPostedFileBase fileBase);
    }
}