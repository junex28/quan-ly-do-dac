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

       public QLGiayPhepController()
            : this(new ToChucRepository(), new TaiKhoanRepository(), new HoSoGiayPhepRepository(),
                        new TinhTrangGiayPhepRepository(), new DangKyHoatDongRespository(),
                        new HoatDongRespository(), new NangLucKeKhaiRespository())
        {
        }

       public QLGiayPhepController(IToChucRepository tochucRepository, ITaiKhoanRepository taikhoanRepository,
           IHoSoGiayPhepRepository gphdRepository, ITinhTrangGiayPhepRepository ttgpRepository, 
           IDangKyHoatDongRepository dkhdRespository, IHoatDongRepository hoatdongRepository, INangLucKeKhaiRespository nanglucRespository)
        {
            this._tochucRepository = tochucRepository;
            this._taikhoanRepository = taikhoanRepository;
            this._gphdRepository = gphdRepository;
            this._ttgpRepository = ttgpRepository;
            this._dkhdRespository = dkhdRespository;
            this._hoatdongRespository = hoatdongRepository;
           this._nanglucRespository = nanglucRespository;
        }
        //
        // GET: /GiayPhep/

       public ActionResult Index([DefaultValue(1)] int page)
       {
           ViewData["page"] = page;
           return View();
       }
      
       public ActionResult ListData(int sId, string sidx, string sord, int page, int rows)
       {
           int i = sId;
           var listGiayPhep = _gphdRepository.GetHoSoGiayPheps();

           switch(i)
           {
               case 0: listGiayPhep = _gphdRepository.GetHoSoGiayPheps(); break;
               case 1: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(1); break;
               case 2: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(2); break;
               case 3: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(3); break;
               case 4: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(4); break;
               case 5: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(5); break;
               case 6: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(6); break;
               case 7: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(7); break;
               case 8: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(8); break;
               case 9: listGiayPhep = _gphdRepository.GetGPHDByTinhTrang(9); break;
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
                           u.ToChuc.TenToChuc,
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
                return new FileNotFoundResult { Message = "Không có giấy phép trên trên" };
            }
            //var nanglucList = _nanglucRespository.GetNangLucKeKhaiByID(gphd.ToChuc.MaToChuc).ToList();
            var dangky = _dkhdRespository.GetDangKyHDs(id);
            var maHDList = _dkhdRespository.getSelectedHD(dangky.ToList<DangKyHoatDong>());
            var hoatdongList = new List<HoatDong>();
            foreach (int i in maHDList)
            {
                hoatdongList.Add(_hoatdongRespository.GetHoatDongByID(i));
            }
            var model = new GiayPhepDetailModel
            {
                DangKy = dangky,
                giayphep = gphd,
                hoatdong = hoatdongList,
               // nangluc = nanglucList
            };

            // Dieu huong view 
            return View(model);
        }

        //QLGiayPhep/Detail/id
       public ActionResult Detail(int id)
       {
           HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(id);
           if (gphd == null)
           {
             return new FileNotFoundResult { Message = "Không có giấy phép trên trên" };
           }
           var dangky =_dkhdRespository.GetDangKyHDs(id);
           var maHDList = _dkhdRespository.getSelectedHD(dangky.ToList<DangKyHoatDong>());
           var hoatdongList = new List<HoatDong>();
           foreach (int i in maHDList)
           {
               hoatdongList.Add(_hoatdongRespository.GetHoatDongByID(i));
           }
           var viewmodel = new GiayPhepDetailModel
           {
               DangKy = dangky,
               giayphep = gphd,
               hoatdong = hoatdongList
           };
           return View(viewmodel);
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

    }
}
