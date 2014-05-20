#tag Class
Protected Class Headers
Inherits InternetHeaders
	#tag Method, Flags = &h1000
		Sub Constructor(Data As String)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  Dim lines() As String = data.Split(CRLF)
		  Dim lcount As Integer = UBound(lines)
		  For i As Integer = 0 To lcount
		    Dim line As String = lines(i)
		    If Instr(line, ": ") <= 1  Or line.Trim = "" Then Continue
		    Dim n, v As String
		    n = NthField(line, ": ", 1)
		    v = Right(line, line.Len - (n.Len + 2)).Trim
		    Select Case n
		    Case "Set-Cookie"
		      Cookies.Append(New Cookie(v))
		    Case "Cookie"
		      Dim s() As String = Split(v, ";")
		      Dim scount As Integer = UBound(s)
		      For x As Integer = 0 To scount
		        If s(x).Trim = "" Then Continue
		        Dim l, r As String
		        l = NthField(s(x).Trim, "=", 1)
		        r = NthField(s(x).Trim, "=", 2)
		        Dim c As New Cookie(l, r)
		        Cookies.Append(c)
		      Next
		    Case "Accept"
		      Dim t() As ContentType = ContentType.ParseTypes(v)
		      For x As Integer = 0 To UBound(t)
		        AcceptableTypes.Append(t(x))
		      Next
		    Else
		      Me.AppendHeader(n, v)
		    End Select
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cookie(Index As Integer) As Cookie
		  Return Cookies(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cookie(Index As Integer, Assigns NewCookie As Cookie)
		  #pragma BreakOnExceptions Off
		  If NewCookie = Nil Then
		    Cookies.Remove(Index)
		  Else
		    Cookies(Index) = NewCookie
		  End If
		  
		Exception OutOfBoundsException
		  If NewCookie <> Nil Then Cookies.Append(NewCookie)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CookieCount() As Integer
		  Return UBound(Cookies) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteAllHeaders()
		  Super.DeleteAllHeaders
		  ReDim Cookies(-1)
		  ReDim AcceptableTypes(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(HeaderName As String) As Boolean
		  For i As Integer = 0 To Me.Count - 1
		    If Me.Name(i) = HeaderName Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Source(SetCookies As Boolean = False) As String
		  Dim data As String = Super.Source
		  
		  For Each c As Cookie In Me.Cookies
		    If SetCookies Then
		      data = data + CRLF + "Set-Cookie: " + c.ToString
		    Else
		      data = data + CRLF + "Cookie: " + c.Name + "=" + c.Value
		    End If
		  Next
		  
		  Dim acc As String
		  If UBound(AcceptableTypes) > 0 Then
		    Dim ts() As String
		    Dim tcount As Integer = UBound(AcceptableTypes)
		    For i As Integer = 0 To tcount
		      ts.Append(AcceptableTypes(i).ToString)
		    Next
		    acc = Join(ts, ",")
		    If Right(acc, 1) = "," Then acc = Left(acc, acc.Len - 1)
		  ElseIf UBound(AcceptableTypes) = 0 Then
		    acc = acc + AcceptableTypes(0).ToString
		  End If
		  
		  
		  If acc <> "" Then
		    data = data + CRLF + "Accept: " + acc
		  End If
		  
		  Return data
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AcceptableTypes() As ContentType
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Me.HasHeader("Content-Type") Then
			    Return New HTTP.ContentType(Me.Value("Content-Type"))
			  End If
			  Return New HTTP.ContentType("*/*")
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Me.SetHeader("Content-Type", value.ToString)
			End Set
		#tag EndSetter
		ContentType As HTTP.ContentType
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected Cookies() As Cookie
	#tag EndProperty


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Class
#tag EndClass
