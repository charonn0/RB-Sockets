#tag Class
Protected Class URI
	#tag Method, Flags = &h0
		Sub Constructor(URL As String)
		  //The Parse method accepts a string as input and parses that string as a URI into the various class properties.
		  
		  If NthField(URL, ":", 1) <> "mailto" Then
		    If InStr(URL, "://") > 0 Then
		      Scheme = NthField(URL, "://", 1)
		      URL = URL.Replace(Scheme + "://", "")
		    End If
		    
		    If Instr(URL, "@") > 0 Then //  USER:PASS@Domain
		      Username = NthField(URL, ":", 1)
		      URL = URL.Replace(Username + ":", "")
		      
		      Password = NthField(URL, "@", 1)
		      URL = URL.Replace(Password + "@", "")
		    End If
		    
		    If Instr(URL, ":") > 0 Then //  Domain:Port
		      Dim s As String = NthField(URL, ":", 2)
		      s = NthField(s, "?", 1)
		      Port = Val(s)
		      
		      URL = URL.Replace(":" + Format(Port, "######"), "")
		    End If
		    
		    If Instr(URL, "#") > 0 Then
		      Fragment = NthField(URL, "#", 2)  //    #fragment
		      URL = URL.Replace("#" + Fragment, "")
		    End If
		    
		    FQDN = NthField(URL, "/", 1)  //  [sub.]domain.tld
		    URL = URL.Replace(FQDN, "")
		    
		    If InStr(URL, "?") > 0 Then
		      Path = NthField(URL, "?", 1)  //    /foo/bar.php
		      URL = URL.Replace(Path + "?", "")
		      Arguments = Split(URL, "&")
		    ElseIf URL.Trim <> "" Then
		      Path = URL.Trim
		    End If
		    Path = ReplaceAll(Path, "/..", "") 'prevent directory traversal
		  Else
		    Scheme = "mailto"
		    URL = Replace(URL, "mailto:", "")
		    Username = NthField(URL, "@", 1)
		    URL = Replace(URL, Username + "@", "")
		    
		    If InStr(URL, "?") > 0 Then
		      FQDN = NthField(URL, "?", 1)
		      Arguments = Split(NthField(URL, "?", 2), "&")
		    Else
		      FQDN = URL
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim URL As String
		  If Scheme = "mailto" Then
		    URL = "mailto:"
		  Else
		    If Scheme <> "" Then URL = Scheme + "://"
		  End If
		  
		  If Username <> "" Then
		    URL = URL + Username
		    If Password <> "" Then URL = URL + ":" + Password
		    URL = URL + "@"
		  End If
		  
		  URL = URL + FQDN
		  
		  If Port <> 80 Then //port specified
		    URL = URL + ":" + Format(Port, "#####")
		  End If
		  
		  If Path.Trim <> "" Then
		    URL = URL + Path.Trim
		  Else
		    If Scheme <> "mailto" Then URL = URL + "/"
		  End If
		  
		  If Arguments.Ubound > -1 Then
		    Dim args As String = "?"
		    Dim acount As Integer = UBound(Arguments)
		    For i As Integer = 0 To acount
		      If i > 0 Then args = args + "&"
		      args = args + EncodeURLComponent(Arguments(i))
		    Next
		    URL = URL + args
		  End If
		  
		  If Fragment <> "" Then
		    URL = URL + "#" + Fragment
		  End If
		  If URL.Trim = "" Then URL = "/"
		  Return URL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Arguments() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FQDN As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Fragment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Path As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Port As Integer = 80
	#tag EndProperty

	#tag Property, Flags = &h0
		Scheme As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="FQDN"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Fragment"
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
