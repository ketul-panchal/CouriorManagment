using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace CourierManagementSystem
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                LoadUserDashboard();
            }
        }

        private void LoadUserDashboard()
        {
            // Get logged-in user's ID (assuming it's stored in Session)
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Get user name (Handle NULL properly)
                using (SqlCommand cmd = new SqlCommand("SELECT Name FROM Users WHERE UserID=@UserID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    object result = cmd.ExecuteScalar();
                    lblUserName.Text = result != null ? result.ToString() : "User";
                }

                // Get total bookings (Handle NULL properly)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Couriers WHERE CustomerID=@UserID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    object result = cmd.ExecuteScalar();
                    lblTotalBookings.Text = result != null ? result.ToString() : "0";
                }

                // Get pending deliveries (Handle NULL properly)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Couriers WHERE CustomerID=@UserID AND Status IN ('Pending', 'Picked Up', 'In Transit')", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    object result = cmd.ExecuteScalar();
                    lblPendingDeliveries.Text = result != null ? result.ToString() : "0";
                }

                // Get delivered couriers (Handle NULL properly)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Couriers WHERE CustomerID=@UserID AND Status='Delivered'", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    object result = cmd.ExecuteScalar();
                    lblDeliveredCouriers.Text = result != null ? result.ToString() : "0";
                }

                // Load recent bookings
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 5 TrackingID, ReceiverName, Status, BookingDate FROM Couriers WHERE CustomerID=@UserID ORDER BY BookingDate DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvRecentBookings.DataSource = dt;
                    gvRecentBookings.DataBind();
                }
            }
        }
    }
}
