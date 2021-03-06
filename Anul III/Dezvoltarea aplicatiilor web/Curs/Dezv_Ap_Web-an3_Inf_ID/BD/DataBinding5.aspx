<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.OleDb" %>
<%@ Import namespace="System.Data.SqlClient" %>
<html>
	<head>
		<title>DataBinding5.aspx</title></head>
	<body>
		<a href="DataBinding5.aspx">
			<h3>
				<font face="Verdana">DataBinding5.aspx</font>
			</h3>
		</a>
		<form runat="server">
			<asp:Label id="msg" runat="server" />
			<hr>
			<h3>
				DataGrid1:
			</h3>
			<p>
				<asp:CheckBox id="toggle" onCheckedChanged="TogglePaging" autopostback="true" Text="Allow Paging" runat="server" />
			<p>
				<asp:datagrid id="DataGrid1" DataSource="<%# GetEmployeeData() %>" autogeneratecolumns="false" runat="server" AllowPaging="false" PageSize="5" OnPageIndexChanged="DataGrid1_PageIndexChanged" EnableViewState="True" Width="700" ItemStyle-BackColor="lightgreen" AlternatingItemStyle-BackColor="pink" BorderColor="black" ShowFooter="false" CellPadding="3" CellSpacing="0" Font-Name="Verdana" Font-Size="8pt" HeaderStyle-BackColor="#aaaadd">
  <Columns>
						<asp:BoundColumn HeaderText="First Name" DataField="FirstName" />
						<asp:BoundColumn HeaderText="Last Name" DataField="LastName" />
					</Columns>
</asp:datagrid>
				<hr>
				<asp:Button id="button3" text="Do Nothing" onClick="DoNothing" runat="server" />
				<script language="c#" runat="server">

public void Page_Load(object s, EventArgs e) {
  msg.Text = "Page.IsPostBack = " + Page.IsPostBack;

  if (! Page.IsPostBack) {
    Page.DataBind();
  }
}

DataView GetEmployeeData() {
  DataSet ds;
  OleDbConnection cxn = new OleDbConnection("Provider=Microsoft.JET.OLEDB.4.0; Data Source=c:\\Northwind.mdb");
  OleDbDataAdapter adp = new OleDbDataAdapter("select EmployeeID, FirstName, LastName from Employees", cxn);
  ds = new DataSet();
  adp.Fill(ds, "Employees");
  return ds.Tables["Employees"].DefaultView;
}

// Don't do anything: demonstrates that state is maintained
public void DoNothing(object sender, EventArgs e) {
}

public void DataGrid1_PageIndexChanged(object s, DataGridPageChangedEventArgs e) {
  // Go to new page
  DataGrid1.CurrentPageIndex = e.NewPageIndex;

  // Rebind the data
  DataGrid1.DataSource=GetEmployeeData();
  DataGrid1.DataBind();
}

public void TogglePaging(object sender, System.EventArgs e) {
  DataGrid1.AllowPaging = toggle.Checked;
  DataGrid1.DataSource=GetEmployeeData();
  DataGrid1.DataBind();
}

				</script>
		</form>
	</body>
</html>
