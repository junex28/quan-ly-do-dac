using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIS.Models {

    public class A_RuleViolation {

        public string ErrorMessage { get; private set; }
        public string PropertyName { get; private set; }

        public A_RuleViolation(string errorMessage) {
            ErrorMessage = errorMessage;
        }

        public A_RuleViolation(string errorMessage, string propertyName) {
            ErrorMessage = errorMessage;
            PropertyName = propertyName;
        }
    }
}
