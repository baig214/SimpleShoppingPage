using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace ProjectShop
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblCategory.Text = Request.QueryString["category"].ToString();
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["myshop"].ToString();
            if (!IsPostBack)
            {
                DisplayProducts(Convert.ToInt32(Request.QueryString["catid"]));
                ListVendors(Convert.ToInt32(Request.QueryString["catid"]));
                Panel1.Visible = false;
                if (Session["cart"] == null)
                {
                    Cart();
                }
                else
                {
                    DisplayQuantity((DataTable)Session["cart"]);
                }
            }
            if (Session["loggedInUser"] != null)
            {
                lblUname.Text = Session["name"].ToString();
            }
        }

        protected void lnkHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void btnBuy_Click(object sender, EventArgs e)
        {
            //
            Panel1.Visible = true;
            LinkButton btn = (LinkButton)sender;
            lblProduct.Text = ((Label)btn.Parent.FindControl("lblProdName")).Text;
            lblVendor.Text = ((Label)btn.Parent.FindControl("lblVendor")).Text;
            lblCost.Text = ((Label)btn.Parent.FindControl("lblPrice")).Text;
            btnSave.CommandArgument = btn.CommandArgument;
        }

        protected void lnkCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        void ListVendors(int catId)
        {
            SqlDataAdapter da = new SqlDataAdapter("select * from vendors where vid in (select vendorid from product where catid=" + Convert.ToInt32(catId) + ")", con);
            DataTable dtVendors = new DataTable();
            da.Fill(dtVendors);
            CheckBoxList1.DataSource = dtVendors;
            CheckBoxList1.DataTextField = "vendor";
            CheckBoxList1.DataValueField = "vid";

            CheckBoxList1.DataBind();
        }

        private void DisplayQuantity(DataTable dtCart)
        {
            int totalQty = 0;
            foreach (DataRow dr in dtCart.Rows)
            {
                totalQty = totalQty + Convert.ToInt32(dr[4]);
            }
            Session["cart"] = dtCart;
            lblCount.Text = totalQty.ToString();
        }

        void DisplayProducts(int catId)
        {
            SqlDataAdapter da = new SqlDataAdapter("Select p.pid[pid], p.pname[pname], v.vendor[vendor], p.price[price],'~/Images/Product/'+[pname]+'.jpg'[ImageURL] from product p inner join vendors v on v.vid=p.vendorid where p.catid=" + catId, con);
            DataTable dtProducts = new DataTable();
            da.Fill(dtProducts);
            DataList1.DataSource = dtProducts;
            DataList1.DataBind();
        }

        void Cart()
        {
            DataTable dtCart = new DataTable();
            dtCart.Columns.Add("Product Id", typeof(int));
            dtCart.Columns.Add("Product", typeof(string));
            dtCart.Columns.Add("Manufacturer", typeof(string));
            dtCart.Columns.Add("Product Cost", typeof(double));
            dtCart.Columns.Add("Quantity", typeof(int));
            dtCart.Columns.Add("Amount", typeof(double));

            Session["cart"] = dtCart; 
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string vendorlist = "";
            foreach (ListItem c in CheckBoxList1.Items)
            {
                if (c.Selected)
                {
                    vendorlist = vendorlist + "'" + c.Text + "',";
                }

            }
            if (!String.IsNullOrEmpty(vendorlist))
            {
                ListSelectedVendorProducts(Convert.ToInt32(Request.QueryString["catid"]), vendorlist);
            }
            else
            {
                DisplayProducts(Convert.ToInt32(Request.QueryString["catid"]));
            }
        }

        void ListSelectedVendorProducts(int catId, string vendorlist)
        {

            SqlDataAdapter da = new SqlDataAdapter("Select p.pid, p.pname, v.vendor, p.price,'~/Images/Product/'+p.pname+'.jpg'[ImageURL] from product p inner join vendors v on v.vid=p.vendorid where p.catid=" + catId + " and v.vendor  in (" + vendorlist.Remove(vendorlist.LastIndexOf(",")) + ")", con);
            DataTable dtProducts = new DataTable();
            da.Fill(dtProducts);
            DataList1.DataSource = dtProducts;
            DataList1.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DataTable dtCart = (DataTable)Session["cart"];
            DataRow[] itemInCart = dtCart.Select("[Product Id]=" + Convert.ToInt32(btnSave.CommandArgument));
            if (itemInCart.Length == 0)
            {
                DataRow r = dtCart.NewRow();
                r[0] = Convert.ToInt32(btnSave.CommandArgument);
                r[1] = lblProduct.Text;
                r[2] = lblVendor.Text;
                r[3] = Convert.ToDouble(lblCost.Text);
                r[4] = Convert.ToInt32(txtQty.Text);
                r[5] = (Convert.ToDouble(lblCost.Text) * Convert.ToInt32(txtQty.Text)).ToString();
                dtCart.Rows.Add(r);
            }
            else
            {
                itemInCart[0][4] = Convert.ToInt32(itemInCart[0][4]) + Convert.ToInt32(txtQty.Text);
            }
            DisplayQuantity(dtCart);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
        }
    }
}