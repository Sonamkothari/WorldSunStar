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
    public partial class AddUsers : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString());



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Loadroles();
                DrpGetuser();


            }
        }
        public void Loadroles()
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
                    DrpRoles.DataSource = ds.Tables[0];
                    DrpRoles.DataTextField = ds.Tables[0].Columns[1].ColumnName;
                    DrpRoles.DataValueField = ds.Tables[0].Columns[0].ColumnName;
                    DrpRoles.DataBind();
                }
            }
        }
        protected void DrpGetuser()
        {
            SqlCommand cmd = new SqlCommand("select * from MTDUsers", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Contains("Table") == true)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DrpUser.DataSource = ds.Tables[0];
                    DrpUser.DataTextField = ds.Tables[0].Columns[1].ColumnName;
                    DrpUser.DataValueField = ds.Tables[0].Columns[0].ColumnName;
                    DrpUser.DataBind();
                }
            }
        }
        protected void btnassign_Click(object sender, EventArgs e)
        {
            if (DrpUser.SelectedIndex == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select Username');", true);
            }
            else if (DrpRoles.SelectedIndex == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select Roles');", true);
            }

            else
            {
                SqlCommand cmd = new SqlCommand("usp_updateuserRole", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", DrpUser.SelectedValue);
                cmd.Parameters.AddWithValue("@RoleID", DrpRoles.SelectedValue);
                con.Open();
                string result = cmd.ExecuteScalar().ToString();
                con.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + result + "');", true);
            }
        }
       

        protected void DrpUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DrpUser.SelectedIndex != 0)
            {
                getdata(DrpUser.SelectedValue);
            }
        }

        public void getdata(string UserID)
        {
            SqlCommand cmd = new SqlCommand("usp_getallusers", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserID);
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
    }
}