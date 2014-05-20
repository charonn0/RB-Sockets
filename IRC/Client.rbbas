#tag Class
Protected Class Client
Inherits IRC.Connection
	#tag Event
		Sub Connected()
		  Me.Write("USER " + Me.Host.Nick + " 0 * " + Me.Host.UserName + EndOfLine.Windows)
		  If Me.Password <> "" Then Me.Write("PASS " + Me.Password + EndOfLine.Windows)
		  Me.Write("NICK " + Me.Host.Nick + EndOfLine.Windows)
		  RaiseEvent Connected()
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Connected()
	#tag EndHook


	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty


End Class
#tag EndClass
