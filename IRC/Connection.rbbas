#tag Class
Protected Class Connection
Inherits SSLSocket
	#tag Event
		Sub DataAvailable()
		  Dim i As Integer = InStr(Me.Lookahead, CRLF)
		  Do Until i = 0
		    Dim line As String = Me.Read(i + 3)
		    If line.Trim <> "" Then
		      Dim msg As IRC.Message = IRC.Message.FromString(line)
		      Select Case msg.Command
		      Case "PING"
		        Me.Write("PONG :" + Right(line, line.Len - 5) + EndOfLine.Windows)
		      End Select
		      
		      RaiseEvent MessageReceived(msg)
		    End If
		    i = InStr(Me.Lookahead, CRLF)
		  Loop
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub Close()
		  Super.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Connect()
		  Super.Connect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Disconnect()
		  Super.Disconnect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Listen()
		  Super.Listen
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Lookahead(Encodinng As TextEncoding = nil) As String
		  Return Super.Lookahead()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Read(byteCount As Integer, encoding As TextEncoding = Nil) As String
		  Return Super.Read(byteCount, encoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAll(encoding As TextEncoding = Nil) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendMessage(Msg As IRC.Message)
		  Me.Write(Msg.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Text As String)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageReceived(Message As IRC.Message)
	#tag EndHook


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
