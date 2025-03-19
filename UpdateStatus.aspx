<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateStatus.aspx.cs" Inherits="CourierManagementSystem.UpdateStatus" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Courier Status - Courier Management System</title>
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
                <li><a href="TrackCourier.aspx">Track Courier</a></li>
                <li><a href="ManageUsers.aspx">Manage Users</a></li>
                <li><a href="UpdateStatus.aspx" class="active">Update Status</a></li>
                <li><a href="Login.aspx">Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Update Courier Status</h1>

            <form id="form1" runat="server">
                <div class="input-group">
                    <label>Enter Tracking ID:</label>
                    <asp:TextBox ID="txtTrackingID" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <asp:Button ID="btnSearch" runat="server" Text="Search Courier" CssClass="btn" OnClick="btnSearch_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>

                <!-- Display Courier Details -->
                <asp:Panel ID="pnlCourierDetails" runat="server" CssClass="tracking-result" Visible="False">
                    <h2>Courier Details</h2>
                    <asp:GridView ID="gvCourierDetails" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="TrackingID" HeaderText="Tracking ID" />
                            <asp:BoundField DataField="SenderName" HeaderText="Sender" />
                            <asp:BoundField DataField="ReceiverName" HeaderText="Receiver" />
                            <asp:BoundField DataField="Status" HeaderText="Current Status" />
                        </Columns>
                    </asp:GridView>

                    <div class="input-group">
                        <label>Update Status:</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="input-field">
                            <asp:ListItem Value="Picked Up">Picked Up</asp:ListItem>
                            <asp:ListItem Value="In Transit">In Transit</asp:ListItem>
                            <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <asp:Button ID="btnUpdateStatus" runat="server" Text="Update Status" CssClass="btn update-btn" OnClick="btnUpdateStatus_Click" />
                </asp:Panel>
            </form>
        </div>
    </div>
</body>
</html>
