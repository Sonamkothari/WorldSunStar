using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace RolesModule
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            if (TxtUsername.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "alert('Please Enter Username');", true);

            }
            else if (TxtPassword.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "alert('Please Enter Password');", true);
            }
            else
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("Usp_checklogin", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", TxtUsername.Text);
                    cmd.Parameters.AddWithValue("@password", TxtPassword.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Contains("Table") == true)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["UserID"].ToString() != "0")
                            {
                                Session["UserID"] = ds.Tables[0].Rows[0]["UserID"].ToString();
                                Session["RoleID"] = ds.Tables[0].Rows[0]["RoleID"].ToString();
                                Response.Redirect("LoginandCheck.aspx");

                            }
                            else
                            {
                                TxtUsername.Text = "";
                                TxtPassword.Text = "";

                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "alert('Enter Valid Username and Password');", true);
                            }
                        }
                    }
                }
            }
        }
        protected void btnReg_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateUsers.aspx");
        }
    }
}