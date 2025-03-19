<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="CourierManagementSystem.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Courier System</title>
    <link rel="stylesheet" href="Assets/style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <ul>
          <li><a href="Dashboard.aspx">Dashboard</a></li>
                <li><a href="BookCourier.aspx">Book Courier</a></li>
                <li><a href="TrackCourier.aspx">Track Courier</a></li>
                <li><a href="ManageUsers.aspx" class="active">Manage Users</a></li>
                <li><a href="UpdateStatus.aspx">Update Status</a></li>
                <li><a href="Login.aspx">Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Welcome, Admin</h1>
                <p>Manage couriers, track parcels, and update deliveries.</p>
            </div>

            <!-- Stats Section -->
            <div class="stats-container">
                <div class="stat-box">
                    <h3>Total Couriers</h3>
                    <asp:Label ID="lblTotalCouriers" runat="server" CssClass="stat-number"></asp:Label>
                </div>
                <div class="stat-box">
                    <h3>Pending Deliveries</h3>
                    <asp:Label ID="lblPendingDeliveries" runat="server" CssClass="stat-number"></asp:Label>
                </div>
                <div class="stat-box">
                    <h3>Completed Deliveries</h3>
                    <asp:Label ID="lblCompletedDeliveries" runat="server" CssClass="stat-number"></asp:Label>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="BookCourier.aspx" class="action-btn">📦 Book New Courier</a>
                <a href="TrackCourier.aspx" class="action-btn">🔍 Track a Parcel</a>
                <a href="ManageUsers.aspx" class="action-btn">👤 Manage Users</a>
            </div>
        </div>
    </div>
</body>
</html>
