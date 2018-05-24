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
    public partial class AddSubMenu : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getdata();
                GetRoles();
            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("Usp_MTDMTDMTDSubMenuInsert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SubmenuName", txtsubmenu.Text);
            cmd.Parameters.AddWithValue("@SubMenuURL", txtmenuURL.Text);
            cmd.Parameters.AddWithValue("@MenuID", DrpMenu.SelectedValue);
            cmd.Parameters.AddWithValue("@RoleID", DrpRoles.SelectedValue);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            getdata();
        }


        public void getdata()
        {
            SqlCommand cmd = new SqlCommand("Usp_MTDgetSubMenu", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Contains("Table") == true)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GVmenu.DataSource = ds.Tables[0];
                    GVmenu.DataBind();
                }
            }

        }

        public void GetRoles()
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

        protected void DrpRoles_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("Usp_MTDGetMenuByRoles", con);
            cmd.Parameters.AddWithValue("@roleID", DrpRoles.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Contains("Table") == true)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DrpMenu.DataSource = ds.Tables[0];
                    DrpMenu.DataTextField = ds.Tables[0].Columns[1].ColumnName;
                    DrpMenu.DataValueField = ds.Tables[0].Columns[0].ColumnName;
                    DrpMenu.DataBind();
                }
            }
        }


        protected void GVmenu_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Deleterole")
            {
                string id = e.CommandArgument.ToString();

                SqlCommand cmd = new SqlCommand("usp_DeleteMTDSubMenu", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SubmenuID", id);
                con.Open();
                string s = cmd.ExecuteScalar().ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + s + "');", true);
                con.Close();

            }
        }

        protected void GVmenu_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GVmenu.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}