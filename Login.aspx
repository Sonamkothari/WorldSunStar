<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RolesModule.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding-left: 45%; padding-top:20%;">
        <table>
            <tr>
                <td>
                    Username
                </td>
                <td>
                    <asp:TextBox ID="TxtUsername" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Password
                </td>
                <td>
                    <asp:TextBox ID="TxtPassword" runat="server" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnsave" runat="server" Text="Login" OnClick="btnsave_Click" />

                     <asp:Button ID="btnReg" runat="server" Text="Register" 
                        onclick="btnReg_Click"  />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
