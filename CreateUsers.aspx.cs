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
    public partial class CreateUsers : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (txtUserName.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please enter UserName');", true);
            }
            else if (txtUserDetails.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please enter UserDetails');", true);
            }
            else if (txtpassword.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please enter password');", true);
            }
            else
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("UserInsert", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserName", txtUserName.Text);
                    cmd.Parameters.AddWithValue("@UserDetails", txtUserDetails.Text);
                    cmd.Parameters.AddWithValue("@Password", txtpassword.Text);
                    con.Open();
                    string result = cmd.ExecuteScalar().ToString();
                    con.Close();
                    if (result != "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + result + "');", true);
                    }
                }

            }
        }



    }
}