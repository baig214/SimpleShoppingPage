using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ProjectShop
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {   
                if (Session["cart"] != null && ((DataTable)Session["cart"]).Rows.Count > 0)
                {
                    DisplayCart();
                    ViewState["selectedRowIndex"] = -1;
                   

                }
                else
                {
                    lblMsg.Text = "No item(s) available in the cart";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            if (Session["loggedInUser"] != null)
            {
                PanelQty.Visible = false;
                lblUname.Text = Session["name"].ToString();
            }
           
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        private void DisplayCart()
        {
            double totalAmount = 0.0D;
            GridView1.DataSource = (DataTable)Session["cart"];
            GridView1.DataBind();
            DataTable dtCart = (DataTable)Session["cart"];
            foreach (DataRow r in dtCart.Rows)
            {
                totalAmount = totalAmount + Convert.ToDouble(r[5].ToString());
            }
            lblTotalAmt.Text = totalAmount.ToString();
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (Session["loggedInUser"] != null)
            {
                Response.Redirect("Payments.aspx");
            }
            else
            {
                
                Response.Redirect("HomePage.aspx?source=Payments");
            }
        }

       
                //protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    ImageButton btn = (ImageButton)sender;
        //    GridViewRow selectedRow = (GridViewRow)btn.Parent.Parent;
        //    selectedRow.BorderColor = System.Drawing.Color.Green;
        //    foreach (GridViewRow r in GridView1.Rows)
        //    {
        //        r.ForeColor = System.Drawing.Color.Black;
        //    }
        //    selectedRow.ForeColor = System.Drawing.Color.Red;
        //    txtQty.Text = ((Label)selectedRow.FindControl("Label5")).Text;
        //    //selectedRowIndex = selectedRow.RowIndex;
        //    ViewState["selectedRowIndex"] = selectedRow.RowIndex;
        //}

        protected void btnUpdateQty_Click(object sender, EventArgs e)
        {
            int selectedRowIndex = Convert.ToInt32(ViewState["selectedRowIndex"]);
            DataTable dt = (DataTable)Session["cart"];
            dt.Rows[selectedRowIndex][4] = Convert.ToInt32(txtQty.Text);
            dt.Rows[selectedRowIndex][5] = Convert.ToDouble(Convert.ToInt32(txtQty.Text)*Convert.ToDouble(dt.Rows[selectedRowIndex][3]));
            Session["cart"] = dt;
            DisplayCart();
            txtQty.Text = "";
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            PanelQty.Visible = true;
            ImageButton btn = (ImageButton)sender;
            GridViewRow selectedRow = (GridViewRow)btn.Parent.Parent;
            selectedRow.BorderColor = System.Drawing.Color.Green;
            foreach (GridViewRow r in GridView1.Rows)
            {
                r.ForeColor = System.Drawing.Color.Black;
            }
            selectedRow.ForeColor = System.Drawing.Color.Red;
            //txtQty.Text = ((Label)selectedRow.FindControl("Quantity")).Text;
            //selectedRowIndex = selectedRow.RowIndex;
            ViewState["selectedRowIndex"] = selectedRow.RowIndex;
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow selectedRow = (GridViewRow)btn.Parent.Parent;
            DataTable dt = (DataTable)Session["cart"];
            dt.Rows.RemoveAt(selectedRow.RowIndex);

            Session["cart"] = dt;
            DisplayCart();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           

            //if(e.CommandName=="edit")
            //{
            //   // ButtonField btn = (ButtonField)sender;
            //  ImageButton btn = (ImageButton)sender;
            //   GridViewRow selectedRow = (GridViewRow)btn.Parent.Parent;
            //   selectedRow.BorderColor = System.Drawing.Color.Green;
            //    foreach (GridViewRow r in GridView1.Rows)
            //    {
            //        r.ForeColor = System.Drawing.Color.Black;
            //    }
            //    selectedRow.ForeColor = System.Drawing.Color.Red;
            //    txtQty.Text = ((Label)selectedRow.FindControl("Label5")).Text;
            //    //selectedRowIndex = selectedRow.RowIndex;
            //    ViewState["selectedRowIndex"] = selectedRow.RowIndex;
            //}
            //else if(e.CommandName=="Update")
            //{
            //    ImageButton btn = (ImageButton)sender;
            //    GridViewRow selectedRow = (GridViewRow)btn.Parent.Parent;
            //    DataTable dt = (DataTable)Session["cart"];
            //    dt.Rows.RemoveAt(selectedRow.RowIndex);

            //    Session["cart"] = dt;
            //    DisplayCart();
            //}
        }

        protected void ImageButton2_Click1(object sender, ImageClickEventArgs e)
        {
             ImageButton btn = (ImageButton)sender;
            GridViewRow selectedRow = (GridViewRow)btn.Parent.Parent;
            DataTable dt = (DataTable)Session["cart"];
            dt.Rows.RemoveAt(selectedRow.RowIndex);

            Session["cart"] = dt;
            DisplayCart();
        }

        protected void Quantity(object sender, EventArgs e)
        {

        }
    }
}