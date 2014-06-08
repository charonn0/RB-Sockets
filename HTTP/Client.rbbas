#tag Class
Protected Class Client
Inherits HTTP.Connection
	#tag Event
		Sub Connected()
		  DoNextRequest()
		  'RequestTimer.Mode = Timer.ModeOff
		End Sub
	#tag EndEvent

	#tag Event
		Sub Message(MessageLine As String, Headers As HTTP.Headers, Content As String)
		  Dim code As Integer = Val(NthField(MessageLine, " ", 2).Trim)
		  Dim ProtocolVersion As Single = CDbl(Replace(NthField(MessageLine, " ", 1).Trim, "HTTP/", ""))
		  RaiseEvent HandleResponse(code, Headers, content, ProtocolVersion)
		  DoNextRequest()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub DoNextRequest()
		  If UBound(PendingReqs) = -1 Then Return
		  Dim d As Pair = PendingReqs.Pop
		  Dim verb As String = d.Left
		  Dim u As NetStrings.URI = d.Right
		  
		  Dim h As New HTTP.Headers
		  h.AppendHeader("Host", u.Host)
		  h.AppendHeader("User-Agent", "BSSocketCore/0.1")
		  h.AppendHeader("Connection", "close")
		  h.AcceptableTypes.Append(New ContentType("text/html"))
		  h.AcceptableTypes.Append(New ContentType("*/*;q=0.5"))
		  u.Port = -1
		  u.Scheme = ""
		  u.Username = ""
		  u.Password =""
		  u.Host = ""
		  Me.SendMessage(verb, u.ToString, h, "", 1.0)
		  Me.Flush
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Get(URL As String)
		  Dim u As NetStrings.URI = NetStrings.URI.FromString(URL)
		  PendingReqs.Insert(0, "GET":u)
		  If Not Me.IsConnected Then
		    Me.Address = u.Host
		    Me.Port = u.Port
		    Me.Secure = (u.Scheme = "https")
		    Me.Connect
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RequestTimerHandler(Sender As Timer)
		  #pragma Unused Sender
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendMessage(MethodName As String, Path As String, Headers As HTTP.Headers, Content As String, ProtocolVersion As Single = 1.0)
		  Dim line As String = Uppercase(MethodName) + " " + Path + " HTTP/" + Format(ProtocolVersion, "0.0")
		  Super.SendMessage(line, Headers, Content)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event HandleResponse(Status As Integer, Headers As HTTP.Headers, Content As String, ProtocolVersion As Single)
	#tag EndHook


	#tag Property, Flags = &h1
		Protected PendingReqs() As Pair
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RequestTimer As Timer
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
