#tag Class
Protected Class Client
Inherits HTTP.Connection
	#tag Event
		Sub Message(MessageLine As String, Headers As HTTP.Headers, Content As String)
		  Dim code As Integer = Val(NthField(MessageLine, " ", 2).Trim)
		  Dim ProtocolVersion As Single = CDbl(Replace(NthField(MessageLine, " ", 1).Trim, "HTTP/", ""))
		  RaiseEvent HandleResponse(code, Headers, content, ProtocolVersion)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub SendMessage(MethodName As String, Path As String, Headers As HTTP.Headers, Content As String, ProtocolVersion As Single = 1.0)
		  Dim p As String
		  For i As Integer = 1 To CountFields(Path, "/") - 1
		    p = p + "/" + EncodeURLComponent(NthField(Path, "/", i))
		  Next
		  Dim line As String = Uppercase(MethodName) + " " + p + " HTTP/" + Format(ProtocolVersion, "0.0")
		  Super.SendMessage(line, Headers, Content)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event HandleResponse(Status As Integer, Headers As HTTP.Headers, Content As String, ProtocolVersion As Single)
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
