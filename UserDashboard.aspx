<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDashboard.aspx.cs" Inherits="CourierManagementSystem.UserDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Courier Management System</title>
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
            <form id="form1" runat="server">
                <h1>Welcome, <asp:Label ID="lblUserName" runat="server" Text="User"></asp:Label>!</h1>

                <div class="dashboard-cards">
                    <div class="card">
                        <h2>Total Bookings</h2>
                        <p><asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label></p>
                    </div>
                    <div class="card">
                        <h2>Pending Deliveries</h2>
                        <p><asp:Label ID="lblPendingDeliveries" runat="server" Text="0"></asp:Label></p>
                    </div>
                    <div class="card">
                        <h2>Delivered Couriers</h2>
                        <p><asp:Label ID="lblDeliveredCouriers" runat="server" Text="0"></asp:Label></p>
                    </div>
                </div>

                <h2>Recent Bookings</h2>
                <asp:GridView ID="gvRecentBookings" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="TrackingID" HeaderText="Tracking ID" />
                        <asp:BoundField DataField="ReceiverName" HeaderText="Receiver" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" DataFormatString="{0:yyyy-MM-dd}" />
                    </Columns>
                </asp:GridView>
            </form>
        </div>
    </div>
</body>
</html>
