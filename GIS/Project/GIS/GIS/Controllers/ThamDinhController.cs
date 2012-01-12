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
    public class ThamDinhController : Controller
    {
        
        private IThamDinhRepository _thamdinhRepository;
        private IHoSoGiayPhepRepository _gphdRepository;
        private IDangKyHoatDongRepository _dkhdRespository;
        private IHoatDongRepository _hoatdongRespository;

        public ThamDinhController()
            : this(new ThamDinhRespository(), new HoSoGiayPhepRepository(), new DangKyHoatDongRespository(), new HoatDongRespository())
        {
        }

        public ThamDinhController(IThamDinhRepository thamdinhRepository, IHoSoGiayPhepRepository gphdRepository, IDangKyHoatDongRepository dkhdRespository, IHoatDongRepository hoatdongRepository)
        {
            this._thamdinhRepository = thamdinhRepository;
            this._gphdRepository = gphdRepository;
            this._dkhdRespository = dkhdRespository;
            this._hoatdongRespository = hoatdongRepository;
        }
        
        // GET: /ThamDinh/
        public ActionResult Index([DefaultValue(1)] int page, int id)
        {
            ViewData["id"]=id;
            ViewData["page"] = page;
            return View();
        }

        //public ActionResult ListData(int sid, string sidx, string sord, int page, int rows)
        //{
        //    var listThamDinhs = _thamdinhRepository.GetThamDinhByGPID(sid);
        //    var pageIndex = Convert.ToInt32(page) - 1;
        //    var pageSize = rows;
        //    var totalRecords = listThamDinhs.Count();
        //    var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

        //    // This is possible because I'm using the LINQ Dynamic Query Library
        //    var models = listThamDinhs
        //            .OrderBy(sidx + " " + sord)
        //            .Skip(pageIndex * pageSize)
        //            .Take(pageSize).AsQueryable();

        //    var jsonData = new
        //    {
        //        total = totalPages,
        //        page = page,
        //        records = totalRecords,
        //        rows = (
        //            from u in models
        //            select new
        //            {
        //                id = u.MaThamDinh,
        //                cell = new string[] {
        //                   u.MaThamDinh.ToString(),
        //                   u.HoSoGiayPhep.ToChuc.TenToChuc,
        //                   u.NgayThamDinh.Value.ToShortDateString(),
        //                   u.KienNghi,
        //                }
        //            })
        //    };

        //    return Json(jsonData, JsonRequestBehavior.AllowGet);
        //}
        //
        // GET: /ThamDinh/Details/5

        public ActionResult Detail(int id)
        {
            ThamDinh thamdinh = new ThamDinh();
            thamdinh = _thamdinhRepository.GetThamDinhById(id);
            var viewmodel = new ThamDinhEditViewModel { ThamDinh = thamdinh };
            return View(viewmodel);
        }

        //
        // GET: /ThamDinh/Create
        [HttpGet]
        public ActionResult Create(int gpid)
        {
            HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            var dangky = _dkhdRespository.GetDangKyHDs(gpid);
            var maHDList = _dkhdRespository.getSelectedHD(dangky.ToList<DangKyHoatDong>());
            var hoatdongList = new List<HoatDong>();
            foreach (int i in maHDList)
            {
                hoatdongList.Add(_hoatdongRespository.GetHoatDongByID(i));
            }
            var gpchitiet = new GiayPhepDetailModel
            {
                DangKy = dangky,
                giayphep = gphd,
                hoatdong = hoatdongList,
                // nangluc = nanglucList
            };
            ThamDinhEditViewModel model = new ThamDinhEditViewModel();
            model.giayphep = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            model.thongtinchung = gpchitiet;
            //model.m = gpid; 
            return View(model);
        } 

        //
        // POST: /ThamDinh/Create

        [HttpPost]
        public ActionResult Create(ThamDinhEditViewModel model)
        {
            //try
            //{               
            //        ThamDinh td = new ThamDinh();
            //        td.MaHoSoGiayPhep = model.giayphep.MaHoSoGiayPhep;
            //        //td.NgayThamDinh = (DateTime)model.NgayThamDinh;
            //        td.NguoiThamDinh = model.NguoiThamDinh;
            //        td.NguoiPhiaToChuc = model.NguoiPhiaToChuc;
            //        td.TinhHopLe = model.TinhHopLe;
            //        td.NangLucNhanVien = model.NangLucNhanVien;
            //        td.NangLucThietBi = model.NangLucThietBi;
            //        td.KetLuan = model.KetLuan;
            //        td.KienNghi = model.KienNghi;
            //        td.LoaiThamDinh = Convert.ToInt32(model.LoaiThamDinh);
            //        _thamdinhRepository.Add(td);
            //    //return RedirectToAction("Index", "TrangChu");
            //}
            //catch (Exception)
            //{
            //    MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when create new" }, HttpContext.Response);
            //}
            return View();
        }
        
        //
        // GET: /ThamDinh/Edit/5
 
        public ActionResult Edit(int id)
        {
            ThamDinh thamdinh = new ThamDinh();
            thamdinh = _thamdinhRepository.GetThamDinhById(id);
            var viewmodel = new ThamDinhEditViewModel
            {
                ThamDinh = thamdinh
            };
            return View(viewmodel);
        }

        //
        // POST: /ThamDinh/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int id, FormCollection collection)
        {
            String str = Request.Form["MaThamDinh"];
            ThamDinh thamdinh = _thamdinhRepository.GetThamDinhById(id);

            try
            {
                thamdinh.NgayThamDinh = Convert.ToDateTime(Request.Form["NgayThamDinh"]);
                thamdinh.NguoiThamDinh = Request.Form["NguoiThamDinh"];
                thamdinh.NguoiPhiaToChuc = Request.Form["NguoiPhiaToChuc"];
                thamdinh.TinhHopLe = Request.Form["TinhHopLe"];
                thamdinh.NangLucNhanVien = Request.Form["NangLucNhanVien"];
                thamdinh.NangLucThietBi = Request.Form["NangLucThietBi"];
                thamdinh.KetLuan = Request.Form["KetLuan"];
                thamdinh.KienNghi = Request.Form["KienNghi"];
                _thamdinhRepository.Save();
                return RedirectToAction("Detail", new { id = thamdinh.MaThamDinh });
            }
            catch
            {
                return View();
            }
        }

        //
        // POST: /ThamDinh/Delete/5

        [HttpPost]
        public ActionResult Delete(int[] ids)
        {
            try
            {
                List<String> listMsg = new List<string>();
                for (int i = 0; i < ids.Length; i++)
                {
                    ThamDinh thamdinh = _thamdinhRepository.GetThamDinhById(ids[i]);
                    _thamdinhRepository.Delete(thamdinh);
                    listMsg.Add("Đã xóa biên bản thẩm định có mã thẩm định là "+  ids[i].ToString());
                    _thamdinhRepository.Save();
                }
                MessageHelper.CreateMessage(MessageType.Highlight, "Title", listMsg, HttpContext.Response);
            }
            catch (Exception)
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "error when deleting" }, HttpContext.Response);
            }
            return View("Index");
        }

        public ActionResult Thamdinh(int id)
        {
            // Kiểm tra hồ sơ thẩm định thuộc loại hồ sơ nào
            // Nếu là đăng ký xin giấy phép mới đã thẩm dịnh 
            // chưa có số giấy phép thì sang addSoGiayPhep

            // ngược lại tuỳ theo loại 
            //Kiem tra ho so da co tham dinh chua
            // Neu chua co thi 
            // redirect den ThamDinh/Create/
            return RedirectToAction("Create", "Thamdinh", new { gpid = id });
        }
    }
}
