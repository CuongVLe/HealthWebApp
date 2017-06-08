using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebHealthCareApplication
{
    public partial class MainWebPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ChangeCSS(object sender, EventArgs e)
        {   
            lnkCSS.Attributes["href"] = "~/Content/" + (sender as Button).CommandArgument;
        }

    }
}