<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserBookCourier.aspx.cs" Inherits="CourierManagementSystem.BookCourier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Courier - Courier Management System</title>
    <link rel="stylesheet" href="Assets/style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Courier System</h2>
            <ul>
                 <li><a href="UserDashboard.aspx" class="active">Home</a></li>
                <li><a href="UserBookCourier.aspx">Book a Courier</a></li>
                <li><a href="UserTrackCourier.aspx">Track Courier</a></li>
                <li><a href="MyBookings.aspx">My Bookings</a></li>
                <li><a href="Login.aspx">Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Book a Courier</h1>

            <form id="form1" runat="server">
                <!-- Booking Form -->
                <asp:HiddenField ID="hfCourierID" runat="server" />

                <div class="input-group">
                    <label>Sender Name:</label>
                    <asp:TextBox ID="txtSenderName" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Receiver Name:</label>
                    <asp:TextBox ID="txtReceiverName" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Sender Address:</label>
                    <asp:TextBox ID="txtSenderAddress" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Receiver Address:</label>
                    <asp:TextBox ID="txtReceiverAddress" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Parcel Weight (kg):</label>
                    <asp:TextBox ID="txtParcelWeight" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Delivery Type:</label>
                    <asp:DropDownList ID="ddlDeliveryType" runat="server" CssClass="input-field">
                        <asp:ListItem Value="Standard">Standard</asp:ListItem>
                        <asp:ListItem Value="Express">Express</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <asp:Button ID="btnBookCourier" runat="server" Text="Book Courier" CssClass="btn" OnClick="btnBookCourier_Click" />
                <asp:Button ID="btnUpdateCourier" runat="server" Text="Update Courier" CssClass="btn update-btn" Visible="False" OnClick="btnUpdateCourier_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>

                <!-- Admin Panel: View & Manage Bookings -->
                <h2>Manage Bookings</h2>
                <asp:Panel ID="Panel1" CssClass="grid-container" runat="server">
                    <asp:GridView ID="gvCouriers" runat="server" CssClass="grid-view"
                        AutoGenerateColumns="False"
                        DataKeyNames="CourierID" 
                        OnRowEditing="gvCouriers_RowEditing"
                        OnRowUpdating="gvCouriers_RowUpdating"
                        OnRowCancelingEdit="gvCouriers_RowCancelingEdit"
                        OnRowDeleting="gvCouriers_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="CourierID" HeaderText="Courier ID" ReadOnly="True" />
                            <asp:BoundField DataField="TrackingID" HeaderText="Tracking ID" ReadOnly="True" />
                            <asp:BoundField DataField="SenderName" HeaderText="Sender" />
                            <asp:BoundField DataField="ReceiverName" HeaderText="Receiver" />
                            <asp:BoundField DataField="ParcelWeight" HeaderText="Weight (kg)" />
                            <asp:BoundField DataField="DeliveryType" HeaderText="Type" />
                            <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />

                            <asp:CommandField ShowEditButton="True" />
                            <asp:CommandField ShowDeleteButton="True" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </form>
        </div>
    </div>
</body>
</html>
