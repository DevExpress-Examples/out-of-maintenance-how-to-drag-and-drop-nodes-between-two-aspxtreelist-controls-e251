#region Using
using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
#endregion

public partial class _Default : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		BindTrees();
	}
	protected void Panel_Callback(object source, DevExpress.Web.CallbackEventArgsBase e) {
		string[] data = e.Parameter.Split('|');
		if(data.Length == 3 && data[0] == "drag") {
			MyProvider.MoveNode(data[1], data[2]);
			BindTrees();
		}
	}

	void BindTrees() {
		MyProvider.Bind(LeftTree, "/node/node[@key='1']");
		MyProvider.Bind(RightTree, "/node/node[@key='8']");
	}
}
