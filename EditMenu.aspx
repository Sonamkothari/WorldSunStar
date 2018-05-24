<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="EditMenu.aspx.cs" Inherits="RolesModule.EditMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table width="100%">
        <tr>
            <td>
                Role
            </td>
            <td>
                <asp:DropDownList ID="DrpRoles" Width="150px" runat="server" AppendDataBoundItems="True"
                    AutoPostBack="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                User Name
            </td>
            <td>
                <asp:DropDownList ID="DrpUser" Width="150px" AppendDataBoundItems="True" runat="server"
                    AutoPostBack="True" OnSelectedIndexChanged="DrpUser_SelectedIndexChanged">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView AutoGenerateColumns="False" BackColor="White" GridLines="None" BorderColor="#CC9966"
                    BorderStyle="None" BorderWidth="1px" CellPadding="4" ID="GridView1" runat="server"
                    Width="100%" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Menu Name">
                            <ItemTemplate>
                                <asp:HiddenField ID="HDmenuID" Value='<%#Eval("MenuID") %>' runat="server" />
                                <asp:Label ID="lblMenuName" runat="server" Text='<%#Eval("MenuName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Read">
                            <ItemTemplate>
                                <asp:CheckBox ID="CHKR" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Write">
                            <ItemTemplate>
                                <asp:CheckBox ID="CHKW" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Both">
                            <ItemTemplate>
                                <asp:CheckBox ID="CHKB" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:GridView ID="GridView2" Width="70%" AutoGenerateColumns="False" runat="server"
                                            CellPadding="4" ForeColor="#333333" GridLines="None">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:TemplateField HeaderStyle-Width="250px" HeaderText="SubMenu Name">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="HDsubmenuID" Value='<%#Eval("SubmenuID") %>' runat="server" />
                                                        <asp:Label ID="lblsubmenu" runat="server" Text='<%#Eval("SubmenuName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="250px"></HeaderStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-Width="250px" HeaderText="SubMenuURL">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("SubMenuURL") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="250px"></HeaderStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Read">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="CHKRSUB" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Write">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="CHKWSUB" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Both">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="CHKBSUB" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EditRowStyle BackColor="#7C6F57" />
                                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                            <RowStyle BackColor="#E3EAEB" />
                                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                            <SortedAscendingCellStyle BackColor="#F8FAFA" />
                                            <SortedAscendingHeaderStyle BackColor="#246B61" />
                                            <SortedDescendingCellStyle BackColor="#D4DFE1" />
                                            <SortedDescendingHeaderStyle BackColor="#15524A" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <SortedAscendingCellStyle BackColor="#FEFCEB" />
                    <SortedAscendingHeaderStyle BackColor="#AF0101" />
                    <SortedDescendingCellStyle BackColor="#F6F0C0" />
                    <SortedDescendingHeaderStyle BackColor="#7E0000" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="Button1" runat="server" Text="Save Role Assign" OnClick="Button1_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
