using System;
using System.Web.UI;

namespace Museum_Artifact_Preservation_Management_System
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Search handled by client-side or redirects
        }
    }
}
