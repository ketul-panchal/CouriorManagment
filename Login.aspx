<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="CourierManagementSystem.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Courier Management System</title>
    <link rel="stylesheet" href="Assets/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h2>Courier Management System</h2>
            <p class="subtitle">Secure Login</p>

            <form id="form1" runat="server">
                <div class="input-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" Placeholder="Enter Email"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" Placeholder="Enter Password"></asp:TextBox>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>

                <p class="register-link">Don't have an account? <a href="Register.aspx">Register here</a></p>
            </form>
        </div>
    </div>
</body>
</html>
