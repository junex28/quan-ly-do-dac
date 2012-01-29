using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.ViewModels;
using GIS.Models;
using System.Web.Hosting;
using System.IO;
using DocumentHandling;

namespace GIS.Controllers
{
    public class ThongKeController : BaseController
    {
        private IThongKeRepository _thongkeRespository;
        private ILoaiHinhToChucRepository _loaiHinhToChucRepository = new LoaiHinhToChucRepository();

        public ThongKeController()
            : this( new GIS.Models.Repository.ThongKeRespository())
        {
        }

        public ThongKeController(IThongKeRepository thongkeRespository)
        {
            this._thongkeRespository = thongkeRespository;
        }
         
        
        // GET: /ThongKe/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Download(string nam)
        {
            String outputName = HttpContext.Session.SessionID + DateTime.Now.Ticks + ".docx";
            String tmpPath = Path.Combine(HostingEnvironment.MapPath("~/App_Data/Templates"), "PM32-2010-TT-BTNMT6.docx");
            String outPath = Path.Combine(HostingEnvironment.MapPath("~/App_Data/Download"), outputName);
            DocumentHandling.DocumentHandling handling = new PM32_2010_TT_BTNMT6Handling();

            int[] soLieu = _thongkeRespository.GetSoLieu(nam);
            List<List<string>> data = new List<List<string>>();
            int size = _loaiHinhToChucRepository.GetLoaiHinhToChucs().Count();
            for (int i = 0; i < size; i++)
            {
                List<string> row = new List<string>();
                LoaiHinhToChuc loaiHinh = _loaiHinhToChucRepository.GetLoaiHinhToChucByID(i + 1);
                int capLanDau = 0;
                int capBoSung = 0;
                int giaHan = 0;
                try
                {
                    capLanDau = soLieu[i * 3 + 0];
                    capBoSung = soLieu[i * 3 + 1];
                    giaHan = soLieu[i * 3 + 2];
                }
                catch { }
                int tongSo = capLanDau + capBoSung + giaHan;
                row.Add((i + 1).ToString());
                row.Add(loaiHinh.TenLoaiHinhToChuc);
                row.Add(tongSo.ToString());
                row.Add(capLanDau.ToString());
                row.Add(capBoSung.ToString());
                row.Add(giaHan.ToString());
                data.Add(row);
            }
            DateTime ngayThongKe = DateTime.Now;
            handling.SettingParam(PM32_2010_TT_BTNMT6Handling.DIADIEM, "Hồ Chí Minh");
            handling.SettingParam(PM32_2010_TT_BTNMT6Handling.NGAY, ngayThongKe.Day);
            handling.SettingParam(PM32_2010_TT_BTNMT6Handling.THANG, ngayThongKe.Month);
            handling.SettingParam(PM32_2010_TT_BTNMT6Handling.NAM, ngayThongKe.Year);
            handling.SettingParam(PM32_2010_TT_BTNMT6Handling.TINHHINHGIAYPHEPHOATDONG, data);
            handling.Generate(tmpPath, outPath);

            // Download
            // Open the file.
            Stream iStream = null;
            try
            {
                iStream = new FileStream(outPath, FileMode.Open, FileAccess.Read, FileShare.Read);
                // Total bytes to read:
                long dataToRead = iStream.Length;

                // Buffer to read 10K bytes in chunk:
                byte[] buffer = new Byte[10000];

                Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "PM32-2010-TT-BTNMT.docx");

                // Read the bytes.
                while (dataToRead > 0)
                {
                    // Verify that the client is connected.
                    if (Response.IsClientConnected)
                    {
                        // Read the data in buffer.
                        int length = iStream.Read(buffer, 0, 10000);

                        // Write the data to the current output stream.
                        Response.OutputStream.Write(buffer, 0, length);

                        // Flush the data to the HTML output.
                        Response.Flush();

                        buffer = new Byte[10000];
                        dataToRead = dataToRead - length;
                    }
                    else
                    {
                        //prevent infinite loop if user disconnects
                        dataToRead = -1;
                    }
                }
            }
            catch (Exception ex)
            {
                // Trap the error, if any.
                Response.Write("Error : " + ex.Message);
            }
            finally
            {
                Response.Close();
                if (iStream != null)
                {
                    //Close the file.
                    iStream.Close();
                }
                if (System.IO.File.Exists(outPath))
                {
                    System.IO.File.Delete(outPath);
                }
            }
            return RedirectToAction("Index");
        }

        public ActionResult DataToJSON(string nam)
        {
            int[] arr = new int[12];
            arr = _thongkeRespository.GetSoLieu(nam);
            List<ThongKe> DataList = new List<ThongKe>();
            ThongKe Data1 = new ThongKe();
            Data1.LoaiCapPhep = "Lần đầu";
            Data1.SoLieu = new int[4];
            Data1.SoLieu[0] = arr[0];
            Data1.SoLieu[1] = arr[1];
            Data1.SoLieu[2] = arr[2];
            Data1.SoLieu[3] = arr[3];
            DataList.Add(Data1);
            ThongKe Data2 = new ThongKe();
            Data2.LoaiCapPhep = "Gia hạn";
            Data2.SoLieu = new int[4];
            Data2.SoLieu[0] = arr[4];
            Data2.SoLieu[1] = arr[5];
            Data2.SoLieu[2] = arr[6];
            DataList.Add(Data2);
            ThongKe Data3 = new ThongKe();
            Data3.LoaiCapPhep = "Bổ sung hoạt động";
            Data3.SoLieu = new int[4];
            Data3.SoLieu[0] = arr[8];
            Data3.SoLieu[1] = arr[9];
            Data3.SoLieu[2] = arr[10];
            Data3.SoLieu[3] = arr[11];
            DataList.Add(Data3);
            return Json(DataList, JsonRequestBehavior.AllowGet);
        }
    }
}
