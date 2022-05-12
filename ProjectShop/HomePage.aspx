<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="ProjectShop.HomePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 27px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpUname" runat="server">
    <asp:Label ID="lblUname" runat="server" Font-Bold="True"></asp:Label>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid ">

        <asp:Panel ID="Panel1" runat="server">
        <div class="m-4" style="float:right; display:inline;">
    <Table ID="Table1" runat="server" >
       <thead><caption>Login Form</caption></thead>
        <tr>
            <td>
                Email:
            </td>
            <td class="mb-4" style="margin:15px;">
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                Password:
            </td>
            <td class="auto-style1 mb-4" style="margin:15px;">
                <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" TabIndex="1"></asp:TextBox></td>
        </tr>
        <tr>
            <td>

                &nbsp;</td>
            <td>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" TabIndex="2" />
                <br />
                <br />
                <asp:Label ID="lblMsg" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </Table>
            </div>
            </asp:Panel>
        <span class="m-4" style="display:inline; float:right;">
        <asp:Panel ID="Panel2" runat="server">
            
            <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" Font-Size="Large" OnClick="LinkButton1_Click">Logout</asp:LinkButton></asp:Panel></span>
        <span class="m-4" style="display:inline; margin-left:52px;">
        <asp:DataList ID="catLists" runat="server" Height="241px" OnSelectedIndexChanged="DataList1_SelectedIndexChanged" Width="36px" CellPadding="10" ForeColor="#333333" CellSpacing="17" RepeatColumns="5" margin-left="14" >
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#EFF3FB" />

            <ItemTemplate>
               <SPAN> <asp:Image ID="catImg" runat="server" Height="111px" Width="157px" ImageUrl='<%# Eval("ImageUrl") %>' /></SPAN><br /><br />
                 <div>  &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; </div>
                
                <br />
                &nbsp; &nbsp; &nbsp;<span>
                    </span>
                <asp:LinkButton ID="lnkCatBtn" runat="server" Text='<%# Eval("Category") %>' OnClick="lnkCatBtn_Click" CommandArgument='<%# Eval("catid") %>'></asp:LinkButton>
            </ItemTemplate>

            <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SeparatorStyle BorderColor="Black" BorderStyle="Solid" BackColor="Black" BorderWidth="2px" />
        </asp:DataList>

        <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:myshop %>" SelectCommand="SELECT [catid], [category], [img] FROM [categoryList]"></asp:SqlDataSource>
            </span>
        </div>

</asp:Content>

