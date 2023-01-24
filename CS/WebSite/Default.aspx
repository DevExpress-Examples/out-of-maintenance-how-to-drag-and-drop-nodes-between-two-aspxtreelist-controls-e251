<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web" TagPrefix="dx" %>


<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v13.1" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Untitled Page</title>
<style type="text/css">
	.rootTarget {
		font: 9pt Tahoma;
		padding: 4px;
		margin-top: 8px;
		background: silver;
	}
</style>
<script type="text/javascript">
MyDragHelper = {    
	StartDragNode: function(s, e) {
		MyDragHelper.CreateTargets(e.targets);
	},
	EndDragNode: function(s, e) {
		var key = e.nodeKey;
		var targetKey;
		if(e.targetElement.id == "__leftRoot") {
			targetKey = 1;
		} else if(e.targetElement.id == "__rightRoot") {
			targetKey = 8;
		} else {
			targetKey = MyDragHelper.GetTargetTree(e.targetElement).GetNodeKeyByRow(e.targetElement);
		}
		Panel.PerformCallback("drag|" + key + "|" + targetKey);
		e.cancel = true;
	},

	CreateTargets: function(targets) {
		targets.splice(0, targets.length);
		var list = [LeftTree, RightTree];
		for(var i = 0; i < list.length; i++) {
			var tree = list[i];
			var keys = tree.GetVisibleNodeKeys();
			for(var j = 0; j < keys.length; j++)
				targets.push(tree.GetNodeHtmlElement(keys[j]));
		}
		targets.push(document.getElementById("__leftRoot"));
		targets.push(document.getElementById("__rightRoot"));
	},
	
	GetTargetTree: function(element) {
		var leftElement = LeftTree.GetMainElement();
		var rightElement = RightTree.GetMainElement();
		while(element) {
			if(element == leftElement)
				return LeftTree;
			if(element == rightElement)
				return RightTree;
			element = element.parentNode;
		}
	}
}
</script>	
</head>
<body>
	<form id="form1" runat="server">
		<dx:ASPxCallbackPanel runat="server" ID="Panel" ClientInstanceName="Panel" OnCallback="Panel_Callback" HideContentOnCallback="False" RenderMode="Table">
			<PanelCollection>
				<dx:PanelContent runat="server">
					<table>
						<tr valign="top">
							<td>				
								<div class="rootTarget" id="__leftRoot">Move to root</div>				
								<dx:ASPxTreeList runat="server" ID="LeftTree" ClientInstanceName="LeftTree" AutoGenerateColumns="False">
									<Columns>
										<dx:TreeListDataColumn FieldName="Value" VisibleIndex="0" />
									</Columns>
									<Settings ShowColumnHeaders="false" />
									<SettingsBehavior AutoExpandAllNodes="True" />
									<SettingsEditing AllowNodeDragDrop="True" />
									<ClientSideEvents StartDragNode="MyDragHelper.StartDragNode" EndDragNode="MyDragHelper.EndDragNode" />
								</dx:ASPxTreeList>								
							</td>
							<td valign="middle" style="padding: 16px;">
								&harr;
							</td>
							<td>
								<div class="rootTarget" id="__rightRoot">Move to root</div>
								<dx:ASPxTreeList runat="server" ID="RightTree" ClientInstanceName="RightTree" AutoGenerateColumns="False">
									<Columns>
										<dx:TreeListDataColumn FieldName="Value" VisibleIndex="0" />
									</Columns>
									<Settings ShowColumnHeaders="false" />
									<SettingsBehavior AutoExpandAllNodes="True" />
									<SettingsEditing AllowNodeDragDrop="True" />
									<ClientSideEvents StartDragNode="MyDragHelper.StartDragNode" EndDragNode="MyDragHelper.EndDragNode" />
								</dx:ASPxTreeList>								
							</td>
						</tr>
					</table>
				</dx:PanelContent>
			</PanelCollection>
		</dx:ASPxCallbackPanel>
	</form>
</body>
</html>