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
    public partial class AddRoles : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getdata();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TxtUserRoles.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter User Role');", true);
            }
            else
            {
                SqlCommand cmd = new SqlCommand("MTDUserRolesInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RolesName", TxtUserRoles.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                TxtUserRoles.Text = "";
                getdata();
            }
        }

        public void getdata()
        {
            SqlCommand cmd = new SqlCommand("Usp_MTDgetroles", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Contains("Table") == true)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GVRoles.DataSource = ds.Tables[0];
                    GVRoles.DataBind();
                }
            }

        }

        protected void GVRoles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Deleterole")
            {
                string id = e.CommandArgument.ToString();
                SqlCommand cmd = new SqlCommand("usp_DeleteRoles", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RolesID", id);
                con.Open();
                string s = cmd.ExecuteScalar().ToString();
                con.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + s + "');", true);
            }
        }

        protected void GVRoles_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GVRoles.PageIndex = e.NewPageIndex;
            getdata();
        }

    }
}