using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace ProjectShop
{
    public partial class Payments : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["myshop"].ToString();
            if (Session["loggedInUser"] != null)
            {
                Panel3.Visible = true;
                lblUname.Text = Session["name"].ToString();
                SqlCommand cmd = new SqlCommand("Select address from customers where cid=" + Convert.ToInt32(Session["loggedInUser"]), con);
                if (con.State == ConnectionState.Closed)
                    con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();
               lblAddress.Text = dr[0].ToString();
                dr.Close();
                if (!IsPostBack)
                {
                    LoadPaymentOptions();
                }
                TotalBillAmount();
            }
            else
            {
                Response.Redirect("HomePage.aspx");
            }
            DataTable dt = (DataTable)Session["cart"];
            if (dt.Rows.Count == 0)
            {
                Panel1.Visible = false ;
                Panel2.Visible = true;
                lblEmptyCart.Text = "The Cart is Empty";
            }
            else
            {
                Panel2.Visible = true;
                Panel1.Visible = true;
            }

        }

        void TotalBillAmount()
        {
            double totalAmount = 0.0D;

            DataTable dtCart = (DataTable)Session["cart"];
            foreach (DataRow r in dtCart.Rows)
            {
                totalAmount = totalAmount + Convert.ToDouble(r[5].ToString());
            }
            lblTotalAmount.Text = totalAmount.ToString();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void lnkBtnCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        void LoadPaymentOptions()
        {
            SqlDataAdapter da = new SqlDataAdapter("Select * from payment", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rdPaymentOptions.DataSource = dt;
            rdPaymentOptions.DataTextField = "mode";
            rdPaymentOptions.DataValueField = "modeid";
            rdPaymentOptions.DataBind();
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Closed)
                con.Open();
            SqlCommand cmdBillId = new SqlCommand("select max(billid)+1 from billMaster", con);
            int billId = (int)cmdBillId.ExecuteScalar();
            cmdBillId.Dispose();

            // transactional commands
            SqlCommand cmdAddBill = new SqlCommand("insert into billMaster values(@billid, getdate(),@cid,  @paymentMode)", con);
            SqlCommand cmdSales = new SqlCommand("insert into sales values(@pid, @qty, @billid)", con);
            SqlCommand cmdUpdate = new SqlCommand("update product set quantity=quantity-@qty where pid=@pid", con);

            // transaction
            SqlTransaction trans = con.BeginTransaction();
            cmdAddBill.Transaction = trans;
            cmdSales.Transaction = trans;
            cmdUpdate.Transaction = trans;

            try
            {
                int paymentMode = -1;
                ListItemCollection c = rdPaymentOptions.Items;

                foreach (ListItem l in rdPaymentOptions.Items)
                {
                    if (l.Selected)
                    {
                        paymentMode = Convert.ToInt32(l.Value);
                        break;
                    }
                }
                cmdAddBill.Parameters.AddWithValue("@billid", billId);
                cmdAddBill.Parameters.AddWithValue("@cid", Convert.ToInt32(Session["loggedInUser"]));
                cmdAddBill.Parameters.AddWithValue("@paymentMode", paymentMode);
                cmdAddBill.ExecuteNonQuery();

                SqlParameter paramPid = new SqlParameter("@pid", SqlDbType.Int);
                SqlParameter paramQty = new SqlParameter("@qty", SqlDbType.Int);
                SqlParameter paramBillId = new SqlParameter("@billid", SqlDbType.Int);
                cmdSales.Parameters.Add(paramPid);
                cmdSales.Parameters.Add(paramQty);
                cmdSales.Parameters.Add(paramBillId);

                paramBillId.Value = billId;
                DataTable dtCart = (DataTable)Session["cart"];
                foreach (DataRow r in dtCart.Rows)
                {
                    paramPid.Value = Convert.ToInt32(r[0]);
                    paramQty.Value = Convert.ToInt32(r[4]);
                    cmdSales.ExecuteNonQuery();
                }

                // update

                SqlParameter paramProductId = new SqlParameter("@pid", SqlDbType.Int);
                SqlParameter paramQTyPurchased = new SqlParameter("@qty", SqlDbType.Int);
                cmdUpdate.Parameters.Add(paramProductId);
                cmdUpdate.Parameters.Add(paramQTyPurchased);
                foreach (DataRow r in dtCart.Rows)
                {
                    paramProductId.Value = Convert.ToInt32(r[0]);
                    paramQTyPurchased.Value = Convert.ToInt32(r[4]);
                    cmdUpdate.ExecuteNonQuery();
                }

                // transaction is  successful
                trans.Commit();
                lblMsg.Text = "Your Order has  been Confirmed. Products will be delivered to following address: "+lblAddress.Text;
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                trans.Rollback();
                lblMsg.Text = ex.Message;
                lblMsg.Text = "Your Order has not been processed";
                lblMsg.ForeColor = System.Drawing.Color.Red;


            }
        }

        protected void rdPaymentOptions_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session.Remove("cart");
            Response.Redirect("HomePage.aspx");
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("HomePage.aspx");
        }
    }
}