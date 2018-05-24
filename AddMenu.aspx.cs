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
    public partial class AddMenu : System.Web.UI.Page
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

            if (DrpRoles.SelectedIndex == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Select Roles');", true);
            }
            else if (TxtMenuname.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter Menu name');", true);
            }
            else if (txtmenuURL.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter Menu URL');", true);
            }

            else
            {
                SqlCommand cmd = new SqlCommand("Usp_MTDMTDMenuInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MenuName", TxtMenuname.Text);
                cmd.Parameters.AddWithValue("@MenuURL", txtmenuURL.Text);
                cmd.Parameters.AddWithValue("@RoleID", DrpRoles.SelectedValue);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                getdata();
            }
        }



        public void getdata()
        {
            SqlCommand cmd = new SqlCommand("Usp_MTDgetMenu", con);
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
            SqlCommand cmd = new SqlCommand("Usp_MTDgetMenu", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Contains("Table1") == true)
            {
                if (ds.Tables[1].Rows.Count > 0)
                {
                    DrpRoles.DataSource = ds.Tables[1];
                    DrpRoles.DataTextField = ds.Tables[1].Columns[1].ColumnName;
                    DrpRoles.DataValueField = ds.Tables[1].Columns[0].ColumnName;
                    DrpRoles.DataBind();
                }
            }
        }

        protected void GVmenu_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Deleterole")
            {
                string id = e.CommandArgument.ToString();

                SqlCommand cmd = new SqlCommand("usp_DeleteMTDMenu", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MenuID", id);
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