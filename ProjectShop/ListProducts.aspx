<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ListProducts.aspx.cs" Inherits="ProjectShop.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpUname" runat="server">
    <asp:Label ID="lblUname" runat="server" Font-Bold="True"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CpLogin" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <div style="margin-left:15px; display:inline;float:left;">
   List Of Products from:  <asp:Label ID="lblCategory" runat="server" Font-Bold="True" Font-Size="Medium" Width="250px"></asp:Label>
        <span>
            <asp:Label ID="lblCount" runat="server" Text=""></asp:Label></span> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <span>
            <asp:LinkButton ID="lnkCart" runat="server" OnClick="lnkCart_Click">Cart</asp:LinkButton></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <span>
            <asp:LinkButton ID="lnkHome" runat="server" OnClick="lnkHome_Click">Home</asp:LinkButton></span>
        </div>
&nbsp;
    <hr />
    <div>
    <span class="m-4" style="display:inline; float:left; padding-right:5px;">
        <asp:CheckBoxList ID="CheckBoxList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged"></asp:CheckBoxList>
    </span>

        <span style="display:inline;margin-left:22px; float:left; border-left:solid 2px black; padding-right:10px; padding-left:10px;">
            <asp:DataList ID="DataList1" runat="server" CellPadding="4" ForeColor="#333333" OnSelectedIndexChanged="DataList1_SelectedIndexChanged" CellSpacing="10" RepeatColumns="3" RepeatDirection="Horizontal" Height="537px" Width="563px">
                <AlternatingItemStyle BackColor="White" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <ItemStyle BackColor="#E3EAEB" />
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="155px" Width="175px" ImageUrl='<%# Eval("ImageURL") %>' />
                    
                    <br />
                    <br />
                    <asp:Label ID="lblProdName" runat="server" Text='<%# Eval("pname") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendor") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price") %>'></asp:Label>
                    <br />
                    <asp:LinkButton ID="btnBuy" runat="server" OnClick="btnBuy_Click" CommandArgument='<%# Eval("pid") %>'>Buy</asp:LinkButton>
                    
                </ItemTemplate>
                <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        </asp:DataList>
            </span>
       
        
    </div>
     <div style="float:right; display:inline; height: 212px; margin-left: 0px; margin-top: 0px;margin-right:15px; border:solid black 2px;">
            <asp:Panel ID="Panel1" runat="server" Height="211px" Width="253px" HorizontalAlign="Justify" ViewStateMode="Enabled" BorderColor="Black" BorderStyle="Solid">
             &nbsp;   &nbsp; <asp:Label ID="lblProduct" runat="server"></asp:Label>
                <br />
                <br />
                &nbsp; &nbsp; <asp:Label ID="lblVendor" runat="server"></asp:Label>
                <br />
                <br />
                &nbsp; &nbsp; <asp:Label ID="lblCost" runat="server"></asp:Label>
                <br />
                <br />
            Quantity: <asp:TextBox ID="txtQty" runat="server"></asp:TextBox>
                <br />
                <br />
               &nbsp; &nbsp;  <asp:Button ID="btnSave" runat="server" Text="Save" Height="26px" Width="95px" OnClick="btnSave_Click" CommandArgument="Eval(&quot;p.pid&quot;)" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
            </asp:Panel>
        </div>
</asp:Content>
