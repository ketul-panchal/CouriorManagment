<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="CourierManagementSystem.Register" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Courier Management System</title>
    <link rel="stylesheet" href="Assets/style.css">
</head>
<body>
    <div class="register-container">
        <div class="register-box">
            <h2>Create an Account</h2>
            <p class="subtitle">Fill in the details below</p>

            <form id="form1" runat="server">
                <div class="input-group">
                    <label>Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="input-field" Placeholder="Enter Full Name"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" Placeholder="Enter Email"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" Placeholder="Create Password"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" OnClick="btnRegister_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message"></asp:Label>

                <p class="login-link">Already have an account? <a href="Login.aspx">Login here</a></p>
            </form>
        </div>
    </div>
</body>
</html>
