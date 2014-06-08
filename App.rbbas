#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  Dim m As IRC.Message = IRC.Message.FromString(":w00t!services@geekshed.net MODE #Amazed +b *!*@protectedhost-1A062A64.dsl.static.sonic.net")
		  Break
		  
		  'Dim frm As New MultipartForm
		  'frm.Boundary = ""
		  'frm.Element("Error") = GetOpenFolderItem("")
		  ''frm.Element("File1") = frm.Element("Error")
		  'Dim g As FolderItem = GetSaveFolderItem("", "")
		  'Dim bs As BinaryStream = BinaryStream.Create(g, True)
		  'bs.Write(frm.ToString)
		  'bs.Close
		  'Dim g As FolderItem = GetOpenFolderItem("")
		  'Dim bs As BinaryStream = BinaryStream.Open(g)
		  'Dim data As String = bs.Read(bs.Length)
		  'bs.Close
		  'Dim frm As MultipartForm = MultipartForm.FromString(data, "0x5ED3F183864577FD72BE65CA34F3CFB2bOuNdArY")
		  '
		  'For i As Integer = 0 To 99
		  'Dim m As String = frm.ToString
		  'Break
		  'Next
		  ''Break
		  'Quit
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
