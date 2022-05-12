using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace ProjectShop
{


    public partial class HomePage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["myshop"].ToString();
            if(IsPostBack && Request.QueryString["source"] != null)
            {
                lblMsg.Text = "Login To Proceed for Payments";
            }
            if (!IsPostBack)
            {
                Panel2.Visible = false;
                LoadCategories();
                
            }
            if (Session["loggedInUser"] != null)
            {
                Panel1.Visible = false;
                Panel2.Visible = true;
                lblUname.Text = Session["name"].ToString();
                
            }
        }

        void LoadCategories()
        {
            SqlDataAdapter da = new SqlDataAdapter("select catid, Category, '~/Images/' +Category+ '.jpg'[ImageUrl] from categoryList", con);
            DataTable dtCategories = new DataTable();
            da.Fill(dtCategories);

            catLists.DataSource = dtCategories;
            catLists.DataBind();

        }

        protected void lnkCatBtn_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            Response.Redirect("ListProducts.aspx?catid=" + btn.CommandArgument + "&category=" + btn.Text);
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select password, cid, name from customers where email='" + txtEmail.Text.Trim() + "'";
            cmd.Connection = con;
            if (con.State == ConnectionState.Closed)
                con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                if (dr[0].ToString().Trim().Equals(txtPwd.Text.Trim()))
                {

                    lblUname.Text = dr[2].ToString();
                    Session["loggedInUser"] = dr[1].ToString();
                    Session["name"] = dr[2].ToString();
                    
                    if (Request.QueryString["source"] != null)
                    {
                        Response.Redirect("Payments.aspx");
                    }
                    Panel1.Visible=false;
                    Panel2.Visible = true;
                }
                else
                {
                    lblMsg.Text = "Login Failed";
                }
            }
            else
            {
                lblMsg.Text = "Login Failed";

            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("HomePage.aspx");
        }
    }
}
    