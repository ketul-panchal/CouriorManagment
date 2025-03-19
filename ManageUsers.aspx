<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="CourierManagementSystem.ManageUsers" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Courier Management System</title>
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
                <li><a href="ManageUsers.aspx" class="active">Manage Users</a></li>
                <li><a href="UpdateStatus.aspx">Update Status</a></li>
                <li><a href="Login.aspx">Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Manage Users</h1>

            <form id="form1" runat="server">
                <asp:HiddenField ID="hfUserID" runat="server" />

                <!-- User Input Fields -->
                <div class="input-group">
                    <label>Name:</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Email:</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Password:</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" required></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Role:</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="input-field">
                        <asp:ListItem Value="Admin">Admin</asp:ListItem>
                        <asp:ListItem Value="Employee">Employee</asp:ListItem>
                        <asp:ListItem Value="Customer">Customer</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Buttons -->
                <asp:Button ID="btnAddUser" runat="server" Text="Add User" CssClass="btn" OnClick="btnAddUser_Click" />
                <asp:Button ID="btnUpdateUser" runat="server" Text="Update User" CssClass="btn update-btn" Visible="False" OnClick="btnUpdateUser_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>

                <!-- Users Table -->
                <h2>Registered Users</h2>
                <asp:Panel ID="Panel1" CssClass="grid-container" runat="server">
                    <asp:GridView ID="gvUsers" runat="server" CssClass="grid-view"
                        AutoGenerateColumns="False"
                        DataKeyNames="UserID"
                        OnRowEditing="gvUsers_RowEditing"
                        OnRowUpdating="gvUsers_RowUpdating"
                        OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                        OnRowDeleting="gvUsers_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="User ID" ReadOnly="True" />
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Role" HeaderText="Role" />

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
