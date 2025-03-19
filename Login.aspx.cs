using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CourierManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = ""; // Clear error messages on page load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT UserID, Role FROM Users WHERE Email=@Email AND Password=@Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // Store user session
                        Session["UserID"] = reader["UserID"].ToString();
                        Session["UserRole"] = reader["Role"].ToString();

                        // Redirect based on role
                        string role = reader["Role"].ToString();
                        if (role == "Admin")
                            Response.Redirect("Dashboard.aspx");
                        else
                            Response.Redirect("UserDashboard.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password!";
                    }
                }
            }
        }
    }
}
