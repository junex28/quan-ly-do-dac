using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;
using GIS.ViewModels;
using System.Linq.Dynamic;

namespace GIS.Controllers
{
    public class ToChucController : Controller
    {
        private IToChucRepository _tochucRepository;
        private ILoaiHinhToChucRepository _loaihinhtochucRepository;
        private ITaiKhoanRepository _taikhoanRepository;


        public ToChucController()
            : this(new ToChucRepository(), new LoaiHinhToChucRepository(), new TaiKhoanRepository())
        {
        }

        public ToChucController(IToChucRepository tochucRepository, ILoaiHinhToChucRepository loaihinhtochucRepository, ITaiKhoanRepository taikhoanRepository)
        {
            this._tochucRepository = tochucRepository;
            this._loaihinhtochucRepository = loaihinhtochucRepository;
            this._taikhoanRepository = taikhoanRepository;
        }

        public ActionResult Index()
        {
            return View();
        }
        //
        // GET: /ToChuc/
        //      /ToChuc/p/2

        public ActionResult List(int page)
        {
            ViewData["page"] = page;
            return View();
        }

        public ActionResult ListData(string sidx, string sord, int page, int rows)
        {
            var listToChucs = _tochucRepository.GetToChucs();
            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = listToChucs.Count();
            var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

            // Input page number greater than total page
            //if(page >totalPages && page !=1){
            //    pageIndex = 0;
            //} 
            // This is possible because I'm using the LINQ Dynamic Query Library
            var models = listToChucs
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
                        id = u.MaToChuc,
                        cell = new string[] {
                           u.MaToChuc.ToString(),
                           u.TenToChuc,
                           u.LoaiHinhToChuc.TenLoaiHinhToChuc,
                           "Sogiayphep",
                           "ThoiGianHetHan",
                           u.DienThoai,
                           u.TruSoChinh
                        }
                    })
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        //
        // GET: /Dinners/Details/5

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            ToChuc tochuc = _tochucRepository.GetToChucByID(id.Value);

            if (tochuc == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            var modelview = new ToChucDetailViewModel { toChuc = tochuc };
            return View(modelview);
        }


        //
        // GET: /Dinners/Edit/5

        public ActionResult Edit(int id)
        {
            var EditedToChuc = _tochucRepository.GetToChucByID(id);
            //LoaiHinhToChuc lhtc = tochucRepository.getLoaiHinh(tochuc);
            var LoaiHinhToChucList = _loaihinhtochucRepository.GetLoaiHinhToChucs().ToList();

            var viewmodel = new ToChucDetailViewModel
            {
                toChuc = EditedToChuc,
                loaiHinh = LoaiHinhToChucList
            };

            return View(viewmodel);
        }

        //
        // POST: /Dinners/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ToChuc tochuc = _tochucRepository.GetToChucByID(Convert.ToInt32(Request.Form["MaToChuc"]));

            try
            {
                tochuc.TruSoChinh = Request.Form["TruSoChinh"];
                tochuc.TongSoCanBo = Convert.ToInt32(Request.Form["TongSoCanBo"]);
                tochuc.SoTaiKhoan = Request.Form["SoTaiKhoan"];
                tochuc.LoaiHinhToChuc = _loaihinhtochucRepository.GetLoaiHinhToChucByID(Convert.ToInt16(Request.Form["MaLoaiToChuc"]));
                tochuc.GiayPhepKinhDoanh = Request.Form["GiayPhepKinhDoanh"];
                tochuc.NguoiDaiDien = Request.Form["NguoiDaiDien"];
                tochuc.DienThoai = Request.Form["DienThoai"];
                tochuc.Email = Request.Form["Email"];
                tochuc.Fax = Request.Form["Fax"];
                tochuc.KichHoat = Convert.ToBoolean(Request.Form["KichHoat"]);
                _tochucRepository.Save();
                return RedirectToAction("Details", new { id = tochuc.MaToChuc });
            }
            catch
            {
                return View();
            }
        }


        //
        // GET: /Dinners/Create

        [Authorize]
        public ActionResult Create()
        {

            //Dinner dinner = new Dinner()
            //{
            //    EventDate = DateTime.Now.AddDays(7)
            //};

            //return View(new DinnerFormViewModel(dinner));
            return View();
        }

        //
        // POST: /Dinners/Create

        [AcceptVerbs(HttpVerbs.Post), Authorize]
        public ActionResult Create(ToChuc tochuc)
        {

            //if (ModelState.IsValid)
            //{

            //    try
            //    {
            //        dinner.HostedBy = User.Identity.Name;

            //        RSVP rsvp = new RSVP();
            //        rsvp.AttendeeName = User.Identity.Name;
            //        dinner.RSVPs.Add(rsvp);

            //        dinnerRepository.Add(dinner);
            //        dinnerRepository.Save();

            //        return RedirectToAction("Details", new { id = dinner.DinnerID });
            //    }
            //    catch
            //    {
            //        ModelState.AddModelErrors(dinner.GetRuleViolations());
            //    }
            //}

            //return View(new DinnerFormViewModel(dinner));
            return View();
        }

        //
        // HTTP GET: /Dinners/Delete/1

        //[Authorize]
        public ActionResult Delete(int id)
        {
            ToChuc tochuc = _tochucRepository.GetToChucByID(id);

            if (tochuc == null)
            {
                return View("NotFound");
            }

            return View(tochuc);
        }

        // HTTP POST: /Dinners/Delete/1

        [HttpPost]
        public ActionResult Delete(int[] ids)
        {
            return RedirectToAction("List");
        }

        protected override void HandleUnknownAction(string actionName)
        {
            throw new HttpException(404, "Action not found");
        }

        public ActionResult Confused()
        {
            return View();
        }

        public ActionResult Trouble()
        {
            return View("Error");
        }

    }
}

//public ActionResult Kaka(string sidx, string sord, int page, int rows)
//{
//    var listToChucs = tochucRepository.GetToChucs();
//    var pageIndex = Convert.ToInt32(page) - 1;
//    var pageSize = rows;
//    var totalRecords = listToChucs.Count();
//    var totalPages = (int)Math.Ceiling(totalRecords / (float)pageSize);

//    // This is possible because I'm using the LINQ Dynamic Query Library
//    var models = listToChucs
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
//                id = u.MaToChuc, 
//                cell= new {
//                    Edit = "<a style='color:#5c87b2' href='" + "ToChuc/Edit/" + u.MaToChuc + "'>Edit</a>",
//                    Details = "<a style='color:#5c87b2' href='" + "ToChuc/Details/" + u.MaToChuc + "'>Details</a>",
//                    MaToChuc = u.MaToChuc,
//                    //CategoryName = "<a href=''>" + entity.CategoryName + "</a>",
//                    TenToChuc = u.TenToChuc,
//                    TruSoChinh = u.TruSoChinh}
//            }).ToArray()
//    };

//    return Json(jsonData, JsonRequestBehavior.AllowGet);
//}


//public ActionResult GridData(string sidx, string sord, int? page, int? rows)
//{
//    var jsonData = new
//    {
//        total = 1, // we'll implement later 
//        page = page,
//        records = 3, // implement later 
//        rows = new[]{
//        new {id = 1, cell = new[] {"1", "-7", "Is this a good question?"}},
//        new {id = 2, cell = new[] {"2", "15", "Is this a blatant ripoff?"}},
//        new {id = 3, cell = new[] {"3", "23", "Why is the sky blue?"}}
//    }
//    };
//    return Json(jsonData, JsonRequestBehavior.AllowGet);
//}

//public ActionResult LinqGridData(string sidx, string sord, int? page, int? rows) {
//      var listToChucs = tochucRepository.GetToChucs();
//      var jsonData = new {
//        total = 1, //todo: calculate
//        page = page,
//        records = listToChucs.Count(),
//        rows = (
//          from tc in listToChucs
//          select new {
//            id = tc.MaToChuc,
//            cell = new string[] { 
//              tc.MaToChuc.ToString(), tc.TenToChuc.ToString(), tc.TruSoChinh.ToString() 
//            }
//          }).ToArray()
//      };
//      return Json(jsonData, JsonRequestBehavior.AllowGet);
//    }

//public ActionResult LinqGridList(int page, int rows, string search, string sidx, string sord)
//{
//    var listToChucs = tochucRepository.GetToChucs();
//    var model = from entity in listToChucs.OrderBy(sidx + " " + sord)
//                select new
//                {
//                    Edit = "<a style='color:#5c87b2' href='" + "ToChuc/Edit/" + entity.MaToChuc + "'>Edit</a>",
//                    Details = "<a style='color:#5c87b2' href='" + "ToChuc/Details/" + entity.MaToChuc + "'>Details</a>",
//                    MaToChuc = entity.MaToChuc,
//                    //CategoryName = "<a href=''>" + entity.CategoryName + "</a>",
//                    TenToChuc = entity.TenToChuc,
//                    TruSoChinh = entity.TruSoChinh
//                };
//    return Json(model.ToJqGridData(page, rows, sidx, null, null));


//}
