using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GIS.Models;
using GIS.Helpers;

namespace GIS.Controllers
{
    public class ToChucController : Controller
    {
        private IToChucRepository tochucRepository;

        
        public ToChucController(): this(new ToChucRepository()) 
        {
        }

        public ToChucController(IToChucRepository tochucRepository)
        {
            this.tochucRepository = tochucRepository;
        }

        //
        // GET: /ToChuc/
        //      /ToChuc/Page/2

        public ActionResult Index(int? page)
        {

            const int pageSize = 1;

            var listToChucs = tochucRepository.GetToChucs();
            var paginatedToChucs = new PaginatedList<ToChuc>(listToChucs, page ?? 0, pageSize);

            return View(paginatedToChucs);
        }


        //
        // GET: /Dinners/Details/5

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            ToChuc tochuc= tochucRepository.GetToChucByID(id.Value);

            if (tochuc == null)
            {
                return new FileNotFoundResult { Message = "Không có tổ chức trên" };
            }

            return View(tochuc);
        }


        //
        // GET: /Dinners/Edit/5

        [Authorize]
        public ActionResult Edit(int id)
        {

            //Dinner dinner = dinnerRepository.GetDinner(id);

            //if (!dinner.IsHostedBy(User.Identity.Name))
            //    return View("InvalidOwner");

            //return View(new DinnerFormViewModel(dinner));
            return View();
        }

        //
        // POST: /Dinners/Edit/5

        [AcceptVerbs(HttpVerbs.Post), Authorize]
        public ActionResult Edit(int id, FormCollection collection)
        {

            //Dinner dinner = dinnerRepository.GetDinner(id);

            //if (!dinner.IsHostedBy(User.Identity.Name))
            //    return View("InvalidOwner");

            //try
            //{
            //    UpdateModel(dinner);

            //    dinnerRepository.Save();

            //    return RedirectToAction("Details", new { id = dinner.DinnerID });
            //}
            //catch
            //{
            //    ModelState.AddModelErrors(dinner.GetRuleViolations());

            //    return View(new DinnerFormViewModel(dinner));
            //}
            return View();
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

        [Authorize]
        public ActionResult Delete(int id)
        {

            //Dinner dinner = dinnerRepository.GetDinner(id);

            //if (dinner == null)
            //    return View("NotFound");

            //if (!dinner.IsHostedBy(User.Identity.Name))
            //    return View("InvalidOwner");

            //return View(dinner);
            return View();
        }

        // 
        // HTTP POST: /Dinners/Delete/1

        [AcceptVerbs(HttpVerbs.Post), Authorize]
        public ActionResult Delete(int id, string confirmButton)
        {

            //Dinner dinner = dinnerRepository.GetDinner(id);

            //if (dinner == null)
            //    return View("NotFound");

            //if (!dinner.IsHostedBy(User.Identity.Name))
            //    return View("InvalidOwner");

            //dinnerRepository.Delete(dinner);
            //dinnerRepository.Save();

            //return View("Deleted");
            return View();
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
