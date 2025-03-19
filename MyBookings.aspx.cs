using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;

namespace CourierManagementSystem
{
    public partial class MyBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserBookings();
            }
        }

        private void LoadUserBookings()
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Couriers WHERE CustomerID=@UserID ORDER BY BookingDate DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvMyBookings.DataSource = dt;
                        gvMyBookings.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "⚠ No bookings found.";
                    }
                }
            }
        }
    }
}
