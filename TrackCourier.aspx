<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrackCourier.aspx.cs" Inherits="CourierManagementSystem.TrackCourier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Courier - Courier Management System</title>
    <link rel="stylesheet" href="Assets/style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Courier System</h2>
            <ul>
                <li><a href="Dashboard.aspx">Dashboard</a></li>
                <li><a href="BookCourier.aspx">Book Courier</a></li>
                <li><a href="TrackCourier.aspx" class="active">Track Courier</a></li>
                <li><a href="ManageUsers.aspx">Manage Users</a></li>
                <li><a href="UpdateStatus.aspx">Update Status</a></li>
                <li><a href="Login.aspx">Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Track a Courier</h1>

            <form id="form1" runat="server">
                <div class="input-group">
                    <label>Enter Tracking ID:</label>
                    <asp:TextBox ID="txtTrackingID" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <asp:Button ID="btnTrack" runat="server" Text="Track Courier" CssClass="btn" OnClick="btnTrack_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>

                <!-- Display Tracking Details -->
                <asp:Panel ID="pnlTrackingResult" runat="server" CssClass="tracking-result" Visible="False">
                    <h2>Tracking Details</h2>
                    <asp:GridView ID="gvTrackingDetails" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="TrackingID" HeaderText="Tracking ID" />
                            <asp:BoundField DataField="SenderName" HeaderText="Sender" />
                            <asp:BoundField DataField="ReceiverName" HeaderText="Receiver" />
                            <asp:BoundField DataField="ParcelWeight" HeaderText="Weight (kg)" />
                            <asp:BoundField DataField="DeliveryType" HeaderText="Type" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" DataFormatString="{0:yyyy-MM-dd}" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </form>
        </div>
    </div>
</body>
</html>
