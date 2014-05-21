#tag Class
Class URLEncodedForm
	#tag Method, Flags = &h0
		Sub Constructor()
		  Me.Constructor(New Dictionary)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(FormData As Dictionary)
		  Form = FormData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Form.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Element(Name As String) As String
		  Return Form.Value(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Element(Name As String, Assigns Value As String)
		  If Value = "" Then
		    Form.Remove(Name)
		  Else
		    Form.Value(Name) = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FromData(urlencodedform As String) As HTTP.URLEncodedForm
		  Dim items() As String = Split(urlencodedform.Trim, "&")
		  Dim f As New Dictionary
		  Dim dcount As Integer = UBound(items)
		  For i As Integer = 0 To dcount
		    f.Value(DecodeURLComponent(NthField(items(i), "=", 1))) = DecodeURLComponent(NthField(items(i), "=", 2))
		  Next
		  
		  Return New HTTP.URLEncodedForm(f)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasElement(Name As String) As Boolean
		  Return Form.HasKey(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(Index As Integer) As String
		  Dim s() As Variant = Form.Keys
		  Return s(Index).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim data() As String
		  For Each key As String in Form.Keys
		    data.Append(EncodeURLComponent(Key) + "=" + EncodeURLComponent(Form.Value(key)))
		  Next
		  Return Join(data, "&")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Form As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
