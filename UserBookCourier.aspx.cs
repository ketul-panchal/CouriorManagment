using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;

namespace CourierManagementSystem
{
    public partial class BookCourier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourierBookings();
            }
        }

        protected void btnBookCourier_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]); // Get logged-in user ID
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            // Generate Unique Tracking ID
            string trackingID = "TRK-" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(10000, 99999);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "INSERT INTO Couriers (TrackingID, SenderName, ReceiverName, SenderAddress, ReceiverAddress, ParcelWeight, DeliveryType, Status, BookingDate, CustomerID) " +
                               "VALUES (@TrackingID, @SenderName, @ReceiverName, @SenderAddress, @ReceiverAddress, @ParcelWeight, @DeliveryType, 'Pending', GETDATE(), @UserID)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TrackingID", trackingID);
                    cmd.Parameters.AddWithValue("@SenderName", txtSenderName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ReceiverName", txtReceiverName.Text.Trim());
                    cmd.Parameters.AddWithValue("@SenderAddress", txtSenderAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@ReceiverAddress", txtReceiverAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@ParcelWeight", txtParcelWeight.Text.Trim());
                    cmd.Parameters.AddWithValue("@DeliveryType", ddlDeliveryType.SelectedValue);
                    cmd.Parameters.AddWithValue("@UserID", userID); // Link to logged-in user

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "✅ Courier booked successfully! Tracking ID: " + trackingID;
                }
                LoadCourierBookings();
                ClearFields();
            }
        }


        private void LoadCourierBookings()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]); // Get logged-in user ID
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Fetch only the logged-in user's courier bookings
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Couriers WHERE CustomerID=@UserID ORDER BY BookingDate DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvCouriers.DataSource = dt;
                    gvCouriers.DataBind();
                }
            }
        }


        // Handles Editing of Courier in GridView
        protected void gvCouriers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCouriers.EditIndex = e.NewEditIndex;
            LoadCourierBookings();
        }

        // Handles Updating of Edited Couriers
        protected void gvCouriers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvCouriers.Rows[e.RowIndex];
            int courierID = Convert.ToInt32(gvCouriers.DataKeys[e.RowIndex].Value);

            // Extract updated values from the row
            string senderName = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
            string receiverName = ((TextBox)row.Cells[3].Controls[0]).Text.Trim();
            string parcelWeight = ((TextBox)row.Cells[4].Controls[0]).Text.Trim();
            string deliveryType = ((TextBox)row.Cells[5].Controls[0]).Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE Couriers SET SenderName=@SenderName, ReceiverName=@ReceiverName, ParcelWeight=@ParcelWeight, DeliveryType=@DeliveryType WHERE CourierID=@CourierID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SenderName", senderName);
                    cmd.Parameters.AddWithValue("@ReceiverName", receiverName);
                    cmd.Parameters.AddWithValue("@ParcelWeight", parcelWeight);
                    cmd.Parameters.AddWithValue("@DeliveryType", deliveryType);
                    cmd.Parameters.AddWithValue("@CourierID", courierID);
                    cmd.ExecuteNonQuery();
                }
            }

            gvCouriers.EditIndex = -1; // Exit edit mode
            LoadCourierBookings();
        }

        // Handles Canceling Edit Operation
        protected void gvCouriers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCouriers.EditIndex = -1;
            LoadCourierBookings();
        }

        // Handles Deletion of a Courier
        protected void gvCouriers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]); // Logged-in user
            int courierID = Convert.ToInt32(gvCouriers.DataKeys[e.RowIndex].Value);

            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Delete only if the courier belongs to the logged-in user
                string query = "DELETE FROM Couriers WHERE CourierID=@CourierID AND CustomerID=@UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourierID", courierID);
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "✅ Booking deleted successfully!";
                    }
                    else
                    {
                        lblMessage.Text = "⚠ Error: You are not authorized to delete this booking!";
                    }
                }
                LoadCourierBookings();
            }
        }


        // Handles Row Selection for Editing
        protected void gvCouriers_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvCouriers.SelectedRow;

            if (gvCouriers.SelectedDataKey != null)
            {
                int courierID;
                if (int.TryParse(gvCouriers.SelectedDataKey.Value.ToString(), out courierID))
                {
                    int userID = Convert.ToInt32(Session["UserID"]);

                    // Verify the selected courier belongs to the logged-in user
                    string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        string query = "SELECT COUNT(*) FROM Couriers WHERE CourierID=@CourierID AND CustomerID=@UserID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@CourierID", courierID);
                            cmd.Parameters.AddWithValue("@UserID", userID);
                            int count = (int)cmd.ExecuteScalar();

                            if (count == 0)
                            {
                                lblMessage.Text = "⚠ Error: You are not authorized to edit this booking!";
                                return;
                            }
                        }
                    }

                    hfCourierID.Value = courierID.ToString();
                    txtSenderName.Text = row.Cells[2].Text.Trim();
                    txtReceiverName.Text = row.Cells[3].Text.Trim();
                    txtSenderAddress.Text = row.Cells[4].Text.Trim();
                    txtReceiverAddress.Text = row.Cells[5].Text.Trim();
                    txtParcelWeight.Text = row.Cells[6].Text.Trim();
                    ddlDeliveryType.SelectedValue = row.Cells[7].Text.Trim();

                    btnBookCourier.Visible = false;
                    btnUpdateCourier.Visible = true;
                }
                else
                {
                    lblMessage.Text = "⚠ Error: Invalid courier selected. Please try again.";
                }
            }
            else
            {
                lblMessage.Text = "⚠ Error: No courier ID found. Please select again.";
            }
        }


        protected void btnUpdateCourier_Click(object sender, EventArgs e)
        {
            int courierID;
            if (string.IsNullOrEmpty(hfCourierID.Value) || !int.TryParse(hfCourierID.Value, out courierID))
            {
                lblMessage.Text = "⚠ Error: Invalid courier ID.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE Couriers SET SenderName=@SenderName, ReceiverName=@ReceiverName, SenderAddress=@SenderAddress, ReceiverAddress=@ReceiverAddress, ParcelWeight=@ParcelWeight, DeliveryType=@DeliveryType WHERE CourierID=@CourierID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SenderName", txtSenderName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ReceiverName", txtReceiverName.Text.Trim());
                    cmd.Parameters.AddWithValue("@SenderAddress", txtSenderAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@ReceiverAddress", txtReceiverAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@ParcelWeight", txtParcelWeight.Text.Trim());
                    cmd.Parameters.AddWithValue("@DeliveryType", ddlDeliveryType.SelectedValue);
                    cmd.Parameters.AddWithValue("@CourierID", courierID);
                    cmd.ExecuteNonQuery();
                }
                LoadCourierBookings();
                ClearFields();

                btnBookCourier.Visible = true;
                btnUpdateCourier.Visible = false;
            }
        }


        // Clears Form Fields
        private void ClearFields()
        {
            txtSenderName.Text = "";
            txtReceiverName.Text = "";
            txtSenderAddress.Text = "";
            txtReceiverAddress.Text = "";
            txtParcelWeight.Text = "";
            ddlDeliveryType.SelectedIndex = 0;
        }
    }
}
