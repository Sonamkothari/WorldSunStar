<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AddMenu.aspx.cs" Inherits="RolesModule.AddMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table width="100%">
        <tr>
            <td>
                Role
            </td>
            <td>
                <asp:DropDownList ID="DrpRoles" Width="150px" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Menu Name
            </td>
            <td>
                <asp:TextBox ID="TxtMenuname" Width="150px" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Menu Url
            </td>
            <td>
                <asp:TextBox ID="txtmenuURL" Width="450px" runat="server"></asp:TextBox>
                <br />
                <span style="color: Red;">E.g How to Enter Path for URL ../foldername/your page name</span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="Save" runat="server" Text="Save" OnClick="Save_Click" />
            </td>
        </tr>
    </table>
    <br />
    <table width="100%">
        <tr>
            <td>
                <asp:GridView ID="GVmenu" runat="server" Width="40%" AutoGenerateColumns="False"
                    CellPadding="4" ForeColor="#333333" GridLines="None" 
                    OnRowCommand="GVmenu_RowCommand" AllowPaging="True" 
                    onpageindexchanging="GVmenu_PageIndexChanging">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="MenuID" HeaderText="MenuID" SortExpression="MenuID" />
                        <asp:BoundField DataField="MenuName" HeaderText="MenuName" SortExpression="MenuName" />
                        <asp:BoundField DataField="MenuURL" HeaderText="MenuURL" SortExpression="MenuURL" />
                        <asp:BoundField DataField="RolesName" HeaderText="RolesName" SortExpression="RolesName" />
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:Button ID="Delete" runat="server" CommandName="Deleterole" CommandArgument='<%#Eval("MenuID")%>'
                                    Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
