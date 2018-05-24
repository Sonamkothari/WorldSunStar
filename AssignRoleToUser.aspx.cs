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
    public partial class AssignRoleToUser : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Newcon"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenu();
                DrpGetuser();

            }
        }

        public void LoadMenu()
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




        public void bindgrid()
        {

            SqlCommand cmd = new SqlCommand("select * from MTDMenu where RoleID=" + DrpRoles.SelectedValue, con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                DataRow dr = dt.NewRow();
                dt.Rows.Add(dr);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }


        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField HFDMenuID = (HiddenField)e.Row.FindControl("HDmenuID");
                GridView GridView2 = (GridView)e.Row.FindControl("GridView2");

                SqlCommand cmd = new SqlCommand("Usp_MTDgetSubMenuBymenu", con);
                cmd.Parameters.AddWithValue("@MenuID", HFDMenuID.Value);
                cmd.Parameters.AddWithValue("@role", DrpRoles.SelectedValue);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Contains("Table") == true)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        GridView2.DataSource = ds.Tables[0];
                        GridView2.DataBind();
                    }
                }

            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox CHKR = (CheckBox)GridView1.Rows[i].FindControl("CHKR");
                CheckBox CHKW = (CheckBox)GridView1.Rows[i].FindControl("CHKW");
                CheckBox CHKB = (CheckBox)GridView1.Rows[i].FindControl("CHKB");
                Label lblMenuName = (Label)GridView1.Rows[i].FindControl("lblMenuName");
                HiddenField HDMID = (HiddenField)GridView1.Rows[i].FindControl("HDmenuID");

                SqlCommand cmd = new SqlCommand("Usp_InsertMTDMenu", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MenuID", HDMID.Value);
                cmd.Parameters.AddWithValue("@MenuName", lblMenuName.Text);

                if (CHKR.Checked)
                {
                    cmd.Parameters.AddWithValue("@MRead", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MRead", 0);
                }


                if (CHKW.Checked)
                {
                    cmd.Parameters.AddWithValue("@MWrite", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MWrite", 0);
                }

                if (CHKB.Checked)
                {
                    cmd.Parameters.AddWithValue("@MBoth", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MBoth", 0);
                }

                cmd.Parameters.AddWithValue("@UID", DrpUser.SelectedValue);
                cmd.Parameters.AddWithValue("@RID", DrpRoles.SelectedValue);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                GridView GV2 = (GridView)GridView1.Rows[i].FindControl("GridView2");

                for (int j = 0; j < GV2.Rows.Count; j++)
                {
                    CheckBox CHKRSUB = (CheckBox)GV2.Rows[j].FindControl("CHKRSUB");
                    CheckBox CHKWSUB = (CheckBox)GV2.Rows[j].FindControl("CHKWSUB");
                    CheckBox CHKBSUB = (CheckBox)GV2.Rows[j].FindControl("CHKBSUB");
                    Label lblsubmenu = (Label)GV2.Rows[j].FindControl("lblsubmenu");
                    HiddenField HDsubmenuID = (HiddenField)GV2.Rows[j].FindControl("HDsubmenuID");

                    SqlCommand cmd1 = new SqlCommand("Usp_InsertMTDSubMenu", con);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@SubMenuID", HDsubmenuID.Value);
                    cmd1.Parameters.AddWithValue("@SubMenuName", lblsubmenu.Text);

                    if (CHKR.Checked)
                    {
                        cmd1.Parameters.AddWithValue("@SubMRead", 1);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@SubMRead", 0);
                    }


                    if (CHKW.Checked)
                    {
                        cmd1.Parameters.AddWithValue("@SubMWrite", 1);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@SubMWrite", 0);
                    }

                    if (CHKB.Checked)
                    {
                        cmd1.Parameters.AddWithValue("@SubMBoth", 1);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@SubMBoth", 0);
                    }

                    cmd1.Parameters.AddWithValue("@SubUID", DrpUser.SelectedValue);
                    cmd1.Parameters.AddWithValue("@SubRID", DrpRoles.SelectedValue);
                    cmd1.Parameters.AddWithValue("@MainMenuID", HDMID.Value);

                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();



                }

            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Saved Successfully');", true);
        }

        protected void DrpRoles_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindgrid();
        }

        protected void DrpUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("Usp_getuserbyUserID", con);
            cmd.Parameters.AddWithValue("@userid", DrpUser.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Contains("Table") == true)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GridView1.DataSource = ds.Tables[0];
                    GridView1.DataBind();
                }
            }
        }
    }
}