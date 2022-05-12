<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ProjectShop.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpUname" runat="server">
    <asp:Label ID="lblUname" runat="server" Font-Bold="True"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CpLogin" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
        <span class="m-4" style="float:left; margin-left:52px; margin-left:52px;">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label></span>
            <span style="float:right; margin-right:52px;">
        <asp:LinkButton ID="btnHome" runat="server" OnClick="btnHome_Click">Home</asp:LinkButton></span>
    </div>

    <div class="m-4" style=" display:inline; margin-left:52px; margin-top:52px;">
    <asp:GridView AutoGenerateColumns="False" ID="GridView1" runat="server" CellPadding="4"   ForeColor="#333333" GridLines="None" TabIndex="2" Width="133px" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Product Id" HeaderText="Product ID" SortExpression="Product Id" />
            <asp:BoundField DataField="Product" HeaderText="Product" />
            <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" />
            <asp:BoundField DataField="Product Cost" HeaderText="Cost" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" />
            <asp:TemplateField HeaderText="Edit Quantity">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" Height="15px" ImageUrl="~/Icons/edit.png" Width="15px" CommandArgument='<%# Eval("Quantity") %>' OnClick="ImageButton1_Click" OnDataBinding="Quantity" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete Item">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" Height="15px" ImageUrl="~/Icons/del.png" Width="15px" OnClick="ImageButton2_Click1" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
      <%--  <EmptyDataTemplate>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <br />
            <asp:ImageButton ID="ImageButton1" runat="server" Height="25px" ImageUrl="~/Icons/edit.png" OnClick="ImageButton1_Click" Width="25px" />
            <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/Icons/del.png" OnClick="ImageButton2_Click" Width="25px" />
        </EmptyDataTemplate>
       --%>
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
        <br />
        <br />
        <span class="m-4">
       Total Purchase Amount:  <asp:Label ID="lblTotalAmt" runat="server" Text=""></asp:Label>
        <br />
            </span><span class="m-4">
        <asp:LinkButton ID="btnPay" runat="server" OnClick="btnPay_Click">Proceed to payments</asp:LinkButton>
        </span>

    </div> <br />
    <asp:Panel ID="PanelQty" runat="server">
    <div style="display:inline; float:right; margin-right:52px; " id="Upd" >
        Enter Quantity: <asp:TextBox ID="txtQty" runat="server"></asp:TextBox><br />
        <asp:Button ID="btnUpdateQty" runat="server" Text="Save Quantity" OnClick="btnUpdateQty_Click" />
    </div> </asp:Panel>
</asp:Content>
