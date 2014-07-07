#tag Class
Protected Class URI
Implements NetStrings.Serializable
	#tag Method, Flags = &h0
		 Shared Function FromString(URL As String) As NetStrings.URI
		  ' Pass a URI string to parse. e.g. http://user:password@www.example.com:8080/?foo=bar&bat=baz#Top
		  Dim u As New NetStrings.URI
		  If NthField(URL, ":", 1) <> "mailto" Then
		    If InStr(URL, "://") > 0 Then
		      u.Scheme = NthField(URL, "://", 1)
		      URL = URL.Replace(u.Scheme + "://", "")
		    End If
		    
		    If Instr(URL, "@") > 0 Then //  USER:PASS@Domain
		      u.Username = NthField(URL, ":", 1)
		      URL = URL.Replace(u.Username + ":", "")
		      
		      u.Password = NthField(URL, "@", 1)
		      URL = URL.Replace(u.Password + "@", "")
		    End If
		    
		    If Instr(URL, ":") > 0 And Left(URL, 1) <> "[" Then //  Domain:Port
		      Dim s As String = NthField(URL, ":", 2)
		      s = NthField(s, "?", 1)
		      If Val(s) > 0 Then
		        u.Port = Val(s)
		        URL = URL.Replace(":" + Format(u.Port, "######"), "")
		      End If
		    ElseIf Left(URL, 1) = "[" And InStr(URL, "]:") > 0 Then ' ipv6 with u.Port
		      Dim s As String = NthField(URL, "]:", 2)
		      s = NthField(s, "?", 1)
		      u.Port = Val(s)
		      URL = URL.Replace("]:" + Format(u.Port, "######"), "]")
		    Else
		      u.Port = SchemeToPort(u.Scheme)
		    End If
		    
		    
		    If Instr(URL, "#") > 0 Then
		      u.Fragment = NthField(URL, "#", 2)  //    #u.Fragment
		      URL = URL.Replace("#" + u.Fragment, "")
		    End If
		    
		    u.Host = NthField(URL, "/", 1)  //  [sub.]domain.tld
		    URL = URL.Replace(u.Host, "")
		    
		    If InStr(URL, "?") > 0 Then
		      u.Path = NthField(URL, "?", 1)  //    /foo/bar.php
		      URL = URL.Replace(u.Path + "?", "")
		      u.Arguments = Split(URL, "&")
		    ElseIf URL.Trim <> "" Then
		      u.Path = URL.Trim
		    End If
		    
		  Else
		    u.Scheme = "mailto"
		    URL = Replace(URL, "mailto:", "")
		    u.Username = NthField(URL, "@", 1)
		    URL = Replace(URL, u.Username + "@", "")
		    
		    If InStr(URL, "?") > 0 Then
		      u.Host = NthField(URL, "?", 1)
		      u.Arguments = Split(NthField(URL, "?", 2), "&")
		    Else
		      u.Host = URL
		    End If
		  End If
		  u.Scheme = DecodeURLComponent(u.Scheme)
		  u.Username = DecodeURLComponent(u.Username)
		  u.Password = DecodeURLComponent(u.Password)
		  u.Host = DecodeURLComponent(u.Host)
		  u.Path = DecodeURLComponent(u.Path)
		  For Each arg As String In u.Arguments
		    arg = DecodeURLComponent(arg)
		  Next
		  u.Fragment = DecodeURLComponent(u.Fragment)
		  
		  Return u
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim URL As String
		  If Scheme = "mailto" Then
		    URL = "mailto:"
		  Else
		    If Scheme <> "" Then URL = EncodeURLComponent(Scheme) + "://"
		  End If
		  
		  If Username <> "" Then
		    URL = URL + EncodeURLComponent(Username)
		    If Scheme <> "mailto" Then URL = URL + ":"
		    If Password <> "" Then URL = URL + EncodeURLComponent(Password)
		    URL = URL + "@"
		  End If
		  
		  If Left(Host, 1) = "[" And Right(Host, 1) = "]" Then ' IPv6 literal
		    URL = URL + Host
		  Else
		    URL = URL + EncodeURLComponent(Host)
		  End If
		  
		  If Port > -1 And SchemeToPort(Scheme) <> Port Then
		    URL = URL + ":" + Format(Port, "####0")
		  End If
		  
		  For i As Integer = 2 To CountFields(Path, "/")
		    URL = URL + "/" + EncodeURLComponent(NthField(Path, "/", i))
		  Next
		  
		  If Arguments.Ubound > -1 Then
		    Dim args As String = "?"
		    Dim acount As Integer = UBound(Arguments)
		    For i As Integer = 0 To acount
		      If i > 0 Then args = args + "&"
		      If EncodeArguments Then
		        args = args + EncodeURLComponent(Arguments(i))
		      Else
		        args = args + Arguments(i)
		      End If
		    Next
		    URL = URL + args
		  End If
		  
		  If Fragment <> "" Then
		    URL = URL + "#" + EncodeURLComponent(Fragment)
		  End If
		  If URL.Trim = "" Then URL = "/"
		  Return URL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Arguments() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		EncodeArguments As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Fragment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Host As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Path As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Port As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		Scheme As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="EncodeArguments"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Fragment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Host"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Path"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			InitialValue="80"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Scheme"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
