#tag Module
Protected Module Auth
	#tag Method, Flags = &h1
		Protected Function GenerateBasic(UserName As String, Password As String) As String
		  Return "Basic " + EncodeBase64(UserName + ":" + Password)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateDigest(UserName As String, Password As String, Realm As String, Nonce As String, Method As String, URL As String) As String
		  Dim HA1, HA2 As String
		  HA1 = MD5(UserName + ":" + Realm + ":" + Password)
		  HA2 = MD5(Method + ":" + URL)
		  Return EncodeHex(HA1 + ":" + Nonce + ":" + HA2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateBasic(UserName As String, Password As String, ValidateThis As String) As Boolean
		  Dim tmp As String = ValidateThis.Replace("Basic ", "")
		  tmp = DecodeBase64(tmp)
		  Return (Password = NthField(tmp, ":", 2)) And (UserName = NthField(tmp, ":", 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateDigest(UserName As String, Password As String, Realm As String, Nonce As String, Method As String, URL As String, ValidateThis As String) As Boolean
		  Dim response As String = DecodeHex(ValidateThis)
		  Dim HA1, HA2, NC As String
		  HA1 = NthField(response, ":", 1)
		  HA2 = NthField(response, ":", 3)
		  NC = NthField(response, ":", 2)
		  
		  Return (HA1 = MD5(UserName + ":" + Realm + ":" + Password)) And (HA2 = MD5(Method + ":" + URL)) And (NC = Nonce)
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
