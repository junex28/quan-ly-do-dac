using System;
using System.Collections;
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
    public class QLMocController : Controller
    {
       private IMocTrongLuc _moctrongluc;
       private IMocDoCao _mocdocao;
       private IMocToaDo _moctoado;

        public QLMocController()
            : this(new MocTrongLucRespository(), new MocDoCaoRespository(), new MocToaDoRespository())
        {
        }

        public QLMocController(IMocTrongLuc moctrongluc, IMocDoCao mocdocao, IMocToaDo moctoado)
        {
            this._moctrongluc = moctrongluc;
            this._mocdocao = mocdocao;
            this._moctoado = moctoado;
        } 
        //
        // GET: /MocTrongLuc/

        //[Authorize]
        //[RoleFilter(Roles = "4")]
        public ActionResult Index([DefaultValue(1)] int page)
        {
            ViewData["page"] = page;
            return View();
        }

        //[Authorize]
        //[RoleFilter(Roles = "4")]
        public ActionResult ListData(int sId, string sidx, string search, string sord, int page, int rows)
        {
            int i = sId;
            if(i == 2)
            {
                IQueryable<MocDoCao> listMoc2 = null;
                if (search != null && search != "")
                {
                    listMoc2 = _mocdocao.GetMocDCBySearch(search);
                }
                else
                {
                    listMoc2 = _mocdocao.GetMocDoCaos();
                }
                var pageIndex = Convert.ToInt32(page) - 1;
                var pageSize = rows;
                var totalRecords = listMoc2.Count();
                var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

                var models = listMoc2
                    .OrderBy(sidx + " " + sord)
                    .Skip(pageIndex * pageSize)
                    .Take(pageSize).AsQueryable();

                var l1 = (from u in models
                    select new
                    {
                        id = u.OBJECTID,
                        cell = new string[] {
                           u.SoHieu,
                           u.NamThanhLap,
                           u.TinhTrang.ToString(),
                           u.CapHang.ToString()
                        }
                    }).ToList();
                foreach(var l in l1)
                {
                    if (l.cell[3].Equals("1")){
                        l.cell[3] = "cấp I";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt"; 
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                    else if (l.cell[3].Equals("2")){
                        l.cell[3] = "cấp II";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                    else if (l.cell[3].Equals("3")){
                        l.cell[3] = "cấp III";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                        }
                    }
                
            var jsonData = new
            {
                
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = l1
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            else if (i == 3)
            {
                IQueryable<MocTrongLuc> listMoc3 = null;
                if (search != null && search != "")
                {
                    listMoc3 = _moctrongluc.GetMocTLBySearch(search);
                }
                else
                {
                    listMoc3 = _moctrongluc.GetMocTrongLucs();
                }
                var pageIndex = Convert.ToInt32(page) - 1;
                var pageSize = rows;
                var totalRecords = listMoc3.Count();
                var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);


                var models = listMoc3
                        .OrderBy(sidx + " " + sord)
                        .Skip(pageIndex * pageSize)
                        .Take(pageSize).AsQueryable();
                var l3 = (from u in models
                          select new
                          {
                              id = u.OBJECTID,
                              cell = new string[] {
                            u.SoHieu,
                           u.NamThanhLap,
                           u.TinhTrang.ToString(),
                           u.CapHang.ToString()
                            }}).ToList();
                foreach (var l in l3)
                {
                    if (l.cell[3].Equals("1"))
                    {
                        l.cell[3] = "cấp I";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                    else if (l.cell[3].Equals("2"))
                    {
                        l.cell[3] = "cấp II";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                    else if (l.cell[3].Equals("3"))
                    {
                        l.cell[3] = "cấp III";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                }
                var jsonData = new
                {
                    total = totalPages,
                    page = page,
                    records = totalRecords,
                    rows = l3
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            else
            {

                IQueryable<MocToaDo> listMoc1 = null;
                if (search != null && search != "")
                {
                    listMoc1 = _moctoado.GetMocTDBySearch(search);
                }
                else
                {
                    listMoc1 = _moctoado.GetMocToaDos();
                }
                var pageIndex = Convert.ToInt32(page) - 1;
                var pageSize = rows;
                var totalRecords = listMoc1.Count();
                var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);


                var models = listMoc1
                        .OrderBy(sidx + " " + sord)
                        .Skip(pageIndex * pageSize)
                        .Take(pageSize).AsQueryable();
                var l1 = ( from u in models
                        select new
                        {
                            id = u.OBJECTID,
                            cell = new string[] {
                             u.SoHieu,
                           u.NamThanhLap,
                           u.TinhTrang.GetValueOrDefault().ToString(),
                           u.CapHang.ToString()
                        }
                        }).ToList();
                 foreach (var l in l1)
                {
                    if (l.cell[3].Equals("1"))
                    {
                        l.cell[3] = "cấp I";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                    else if (l.cell[3].Equals("2"))
                    {
                        l.cell[3] = "cấp II";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                    else if (l.cell[3].Equals("3"))
                    {
                        l.cell[3] = "cấp III";
                        if (l.cell[2].Equals("1"))
                        {
                            l.cell[2] = "còn tốt";
                        }
                        else if (l.cell[2].Equals("2"))
                        {
                            l.cell[2] = "đang sửa chữa";
                        }
                        else if (l.cell[2].Equals("3"))
                        {
                            l.cell[2] = "không còn sử dụng";
                        }
                    }
                }
                var jsonData = new
                {
                    total = totalPages,
                    page = page,
                    records = totalRecords,
                    rows = l1
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
        }

        //[Authorize]
        //[RoleFilter(Roles = "2,4")]
        public ActionResult ChiTiet(int id, int loai)
        {
            TaiKhoan tk = ((EnhancedPrincipal)HttpContext.User).Data;
            if (tk.NhomNguoiDung != null && tk.NhomNguoiDung == 2)
            {
                return RedirectToAction("thongbao", new { iMsg = 1 });
            }

             Moc moc = new Moc();
            if(loai == 1)
            {
                MocToaDo moctd = _moctoado.GetMocToaDoByID(id);
                moc.objId = moctd.OBJECTID;
                moc.soHieu = moctd.SoHieu;
                //moctd.MaSanPham = 
                moc.heQuyChieu = moctd.HeQuyChieu;
                moc.loaiMoc = (int)moctd.LoaiMoc;
                moc.capHang = (int)moctd.CapHang;
                moc.namThanhLap = moctd.NamThanhLap;
                moc.tinhTrang = (int)moctd.TinhTrang;
            }

            else if(loai == 2)
            {
                MocDoCao mocdc = _mocdocao.GetMocDoCaoByID(id);
                moc.objId = mocdc.OBJECTID;
                moc.soHieu = mocdc.SoHieu;
                //mocdc.MaSanPham = 
                moc.heQuyChieu = mocdc.HeQuyChieu;
                moc.loaiMoc = (int)mocdc.LoaiMoc;
                moc.capHang = (int)mocdc.CapHang;
                moc.namThanhLap = mocdc.NamThanhLap;
                moc.tinhTrang = (int)mocdc.TinhTrang;
            }
            else if (loai == 3)
            {
                MocTrongLuc moctl = _moctrongluc.GetMocTrongLucByID(id);
                moc.objId = moctl.OBJECTID;
                moc.soHieu = moctl.SoHieu;
                //moctl.MaSanPham = 
                moc.heQuyChieu = moctl.HeQuyChieu;
                moc.loaiMoc = (int)moctl.LoaiMoc;
                moc.namThanhLap = moctl.NamThanhLap;
                moc.capHang = (int)moctl.CapHang;
                moc.tinhTrang = (int)moctl.TinhTrang;
            }
            //moc.dsTinhTrang = new Hashtable();
            //moc.dsTinhTrang.Add(1, "Còn tốt");
            //moc.dsTinhTrang.Add(2, "Đang sửa chữa");
            //moc.dsTinhTrang.Add(3, "Không còn sử dụng");
            //moc.dsCapHangMoc = new Hashtable();
            //moc.dsCapHangMoc.Add(1, "Cấp I");
            //moc.dsCapHangMoc.Add(2, "Cấp II");
            //moc.dsCapHangMoc.Add(3, "Cấp III");
            //moc.dsLoaiMoc = new Hashtable();
            //moc.dsLoaiMoc.Add(1, "Mốc tọa độ");
            //moc.dsLoaiMoc.Add(2, "Mốc độ cao");
            //moc.dsLoaiMoc.Add(3, "Mốc trọng lực");

            return View(moc);
        }

        [HttpGet]
        public ActionResult CapNhat(int id, int loai)
        {
            Moc moc = new Moc();
            if (loai == 1)
            {
                MocToaDo moctd = _moctoado.GetMocToaDoByID(id);
                moc.objId = moctd.OBJECTID;
                moc.soHieu = moctd.SoHieu;
                //moctd.MaSanPham = 
                moc.heQuyChieu = moctd.HeQuyChieu;
                moc.loaiMoc = moctd.LoaiMoc != null && moctd.LoaiMoc.HasValue ? moctd.LoaiMoc.Value : 1;
                moc.capHang = moctd.CapHang != null && moctd.CapHang.HasValue ? moctd.CapHang.Value : 1;
                moc.namThanhLap = moctd.NamThanhLap;
                moc.tinhTrang = moctd.TinhTrang != null && moctd.TinhTrang.HasValue ? moctd.TinhTrang.Value : 1;
            }

            else if (loai == 2)
            {
                MocDoCao mocdc = _mocdocao.GetMocDoCaoByID(id);
                moc.objId = mocdc.OBJECTID;
                moc.soHieu = mocdc.SoHieu;
                //mocdc.MaSanPham = 
                moc.heQuyChieu = mocdc.HeQuyChieu;
                moc.loaiMoc = mocdc.LoaiMoc != null && mocdc.LoaiMoc.HasValue ? mocdc.LoaiMoc.Value : 2;
                moc.capHang = mocdc.CapHang != null && mocdc.CapHang.HasValue ? mocdc.CapHang.Value : 1;
                moc.namThanhLap = mocdc.NamThanhLap;
                moc.tinhTrang = mocdc.TinhTrang != null && mocdc.TinhTrang.HasValue ? mocdc.TinhTrang.Value : 1;
            }
            else if (loai == 3)
            {
                MocTrongLuc moctl = _moctrongluc.GetMocTrongLucByID(id);
                moc.objId = moctl.OBJECTID;
                moc.soHieu = moctl.SoHieu;
                //moctl.MaSanPham = 
                moc.heQuyChieu = moctl.HeQuyChieu;
                moc.loaiMoc = moctl.LoaiMoc != null && moctl.LoaiMoc.HasValue ? moctl.LoaiMoc.Value : 3;
                moc.namThanhLap = moctl.NamThanhLap;
                moc.capHang = moctl.CapHang != null && moctl.CapHang.HasValue ? moctl.CapHang.Value : 1;
                moc.tinhTrang = moctl.TinhTrang != null && moctl.TinhTrang.HasValue ? moctl.TinhTrang.Value : 1;
            }
            return View(moc);
        }
        [HttpPost]
        public ActionResult CapNhat(int id, int loai, Moc model)
        {
            try
            {
                if (loai == 1)
                {
                    MocToaDo moctd = new MocToaDo();
                    moctd = _moctoado.GetMocToaDoByID(id);
                    _moctoado.Update(moctd);
                    return RedirectToAction("ChiTiet", new { id = id, loai = loai });
                }
                else if (loai == 2)
                {
                    MocDoCao mocdc = new MocDoCao();
                    mocdc = _mocdocao.GetMocDoCaoByID(id);
                    _mocdocao.Update(mocdc);
                    return RedirectToAction("ChiTiet", new { id = id, loai = loai });
                }
                else if (loai == 3)
                {
                    MocTrongLuc moctl = new MocTrongLuc();
                    moctl = _moctrongluc.GetMocTrongLucByID(id);
                    _moctrongluc.Update(moctl);
                    return RedirectToAction("ChiTiet", new { id = id, loai = loai });
                }
                throw new Exception();
            }
            catch
            {
                MessageHelper.CreateMessage(MessageType.Error, "", new List<string>{"Cập nhật tình trạng mốc không thành công.\n Vui lòng thử lại."}, HttpContext.Response);
                return View(model);
            }

        }
    }
}
