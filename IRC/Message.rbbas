#tag Class
Protected Class Message
Implements Sockets.Serializable
	#tag Method, Flags = &h0
		Sub Constructor(Raw As String = "")
		  Dim space As String = Chr(&h20)
		  Dim colon As String = Chr(&h3a)
		  Dim prefix, cmd, params(), trailing As String
		  
		  If Left(Raw, 1) = colon Then 'has a prefix
		    prefix = NthField(Raw, space, 1).Trim
		    Raw = Replace(Raw, prefix, "").Trim
		    prefix = Replace(prefix, colon, "")
		  End If
		  
		  cmd = NthField(Raw, space, 1).Trim
		  Raw = Replace(Raw, cmd, "").Trim
		  
		  Dim i As Integer = InStr(Raw, colon)
		  If i > 0 Then 'trailing
		    trailing = Right(Raw, Raw.Len - i)
		    Raw = Replace(Raw, colon + trailing, "")
		  End If
		  For i = 1 To CountFields(Raw, space)
		    If NthField(Raw, space, i).Trim = "" Then Continue
		    params.Append(NthField(Raw, space, i))
		  Next
		  If trailing.Trim <> "" Then params.Append(trailing)
		  
		  Me.Command = cmd
		  Me.Parameters = params
		  If prefix.Trim <> "" Then
		    Me.Sender = IRC.Hostmask.FromString(prefix)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Target() As HostMask
		  If UBound(Me.Parameters) > 1 Or UBound(Me.Parameters) <= -1 Then
		    Raise New OutOfBoundsException
		  End If
		  Return Hostmask.FromString(Me.Parameters(0))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim msg As String
		  Static space As String = Chr(&h20)
		  Static colon As String = Chr(&h3a)
		  
		  If Sender <> Nil Then
		    msg = colon + Sender.ToString
		  End If
		  
		  If Command <> "" Then
		    msg = msg + space + Command
		  End If
		  
		  For i As Integer = 0 To UBound(Parameters)
		    Dim param As String = Parameters(i)
		    If param.Trim = "" Then Continue
		    If InStr(param, space) > 0 Then
		      msg = msg + space + colon + param.Trim
		    Else
		      msg = msg + space + param.Trim
		    End If
		  Next
		  msg = msg + EndOfLine.Windows
		  
		  Return msg
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Command As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Parameters() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Sender As Hostmask
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Command"
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
