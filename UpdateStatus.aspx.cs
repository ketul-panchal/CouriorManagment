using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace CourierManagementSystem
{
    public partial class UpdateStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            pnlCourierDetails.Visible = false; // Hide courier details initially
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string trackingID = txtTrackingID.Text.Trim();

            if (string.IsNullOrEmpty(trackingID))
            {
                lblMessage.Text = "⚠ Please enter a Tracking ID.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT TrackingID, SenderName, ReceiverName, Status FROM Couriers WHERE TrackingID = @TrackingID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TrackingID", trackingID);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvCourierDetails.DataSource = dt;
                        gvCourierDetails.DataBind();
                        pnlCourierDetails.Visible = true;
                        lblMessage.Text = "";
                    }
                    else
                    {
                        lblMessage.Text = "⚠ No records found for the entered Tracking ID.";
                        pnlCourierDetails.Visible = false;
                    }
                }
            }
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            string trackingID = txtTrackingID.Text.Trim();
            string newStatus = ddlStatus.SelectedValue;

            if (string.IsNullOrEmpty(trackingID))
            {
                lblMessage.Text = "⚠ Error: Tracking ID is required.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE Couriers SET Status=@Status WHERE TrackingID=@TrackingID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@TrackingID", trackingID);
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "✅ Courier status updated successfully!";
            pnlCourierDetails.Visible = false;
        }
    }
}
