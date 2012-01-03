using System;
using System.Web;

namespace GIS.Models
{
    public interface IFileStore
    {
        Guid SaveUploadedFile(HttpPostedFileBase fileBase);
    }
}