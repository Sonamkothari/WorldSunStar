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
    public partial class EditMenu : System.Web.UI.Page
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





        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                HiddenField HFDMenuID = (HiddenField)e.Row.FindControl("HDmenuID");
                GridView GridView2 = (GridView)e.Row.FindControl("GridView2");

                SqlCommand cmdx = new SqlCommand("Usp_getSubuserbyUserID", con);
                cmdx.Parameters.AddWithValue("@Menuid", HFDMenuID.Value);
                cmdx.Parameters.AddWithValue("@role", DrpRoles.SelectedValue);
                cmdx.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter dax = new SqlDataAdapter();
                dax.SelectCommand = cmdx;
                DataSet dsx = new DataSet();
                dax.Fill(dsx);
                if (dsx.Tables.Contains("Table") == true)
                {
                    GridView2.DataSource = dsx.Tables[0];
                    GridView2.DataBind();

                    for (int j = 0; j < dsx.Tables[0].Rows.Count; j++)
                    {
                        if (dsx.Tables[0].Rows[j]["SubMRead"].ToString() != "0")
                        {
                            CheckBox CHKRSUB = (GridView2.Rows[j].Cells[2].FindControl("CHKRSUB") as CheckBox);
                            CHKRSUB.Checked = true;
                        }

                        if (dsx.Tables[0].Rows[j]["SubMWrite"].ToString() != "0")
                        {
                            CheckBox CHKWSUB = (GridView2.Rows[j].Cells[3].FindControl("CHKWSUB") as CheckBox);
                            CHKWSUB.Checked = true;
                        }

                        if (dsx.Tables[0].Rows[j]["SubMBoth"].ToString() != "0")
                        {

                            CheckBox CHKBSUB = (GridView2.Rows[j].Cells[4].FindControl("CHKBSUB") as CheckBox);
                            CHKBSUB.Checked = true;
                        }

                    }
                }

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox CHKR = (CheckBox)GridView1.Rows[i].FindControl("CHKR");
                CheckBox CHKW = (CheckBox)GridView1.Rows[i].FindControl("CHKW");
                CheckBox CHKB = (CheckBox)GridView1.Rows[i].FindControl("CHKB");
                Label lblMenuName = (Label)GridView1.Rows[i].FindControl("lblMenuName");
                HiddenField HDMID = (HiddenField)GridView1.Rows[i].FindControl("HDmenuID");

                SqlCommand cmd = new SqlCommand("Usp_UpdateMTDMenu", con);
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
                string result = cmd.ExecuteScalar().ToString();
                con.Close();

                GridView GV2 = (GridView)GridView1.Rows[i].FindControl("GridView2");

                for (int j = 0; j < GV2.Rows.Count; j++)
                {
                    CheckBox CHKRSUB = (CheckBox)GV2.Rows[j].FindControl("CHKRSUB");
                    CheckBox CHKWSUB = (CheckBox)GV2.Rows[j].FindControl("CHKWSUB");
                    CheckBox CHKBSUB = (CheckBox)GV2.Rows[j].FindControl("CHKBSUB");
                    Label lblsubmenu = (Label)GV2.Rows[j].FindControl("lblsubmenu");
                    HiddenField HDsubmenuID = (HiddenField)GV2.Rows[j].FindControl("HDsubmenuID");

                    SqlCommand cmd1 = new SqlCommand("Usp_UpdateMTDSubMenu", con);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@SubMenuID", HDsubmenuID.Value);
                    cmd1.Parameters.AddWithValue("@SubMenuName", lblsubmenu.Text);

                    if (CHKR.Checked)
                    {
                        cmd1.Parameters.AddWithValue("@SubMRead", 1);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@SubMRead", "0");
                    }


                    if (CHKW.Checked)
                    {
                        cmd1.Parameters.AddWithValue("@SubMWrite", 1);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@SubMWrite", "0");
                    }

                    if (CHKB.Checked)
                    {
                        cmd1.Parameters.AddWithValue("@SubMBoth", 1);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@SubMBoth", "0");
                    }

                    cmd1.Parameters.AddWithValue("@SubUID", DrpUser.SelectedValue);
                    cmd1.Parameters.AddWithValue("@SubRID", DrpRoles.SelectedValue);
                    cmd1.Parameters.AddWithValue("@MainMenuID", HDMID.Value);

                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();



                }

            }
        }

        public void bindgrid()
        {

            SqlCommand cmd = new SqlCommand("Usp_getuserbyUserID", con);
            cmd.Parameters.AddWithValue("@userid", DrpUser.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                Session["dt"] = dt;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["MRead"].ToString() != "0")
                    {
                        CheckBox CHKR = (CheckBox)GridView1.Rows[i].FindControl("CHKR");
                        CHKR.Checked = true;
                    }

                    if (dt.Rows[i]["MWrite"].ToString() != "0")
                    {
                        CheckBox CHKW = (CheckBox)GridView1.Rows[i].FindControl("CHKW");
                        CHKW.Checked = true;
                    }
                    if (dt.Rows[i]["MBoth"].ToString() != "0")
                    {
                        CheckBox CHKB = (CheckBox)GridView1.Rows[i].FindControl("CHKB");
                        CHKB.Checked = true;
                    }
                }
            }
            else
            {
                DataRow dr = dt.NewRow();
                dt.Rows.Add(dr);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }


        }


        protected void DrpUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindgrid();
        }


    }
}