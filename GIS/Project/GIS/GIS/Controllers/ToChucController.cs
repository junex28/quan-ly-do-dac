﻿using System;
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
        private IToChucRepository tochucRepository;


        public ToChucController()
            : this(new ToChucRepository())
        {
        }

        public ToChucController(IToChucRepository tochucRepository)
        {
            this.tochucRepository = tochucRepository;
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
            return View(new ToChucListViewModel(page));
        }

        public ActionResult ListData(string sidx, string sord, int page, int rows)
        {
            var listToChucs = tochucRepository.GetToChucs();
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
                        cell = new String[]
                       {   
                           "<ul class='ui-widget icon-collection'>"+
                           "<li class='ui-state-default ui-corner-all' title='Chi tiết'>"+
                           "<a href='/ToChuc/Details/"+
                           u.MaToChuc.ToString()+
                           "'><span class='ui-icon ui-icon-document'></span></a>"+
                           "</li>"+
                           
                           "<li class='ui-state-default ui-corner-all' title='Thay đổi'>"+
                           "<a href='/ToChuc/Edit/"+
                           u.MaToChuc.ToString()+
                           "'><span class='ui-icon ui-icon-pencil'></span></a>"+
                           "</li>"+
                           
                           "<li class='ui-state-default ui-corner-all' title='Xoá'>"+
                           "<a href='/ToChuc/Xoa?id="+
                           u.MaToChuc.ToString()+
                           "'><span class='ui-icon ui-icon-trash'></span></a>"+
                           "</li>"+
                            "</ul>",
                           u.MaToChuc.ToString(),
                           //CategoryName = "<a href=''>" + entity.CategoryName + "</a>",
                           u.TenToChuc.ToString(),
                           "LoaiHinhToChuc",
                           "Sogiayphep",
                           "ThoiGianHetHan",
                           u.DienThoai.ToString(),
                           u.TruSoChinh.ToString()                            
                       }
                    }).ToArray()
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

            ToChuc tochuc = tochucRepository.GetToChucByID(id.Value);
            LoaiHinhToChuc loaiHinhTC = tochucRepository.getLoaiHinh(tochuc);

            if (tochuc == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            return View(new ToChucDetailViewModel(tochuc, loaiHinhTC));
        }


        //
        // GET: /Dinners/Edit/5

        public ActionResult Edit(int id)
        {
            ToChuc tochuc = tochucRepository.GetToChucByID(id);
            LoaiHinhToChuc lhtc = tochucRepository.getLoaiHinh(tochuc);
            return View(new ToChucDetailViewModel(tochuc, lhtc));
        }

        //
        // POST: /Dinners/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ToChuc tochuc = tochucRepository.GetToChucByID(Convert.ToInt32(Request.Form["MaToChuc"]));             
            LoaiHinhToChuc lhtc = tochucRepository.getLoaiHinh(tochuc);               
            try
            {
                tochuc.TruSoChinh =  Request.Form["tochuc.TruSoChinh"];
                tochuc.TongSoCanBo = Convert.ToInt32(Request.Form["tochuc.TongSoCanBo"]);
                tochuc.SoTaiKhoan = Request.Form["tochuc.TaiKhoan"];
                tochuc.NguoiDaiDien = Request.Form["tochuc.NguoiDaiDien"];
                tochuc.DienThoai = Request.Form["tochuc.DienThoai"];
                tochuc.Email = Request.Form["tochuc.Email"];
                tochuc.Fax = Request.Form["tochuc.Fax"];
                tochucRepository.Save();
                return RedirectToAction("Details", new { id = tochuc.MaToChuc });
            }
            catch
            {
                return View(new ToChucDetailViewModel(tochuc, lhtc));
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
            ToChuc tochuc = tochucRepository.GetToChucByID(id);

            if (tochuc == null)
            {
                return View("NotFound");
            }

            return View(tochuc);
        }
   
        // HTTP POST: /Dinners/Delete/1

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Delete(int id, string confirmButton)
        {
            ToChuc tochuc = tochucRepository.GetToChucByID(id);

            if (tochuc == null)
            {
                return View("NotFound");
            }

            tochucRepository.Delete(tochuc);
            tochucRepository.Save();

            return View("Deleted");
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