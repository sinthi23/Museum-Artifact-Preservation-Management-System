using System;
using System.Data;

namespace MuseumArtifactPreservation
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardSummary();
                BindArtifactGrid();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindArtifactGrid();

            lblSearchMessage.Text = "Showing records using selected search filters.";
        }

        private void LoadDashboardSummary()
        {
            lblUserRole.Text = "Curator Dashboard";
            lblTotalArtifacts.Text = "1,248";
            lblRestorationDue.Text = "37";
            lblActiveLoans.Text = "19";
            lblDamageReports.Text = "12";
        }

        private void BindArtifactGrid()
        {
            // Replace this sample DataTable with Oracle query results later.
            DataTable artifacts = new DataTable();
            artifacts.Columns.Add("ArtifactId");
            artifacts.Columns.Add("Name");
            artifacts.Columns.Add("Origin");
            artifacts.Columns.Add("Era");
            artifacts.Columns.Add("Material");
            artifacts.Columns.Add("Condition");
            artifacts.Columns.Add("Location");

            artifacts.Rows.Add("A-1001", "Bronze Ritual Bowl", "Bangladesh", "Medieval", "Bronze", "Stable", "Storage Room B2");
            artifacts.Rows.Add("A-1044", "Painted Ceramic Vessel", "Greece", "Ancient", "Ceramic", "Restoration Needed", "Gallery Wing 3");
            artifacts.Rows.Add("A-1120", "Illuminated Manuscript", "Italy", "Renaissance", "Paper", "Damaged", "Conservation Lab");
            artifacts.Rows.Add("A-1187", "Limestone Funerary Mask", "Egypt", "Ancient", "Limestone", "Excellent", "Main Exhibition Hall");

            gvArtifacts.DataSource = artifacts;
            gvArtifacts.DataBind();
        }
    }
}