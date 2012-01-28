using System;
using System.Web;
using GIS.Models;
using System.IO;
using System.Web.Hosting;

namespace GIS.Models
{
    internal class DiskFileStore : IFileStore
    {
        private string _uploadsFolder = HostingEnvironment.MapPath("~/App_Data/Upload/tmp");
        
        public DiskFileStore() { 
        }

        public DiskFileStore(string location)
        {
            _uploadsFolder = HostingEnvironment.MapPath(location);
        }

        //public Guid SaveUploadedFile(HttpPostedFileBase fileBase)
        //{
        //    var identifier = Guid.NewGuid();
        //    string extension = Path.GetExtension(fileBase.FileName);
             
        //    fileBase.SaveAs(GetDiskLocation(identifier) + extension);
        //    return identifier;
        //}

        public string SaveUploadedFile(HttpPostedFileBase fileBase)
        {
            var identifier = Guid.NewGuid();
            string extension = Path.GetExtension(fileBase.FileName);

            fileBase.SaveAs(GetDiskLocation(identifier) + extension);
            string f = identifier.ToString() + extension;
            return f;
        }
        
        
        private string GetDiskLocation(Guid identifier)
        {
            return Path.Combine(_uploadsFolder, identifier.ToString());
        }
    }
}