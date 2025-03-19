using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace CourierManagementSystem
{
    public partial class TrackCourier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            pnlTrackingResult.Visible = false; // Hide results initially
        }

        protected void btnTrack_Click(object sender, EventArgs e)
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
                string query = "SELECT TrackingID, SenderName, ReceiverName, ParcelWeight, DeliveryType, Status, BookingDate FROM Couriers WHERE TrackingID = @TrackingID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TrackingID", trackingID);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvTrackingDetails.DataSource = dt;
                        gvTrackingDetails.DataBind();
                        pnlTrackingResult.Visible = true; // Show result panel
                        lblMessage.Text = "";
                    }
                    else
                    {
                        lblMessage.Text = "⚠ No records found for the entered Tracking ID.";
                        pnlTrackingResult.Visible = false;
                    }
                }
            }
        }
    }
}
