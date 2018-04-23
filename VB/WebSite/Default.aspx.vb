Imports Microsoft.VisualBasic
#Region "Using"
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
#End Region

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		BindTrees()
	End Sub
	Protected Sub Panel_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)
		Dim data() As String = e.Parameter.Split("|"c)
		If data.Length = 3 AndAlso data(0) = "drag" Then
			MyProvider.MoveNode(data(1), data(2))
			BindTrees()
		End If
	End Sub

	Private Sub BindTrees()
		MyProvider.Bind(LeftTree, "/node/node[@key='1']")
		MyProvider.Bind(RightTree, "/node/node[@key='8']")
	End Sub
End Class
