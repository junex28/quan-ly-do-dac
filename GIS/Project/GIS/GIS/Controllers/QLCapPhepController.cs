using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;

namespace GIS.Controllers
{
    public class QLCapPhepController : Controller
    {
        //
        // GET: /QLCapPhep/

        public ActionResult Index()
        {
            /*QLDDBDDataContext dataContext = new QLDDBDDataContext();
            var DSLoaiHinhToChuc = (from p in dataContext.LoaiHinhToChuc select p).ToList();
          //return View(DSLoaiHinhToChuc);*/
            return View();
        }

        //
        // GET: /QLCapPhep/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /QLCapPhep/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /QLCapPhep/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /QLCapPhep/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /QLCapPhep/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /QLCapPhep/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /QLCapPhep/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
