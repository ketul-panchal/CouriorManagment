using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CourierManagementSystem
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

            LoadDashboardStats();
        }

        private void LoadDashboardStats()
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Total Couriers
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Couriers", conn))
                {
                    lblTotalCouriers.Text = cmd.ExecuteScalar().ToString();
                }

                // Pending Deliveries
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Couriers WHERE Status='Pending'", conn))
                {
                    lblPendingDeliveries.Text = cmd.ExecuteScalar().ToString();
                }

                // Completed Deliveries
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Couriers WHERE Status='Delivered'", conn))
                {
                    lblCompletedDeliveries.Text = cmd.ExecuteScalar().ToString();
                }
            }
        }
    }
}
