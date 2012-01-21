﻿using System;
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
        private IHoatDongRepository _hoatdongRespository; // may cai nay ko de toan cuc dc dau heo

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

        public ActionResult Detail(int gpid)
        {
            //ThamDinh thamdinh = new ThamDinh();
            HoSoGiayPhep hs = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            var dangky = _dkhdRespository.GetDangKyHDs(gpid);
            var hdDaCap = _dkhdRespository.GetDKHDDaCap(gpid);
            var hdBoSung = _dkhdRespository.GetDKHDBoSung(gpid);
            var maHDList = _dkhdRespository.getSelectedHD(dangky.ToList<DangKyHoatDong>());
            var hoatdongList = new List<HoatDong>();
            foreach (int i in maHDList)
            {
                hoatdongList.Add(_hoatdongRespository.GetHoatDongByID(i));
            }
            var gpchitiet = new GiayPhepDetailModel
            {
                DangKy = dangky,
                giayphep = hs,
                hoatdong = hoatdongList,
                DangKyDaCap = hdDaCap,
                DangKyBoSung = hdBoSung
                // nangluc = nanglucList
            };
            ThamDinh thamdinh = _thamdinhRepository.GetThamDinhByGPID(gpid);
            var viewmodel = new ThamDinhEditViewModel { ThamDinh = thamdinh, giayphep =hs, thongtinchung = gpchitiet };
            return View(viewmodel);
        }

        //
        // GET: /ThamDinh/Create
        [HttpGet]
        public ActionResult Create(int gpid)
        {
            HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            var dangky = _dkhdRespository.GetDangKyHDs(gpid);
            var hdDaCap = _dkhdRespository.GetDKHDDaCap(gpid);
            var hdBoSung = _dkhdRespository.GetDKHDBoSung(gpid);
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
                DangKyDaCap = hdDaCap,
                DangKyBoSung = hdBoSung
                // nangluc = nanglucList
            };
            var td = _thamdinhRepository.GetThamDinhByGPID(gpid);
            ThamDinhEditViewModel model = new ThamDinhEditViewModel();
            model.giayphep = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            model.thongtinchung = gpchitiet;
            model.ThamDinh = td;
            //model.m = gpid; 
            return View(model);
        } 

        //
        // POST: /ThamDinh/Create

        [HttpPost]
        public ActionResult Create(ThamDinhEditViewModel model, int gpid)
        {
            bool iMsg = true;
            try
            {
                ThamDinh td = new ThamDinh();
                td.MaHoSo = gpid;
                td.NgayThamDinh = (DateTime)model.NgayThamDinh;
                td.NguoiThamDinh = model.NguoiThamDinh;
                td.NguoiPhiaToChuc = model.NguoiPhiaToChuc;
                td.TinhHopLe = model.TinhHopLe;
                td.NangLucNhanVien = model.NangLucNhanVien;
                td.NangLucThietBi = model.NangLucThietBi;
                td.KetLuan = model.KetLuan;
                td.KienNghi = model.KienNghi;
                _thamdinhRepository.Add(td);
               
                //return RedirectToAction("Index", "TrangChu");
               // MessageHelper.CreateMessage(MessageType.Highlight, "Title", listMsg, HttpContext.Response);
            }
            catch (Exception)
            {
               // MessageHelper.CreateMessage(MessageType.Error, "", new List<string> { "lỗi khi lưu biên bản thẩm định" }, HttpContext.Response);
                //listMsg.Add("lỗi khi lưu biên bản thẩm định");
                iMsg = false;
            }
            //return RedirectToAction("ThongBao", "Thamdinh", new { iMsg1 = iMsg });
            return RedirectToAction("Index", "QLGiayPhep");
        }

        public ActionResult ThongBao(bool iMsg1)
        {
            List<string> listMsg = new List<string>();
            if (iMsg1 == true)
            {
                listMsg.Add("đã lưu biên bản thẩm định");
                 MessageHelper.CreateMessage(MessageType.Highlight, "Kết quả", listMsg, HttpContext.Response);
            }
            else 
            {
                listMsg.Add("lỗi khi lưu biên bản thẩm định");
                MessageHelper.CreateMessage(MessageType.Error, "Title", listMsg, HttpContext.Response);
            }
            return View();
        }
        //
        // GET: /ThamDinh/Edit/5

        public ActionResult Edit(int gpid)
        {
            HoSoGiayPhep gphd = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            var dangky = _dkhdRespository.GetDangKyHDs(gpid);
            var hdDaCap = _dkhdRespository.GetDKHDDaCap(gpid);
            var hdBoSung = _dkhdRespository.GetDKHDBoSung(gpid);
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
                DangKyDaCap = hdDaCap,
                DangKyBoSung = hdBoSung
                // nangluc = nanglucList
            };
            var td = _thamdinhRepository.GetThamDinhByGPID(gpid);
            ThamDinhEditViewModel model = new ThamDinhEditViewModel();
            model.giayphep = _gphdRepository.GetHoSoGiayPhepByID(gpid);
            model.thongtinchung = gpchitiet;
            model.ThamDinh = td;
            //model.m = gpid; 
            return View(model);
        }

        //
        // POST: /ThamDinh/Edit/5
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(ThamDinhEditViewModel model, int gpid, int save)
        {
            ITinhTrangGiayPhepRepository ttgpRepository = new TinhTrangGiayPhepRepository();

            try
            {
                var hs = _gphdRepository.GetHoSoGiayPhepByID(gpid);
                if (save == 0)
                {
                    if (hs.TinhTrangGiayPhep.MaTinhTrang == 1)
                        hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(2);
                    else if (hs.TinhTrangGiayPhep.MaTinhTrang == 6)
                        hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(7);
                    else if (hs.TinhTrangGiayPhep.MaTinhTrang == 9)
                        hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(10);
                }
                else if (save == 1)
                {
                    if (hs.TinhTrangGiayPhep.MaTinhTrang == 1)
                    {
                        if (model.giayphep.SoGiayPhep == null)
                            hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(4);
                        else
                        {
                            hs.SoGiayPhep = model.giayphep.SoGiayPhep;
                            hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(5);
                        }
                    }
                    else if (hs.TinhTrangGiayPhep.MaTinhTrang == 4 && model.giayphep.SoGiayPhep != null){
                        hs.SoGiayPhep = model.giayphep.SoGiayPhep;
                        hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(5);
                    }
                    else if (hs.TinhTrangGiayPhep.MaTinhTrang == 6)
                        hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(8);
                    else if (hs.TinhTrangGiayPhep.MaTinhTrang == 9)
                        hs.TinhTrangGiayPhep = ttgpRepository.GetTinhTrangGiayPhepByID(11);
                }
                _gphdRepository.Save();

                ThamDinh td = _thamdinhRepository.GetThamDinhByGPID(gpid);
                td.MaHoSo = gpid;
                td.NgayThamDinh = (DateTime)model.ThamDinh.NgayThamDinh;
                td.NguoiThamDinh = model.ThamDinh.NguoiThamDinh;
                td.NguoiPhiaToChuc = model.ThamDinh.NguoiPhiaToChuc;
                td.TinhHopLe = model.ThamDinh.TinhHopLe;
                td.NangLucNhanVien = model.ThamDinh.NangLucNhanVien;
                td.NangLucThietBi = model.ThamDinh.NangLucThietBi;
                td.KetLuan = model.ThamDinh.KetLuan;
                td.KienNghi = model.ThamDinh.KienNghi;
                _thamdinhRepository.Save();
            }
            catch
            {
                return View();
            }
            return RedirectToAction("Index", "QLGiayPhep");
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
            HoSoGiayPhep hs = _gphdRepository.GetHoSoGiayPhepByID(id);
            ThamDinh td = _thamdinhRepository.GetThamDinhByGPID(id);
            if ( td == null )
            {
                return RedirectToAction("Create", "Thamdinh", new { gpid = id });
            }
            else{
                if (hs.TinhTrangGiayPhep.MaTinhTrang == 4 || hs.TinhTrangGiayPhep.MaTinhTrang == 6 || hs.TinhTrangGiayPhep.MaTinhTrang == 9)
                {
                    return RedirectToAction("Edit", "ThamDinh", new { gpid =id});
                }
                else
                    return RedirectToAction("Detail", "ThamDinh", new { gpid = id });
            }
            // ngược lại tuỳ theo loại 
            //Kiem tra ho so da co tham dinh chua
            // Neu chua co thi 

            // redirect den ThamDinh/Create/
            
        }
    }
}
