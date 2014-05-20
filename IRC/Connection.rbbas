#tag Class
Protected Class Connection
Inherits SSLSocket
	#tag Event
		Sub Connected()
		  Me.Write("USER " + Me.Host.Nick + " 0 * " + Me.Host.UserName + EndOfLine.Windows)
		  If Me.Password <> "" Then Me.Write("PASS " + Me.Host.Password + EndOfLine.Windows)
		  Me.Write("NICK " + Me.Host.Nick + EndOfLine.Windows)
		End Sub
	#tag EndEvent

	#tag Event
		Sub DataAvailable()
		  Dim data As String = Me.ReadAll
		  Dim s() As String = Split(data, EndOfLine.Windows)
		  
		  For i As Integer = 0 To UBound(s)
		    Dim line As String = s(i)
		    If line.Trim = "" Then Continue
		    If NthField(line, " ", 1) = "PING" Then
		      Me.Write("PONG :" + Right(line, line.Len - 5) + EndOfLine.Windows)
		    Else
		      RaiseEvent MessageReceived(New IRC.Message(line))
		    End If
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub SendMessage(Msg As IRC.Message)
		  Me.Write(Msg.ToString)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageReceived(Message As IRC.Message)
	#tag EndHook


	#tag Property, Flags = &h0
		Host As Hostmask
	#tag EndProperty

	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="CertificateFile"
			Visible=true
			Group="Behavior"
			Type="FolderItem"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CertificatePassword"
			Visible=true
			Group="Behavior"
			Type="String"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CertificateRejectionFile"
			Visible=true
			Group="Behavior"
			Type="FolderItem"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConnectionType"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Secure"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
