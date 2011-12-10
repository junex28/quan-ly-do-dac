//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.Mvc;
//using GIS.Models;

//namespace GIS.Controllers
//{
//    public class GiayPhepMoiController : Controller
//    {
//        IGiayPhepMoiRepository gpMoiRepository;


//        // Dependency Injection enabled constructors

//        public GiayPhepMoiController()
//            : this(new GiayPhepMoiController())
//        {
//        }

//        public GiayPhepMoiController(IGiayPhepMoiRepository repository)
//        {
//            gpMoiRepository = repository;
//        }
//        //
//        // GET: /GiayPhepMoi/

//        public ActionResult Index()
//        {
//            var dsChoThamDinh = gpMoiRepository.DSChoThamDinh();
//            return View(dsChoThamDinh);
//        }

//        public ViewResult List()
//        {
//            return View();
//        }
//        /*
//        public ActionResult GridData(int? GPChoThamDinhId, string sidx, string sord, int? page, int? rows)
//        {
//            var repotory1 = new GiayPhepMoiController();
//            var model = from entity in repotory1.Index(GPChoThamDinhId.Value).OrderBy(sidx + " " + sord)
//                        select new
//                        {
                            
//                        };
//        */
//        /* var jsonData = new
//         {
//             total = 1, // we'll implement later 
//             page = page,
//             records = 3, // implement later 
//             rows = new[]{,
//             new {id = 1, cell = new[] {"1", "-7", "Is this a good question?"}},
//             new {id = 2, cell = new[] {"2", "15", "Is this a blatant ripoff?"}},
//             new {id = 3, cell = new[] {"3", "23", "Why is the sky blue?"}}
//         }
//         };
//         return Json(jsonData, JsonRequestBehavior.AllowGet); 
//     }*/
//        //
//        // GET: /GiayPhepMoi/Details/5

//        public ActionResult Details(int id)
//        {
//            return View();
//        }

//        //
//        // GET: /GiayPhepMoi/Create

//        public ActionResult Create()
//        {
//            return View();
//        }

//        //
//        // POST: /GiayPhepMoi/Create

//        [HttpPost]
//        public ActionResult Create(FormCollection collection)
//        {
//            try
//            {
//                // TODO: Add insert logic here

//                return RedirectToAction("Index");
//            }
//            catch
//            {
//                return View();
//            }
//        }

//        //
//        // GET: /GiayPhepMoi/Edit/5

//        public ActionResult Edit(int id)
//        {
//            return View();
//        }

//        //
//        // POST: /GiayPhepMoi/Edit/5

//        [HttpPost]
//        public ActionResult Edit(int id, FormCollection collection)
//        {
//            try
//            {
//                // TODO: Add update logic here

//                return RedirectToAction("Index");
//            }
//            catch
//            {
//                return View();
//            }
//        }

//        //
//        // GET: /GiayPhepMoi/Delete/5

//        public ActionResult Delete(int id)
//        {
//            return View();
//        }

//        //
//        // POST: /GiayPhepMoi/Delete/5

//        [HttpPost]
//        public ActionResult Delete(int id, FormCollection collection)
//        {
//            try
//            {
//                // TODO: Add delete logic here

//                return RedirectToAction("Index");
//            }
//            catch
//            {
//                return View();
//            }
//        }
//    }
//}
