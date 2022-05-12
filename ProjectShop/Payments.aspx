<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Payments.aspx.cs" Inherits="ProjectShop.Payments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpUname" runat="server">
    <asp:Label ID="lblUname" runat="server" Font-Bold="True"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CpLogin" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="m-5 alert-heading">
       Address: <asp:Label ID="lblAddress" runat="server" Font-Bold="True"></asp:Label>
        <span style="float:right; margin-right:32px; ">
      <asp:Panel ID="Panel3" runat="server"> <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Logout</asp:LinkButton></asp:Panel> </span>
    </div>
    <br />
    &nbsp;
   <div style="display:inline;float:left; margin-left:52px;">
       <asp:Panel ID="Panel1" runat="server">

           Total Bill Amount: <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="True"></asp:Label>
           <br />
           <br />
           <asp:RadioButtonList ID="rdPaymentOptions" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdPaymentOptions_SelectedIndexChanged" CellPadding="1" CellSpacing="1"></asp:RadioButtonList>
           <br />
           <asp:Button ID="btnConfirm" runat="server" Text="Confirm Order" Height="28px" Width="141px" OnClick="btnConfirm_Click" />


           &nbsp;
           <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" Width="116px" />


       </asp:Panel>
   </div>
    <div style="display:inline; float:right; margin-right:52px; padding:10px;">
        <asp:Panel ID="Panel2" runat="server">
            <asp:LinkButton ID="lnkBtnCart" runat="server" OnClick="lnkBtnCart_Click">Edit Cart Items</asp:LinkButton><br />
            <asp:LinkButton ID="lnkBtnHome" runat="server" OnClick="LinkButton2_Click">Buy More Items</asp:LinkButton><br />
            <asp:Label ID="lblEmptyCart" runat="server" ForeColor="#FF3300"></asp:Label>
        </asp:Panel>
    </div>

    <div>
        <center>
            <asp:Label ID="lblMsg" runat="server"></asp:Label></center>
    </div>
</asp:Content>
