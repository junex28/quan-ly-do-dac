using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GIS.Models;
using System.Web.Mvc;

namespace GIS.Helpers {

    public static class ModelStateHelpers {

        public static void AddModelErrors(this ModelStateDictionary modelState, IEnumerable<RuleViolation> errors) {

            foreach (RuleViolation issue in errors) {
                modelState.AddModelError(issue.PropertyName, issue.ErrorMessage);
            }
        }
    }
}
