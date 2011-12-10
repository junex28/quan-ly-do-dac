using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.Web.Mvc;

namespace GIS.Helpers {

    public static class ModelStateHelpers {

        public static void AddModelErrors(this ModelStateDictionary modelState, IEnumerable<A_RuleViolation> errors) {

            foreach (A_RuleViolation issue in errors) {
                modelState.AddModelError(issue.PropertyName, issue.ErrorMessage);
            }
        }
    }
}
