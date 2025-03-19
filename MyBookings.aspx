<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyBookings.aspx.cs" Inherits="CourierManagementSystem.MyBookings" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Courier Management System</title>
    <link rel="stylesheet" href="Assets/style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Courier System</h2>
            <ul>
                <li><a href="UserDashboard.aspx">Home</a></li>
                <li><a href="UserBookCourier.aspx">Book a Courier</a></li>
                <li><a href="UserTrackCourier.aspx">Track Courier</a></li>
                <li><a href="MyBookings.aspx" class="active">My Bookings</a></li>
                <li><a href="Login.aspx">Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>My Courier Bookings</h1>

            <form id="form1" runat="server">
                <asp:GridView ID="gvMyBookings" runat="server" CssClass="grid-view"
                    AutoGenerateColumns="False"
                    DataKeyNames="CourierID">
                    <Columns>
                        <asp:BoundField DataField="TrackingID" HeaderText="Tracking ID" ReadOnly="True" />
                        <asp:BoundField DataField="ReceiverName" HeaderText="Receiver" />
                        <asp:BoundField DataField="ParcelWeight" HeaderText="Weight (kg)" />
                        <asp:BoundField DataField="DeliveryType" HeaderText="Type" />
                        <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />
                        <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" DataFormatString="{0:yyyy-MM-dd}" ReadOnly="True" />
                    </Columns>
                </asp:GridView>

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>
            </form>
        </div>
    </div>
</body>
</html>
