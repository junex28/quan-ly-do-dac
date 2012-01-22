using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

namespace GIS.Helpers
{
    public class BinaryContentResult : ActionResult
    {
        public BinaryContentResult(){ }
        public string ContentType { get; set; }
        public string FileName { get; set; }
        public byte[] Content { get; set; }
        public override void ExecuteResult(ControllerContext context)
        {
            context.HttpContext.Response.ClearContent();
            context.HttpContext.Response.ContentType = ContentType;
            context.HttpContext.Response.AddHeader("content-disposition","filename=" + FileName);
            context.HttpContext.Response.BinaryWrite(Content);
            context.HttpContext.Response.End();
        }
    }
}