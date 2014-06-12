#tag Class
Protected Class Server
Inherits HTTP.Connection
	#tag Event
		Sub Message(MessageLine As String, Headers As HTTP.Headers, Content As String)
		  If CountFields(MessageLine.Trim, " ") <> 3 Then
		    #pragma BreakOnExceptions Off
		    Raise New UnsupportedFormatException
		  End If
		  Dim mth As String
		  Dim proto As Single
		  Dim pth As NetStrings.URI
		  mth = NthField(MessageLine, " ", 1).Trim
		  pth = NetStrings.URI.FromString(NthField(MessageLine, " ", 2))
		  proto = CDbl(Replace(NthField(MessageLine, " ", 3).Trim, "HTTP/", ""))
		  If Not RaiseEvent HandleRequest(mth, pth.ToString, Headers, Content, proto) Then
		    Dim h As New HTTP.Headers
		    Me.SendMessage(404, h, "")
		  End If
		  Me.Close
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Shared Function DefaultPage(StatusCode As Integer) As String
		  Dim data As String = ReplaceAll(BlankPage, "%HTTPCODE%", HTTP.FormatStatus(StatusCode))
		  data = ReplaceAll(data, "%SIGNATURE%", "RB-HTTP/1.0")
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendMessage(Status As Integer, Headers As HTTP.Headers, Content As String, Protocolversion As Single = 1.0)
		  Dim line As String = "HTTP/" + Format(Protocolversion, "0.0") + " " +  Format(Status, "000") + " " + HTTP.FormatStatus(Status)
		  Super.SendMessage(line, Headers, Content)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event HandleRequest(HTTPMethod As String, Path As String, Headers As HTTP.Headers, Content As String, Protocolversion As Single) As Boolean
	#tag EndHook


	#tag Constant, Name = BlankPage, Type = String, Dynamic = False, Default = \"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r<html xmlns\x3D\"http://www.w3.org/1999/xhtml\">\r<head>\r<meta http-equiv\x3D\"Content-Type\" content\x3D\"text/html; charset\x3Diso-8859-1\" />\r<title>%HTTPCODE%</title>\r<style type\x3D\"text/css\">\r<!--\rbody\x2Ctd\x2Cth {\r\tfont-family: Arial\x2C Helvetica\x2C sans-serif;\r\tfont-size: medium;\r}\ra:link {\r\tcolor: #0000FF;\r\ttext-decoration: none;\r}\ra:visited {\r\ttext-decoration: none;\r\tcolor: #990000;\r}\ra:hover {\r\ttext-decoration: underline;\r\tcolor: #009966;\r}\ra:active {\r\ttext-decoration: none;\r\tcolor: #FF0000;\r}\r-->\r</style></head>\r\r<body>\r<h1>%HTTPCODE%</h1>\r<p>No handler.</p>\r<hr />\r<p>%SIGNATURE%</p>\r</body>\r</html>", Scope = Protected
	#tag EndConstant


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
