using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;
using GIS.ViewModels;
using System.Linq.Dynamic;
using System.ComponentModel;
using GIS.Models.Repository;

namespace GIS.Controllers
{
    public class QLGiayPhepController : Controller
    {
        private IToChucRepository _tochucRepository;
        private ITaiKhoanRepository _taikhoanRepository;
        private IHoSoGiayPhepRepository _gphdRepository;
        private ITinhTrangGiayPhepRepository _ttgpRepository;
        private IDangKyHoatDongRepository _dkhdRespository;
        private IHoatDongRepository _hoatdongRespository;
        private INangLucKeKhaiRespository _nanglucRespository;
        //private IBaoCaoHoatDongRepository _bchdRespository;

       public QLGiayPhepController()
            : this(new ToChucRepository(), new TaiKhoanRepository(), new HoSoGiayPhepRepository(),
                        new TinhTrangGiayPhepRepository(), new DangKyHoatDongRespository(),
                        new HoatDongRespository(), new NangLucKeKhaiRespository())
        {
        }

       public QLGiayPhepController(IToChucRepository tochucRepository, ITaiKhoanRepository taikhoanRepository,
           IHoSoGiayPhepRepository gphdRepository, ITinhTrangGiayPhepRepository ttgpRepository, 
           IDangKyHoatDongRepository dkhdRespository, IHoatDongRepository hoatdongRepository,
           INangLucKeKhaiRespository nanglucRespository)
        {
            this._tochucRepository = tochucRepository;
            this._taikhoanRepository = taikhoanRepository;
            this._gphdRepository = gphdRepository;
            this._ttgpRepository = ttgpRepository;
            this._dkhdRespository = dkhdRespository;
            this._hoatdongRespository = hoatdongRepository;
           this._nanglucRespository = nanglucRespository;
          // this._bchdRespository = bchdRespository;
        }
        //
        // GET: /GiayPhep/

       public ActionResult Index([DefaultValue(1)] int page)
       {
           ViewData["page"] = page;
           return View();
       }
      
       public ActionResult ListData(int sId, string sidx, string search, string sord, int page, int rows)
       {
           int i = sId;
           var listGiayPhep = _gphdRepository.GetHoSoGiayPheps(search);

           switch(i)
           {
               case 0: listGiayPhep = _gphdRepository.GetHoSoGiayPheps(search); break;
               case 1: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(1, search); break;
               case 2: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(2, search); break;
               case 3: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(3, search); break;
               case 4: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(4, search); break;
               case 5: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(5, search); break;
               case 6: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(6, search); break;
               case 7: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(7, search); break;
               case 8: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(8, search); break;
               case 9: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(9, search); break;
               case 10: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(10, search); break;
               case 11: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(11, search); break;
               case 12: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(12, search); break;
           }

           var pageIndex = Convert.ToInt32(page) - 1;
           var pageSize = rows;
           var totalRecords = listGiayPhep.Count();
           var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

           var models = listGiayPhep
                   .OrderBy(sidx + " " + sord)
                   .Skip(pageIndex * pageSize)
                   .Take(pageSize).AsQueryable();

           var jsonData = new
           {
               total = totalPages,
               page = page,
               records = totalRecords,
               rows = (
                   from u in models
                   select new
                   {
                       id = u.MaHoSo,
                       cell = new string[] {
                           u.MaHoSo.ToString(),
                           u.ThongTinChung.TenToChuc,
                           u.NgayXinPhep.ToString(),
                           u.TinhTrangGiayPhep.DienGiai
                        }
                   })
           };

           return Json(jsonData, JsonRequestBehavior.AllowGet);
       }
       
        public ActionResult ChiTiet(int id){
            HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(id);
            if (gphd == null)
            {
                return RedirectToAction("ThongBao", new {iMsg = 2});
            }
            BaoCaoHoatDong bc = new BaoCaoHoatDong();
            bc = gphd.ThongTinChung.BaoCaoHoatDongs.SingleOrDefault(m=>m.MaThongTinChung == gphd.MaThongTinChung);
            int k = 0;
            if (bc != null)
            {
                k = bc.MaBaoCao;
            }
            var dangkyMoi = _dkhdRespository.GetDangKyHDMoi(id);
            var dangkyDuocCap = _dkhdRespository.GetDKHDDaCap(id);
            var dangkyBS = _dkhdRespository.GetDKHDBoSung(id);
            var model = new GiayPhepDetailModel
            {
                DangKy = dangkyMoi,
                DangKyDaCap = dangkyDuocCap,
                DangKyBoSung = dangkyBS,
                giayphep = gphd,
                MaBaoCao = k
                //hoatdong = hoatdongList
               // nangluc = nanglucList
            };
            return View(model);
        }

       public ActionResult Edit(int id)
       {
           var EditedGPHD = _gphdRepository.GetHoSoGiayPhepByID(id);
           var dkhdList = _dkhdRespository.GetDangKyHDs(id);
           var hoatdongList = _hoatdongRespository.GetHoatDongs().ToList<HoatDong>();
           var selectedMaHDList = _dkhdRespository.getSelectedHD(dkhdList.ToList<DangKyHoatDong>());
           var selectedHDList = new List<HoatDong>();
           foreach (int i in selectedMaHDList)
           {
               selectedHDList.Add(hoatdongList[i]);
           }
           var m = new MultiSelectList(hoatdongList, "MaHoatDong", "TenHoatDong",
                     selectedHDList.Select(x => x.MaHoatDong));
           ViewData["hoatdong"] = m;
           var viewmodel = new GiayPhepDetailModel
           {
               giayphep = EditedGPHD,
              DangKy = dkhdList,
              //HoatDong = m;
           };

           return View(viewmodel);
       }

       public ActionResult HuyGiayPhep(int[] ids)
       {
           foreach (int i in ids)
           {
               HoSoGiayPhep hs = _gphdRepository.GetHoSoGiayPhepByID(i);
               _gphdRepository.Delete(hs);
           }
           return Redirect("Index");
       }

       public ActionResult Download(string fn) 
       {
           string pfn = Server.MapPath("~/App_Data/Upload/HSToChuc/" + fn);
           pfn = pfn.Replace("//", "/");
           if (!System.IO.File.Exists(pfn))
           {
               return RedirectToAction("ThongBao", new {iMsg = 1});
           }
           return new BinaryContentResult()
           {
               FileName = fn,
               ContentType = "application/octet-stream",
               Content = System.IO.File.ReadAllBytes(pfn)
           };
       }
       public ActionResult ThongBao(int iMsg)
       {
           var msg= iMsg;
           return View(msg);
       }
    }
}
