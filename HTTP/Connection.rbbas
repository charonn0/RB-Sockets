#tag Class
Protected Class Connection
Inherits SSLSocket
	#tag Event
		Sub DataAvailable()
		  ' This method receives and processes all requests made to the socket,
		  ' raises the Message event.
		  
		  Do Until InStrB(Me.Lookahead, CRLF + CRLF) = 0
		    Dim peek As String = Me.Lookahead
		    Dim sz As Integer = InStrB(Me.Lookahead, CRLF + CRLF) + 3
		    Dim data As MemoryBlock = LeftB(Me.Lookahead, sz)
		    Dim line As MemoryBlock
		    line = NthFieldB(data.Trim, CRLF, 1)
		    If CountFieldsB(line.Trim, " ") <> 3 Then
		      Return
		    End If
		    data = ReplaceB(data, line + CRLF, "")
		    Dim h As MemoryBlock = NthFieldB(data, CRLF + CRLF, 1)
		    Dim head As New HTTP.Headers(h)
		    Dim content As MemoryBlock '= Replace(data, h, "")
		    If head.HasHeader("Content-Length") Then
		      Dim cl As Integer = Val(head.Value("Content-Length"))
		      If cl  + sz > Me.Lookahead.LenB Then ' still data coming
		        Return
		      End If
		      Call Me.Read(sz)
		      content = Me.Read(cl)
		    Else
		      Call Me.Read(sz)
		      content = Me.ReadAll
		    End If
		    RaiseEvent Message(line, head, content)
		  Loop
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error()
		  Break
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub SendMessage(MessageLine As String, Headers As HTTP.Headers, Content As String)
		  Me.Write(MessageLine + CRLF + Headers.Source + CRLF + CRLF + Content)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Message(MessageLine As String, Headers As HTTP.Headers, Content As String)
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
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
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
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
