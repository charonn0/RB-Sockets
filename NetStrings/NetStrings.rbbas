#tag Module
Protected Module NetStrings
	#tag Method, Flags = &h0
		Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindFile(RootDirectory As FolderItem, FilePath As String) As FolderItem
		  Dim out As FolderItem = RootDirectory
		  Dim rootpath As String = RootDirectory.AbsolutePath
		  
		  For i As Integer = 1 To CountFields(FilePath, "/")
		    Dim element As String = DecodeURLComponent(NthField(FilePath, "/", i))
		    If element = "" Then Continue
		    Select Case element.Trim
		    Case ".." ' up one
		      If out.Parent = Nil Then Return Nil ' cannot go up from the volume root
		      Dim pp As String = out.Parent.AbsolutePath
		      If Left(pp, rootpath.Len) <> rootpath Then Return Nil ' not contained within root
		      out = out.Parent
		    Case ".", "" ' current
		      out = out ' No-op
		    Case Else
		      out = out.Child(element)
		      If Not out.Exists Then Return Nil
		    End Select
		  Next
		  Return out
		  
		Exception
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatBytes(bytes As Int64, precision As Integer = 2) As String
		  'Converts raw byte counts into SI formatted strings. 1KB = 1024 bytes.
		  'Optionally pass an integer representing the number of decimal places to return. The default is two decimal places. You may specify
		  'between 0 and 16 decimal places. Specifying more than 16 will append extra zeros to make up the length. Passing 0
		  'shows no decimal places and no decimal point.
		  
		  Const kilo = 1024
		  Static mega As Int64 = kilo * kilo
		  Static giga As Int64 = kilo * mega
		  Static tera As Int64 = kilo * giga
		  Static peta As Int64 = kilo * tera
		  Static exab As Int64 = kilo * peta
		  
		  Dim suffix, precisionZeros As String
		  Dim strBytes As Double
		  
		  
		  If bytes < kilo Then
		    strbytes = bytes
		    suffix = "bytes"
		  ElseIf bytes >= kilo And bytes < mega Then
		    strbytes = bytes / kilo
		    suffix = "KB"
		  ElseIf bytes >= mega And bytes < giga Then
		    strbytes = bytes / mega
		    suffix = "MB"
		  ElseIf bytes >= giga And bytes < tera Then
		    strbytes = bytes / giga
		    suffix = "GB"
		  ElseIf bytes >= tera And bytes < peta Then
		    strbytes = bytes / tera
		    suffix = "TB"
		  ElseIf bytes >= tera And bytes < exab Then
		    strbytes = bytes / peta
		    suffix = "PB"
		  ElseIf bytes >= exab Then
		    strbytes = bytes / exab
		    suffix = "EB"
		  End If
		  
		  
		  While precisionZeros.Len < precision
		    precisionZeros = precisionZeros + "0"
		  Wend
		  If precisionZeros.Trim <> "" Then precisionZeros = "." + precisionZeros
		  
		  Return Format(strBytes, "#,###0" + precisionZeros) + suffix
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(Extends h As InternetHeaders, HeaderName As String) As Boolean
		  For i As Integer = 0 To h.Count - 1
		    If h.Name(i) = HeaderName Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastErrorMessage(Extends Sender As SocketCore) As String
		  Dim msg As String
		  Select Case Sender.LastErrorCode
		  Case 100
		    msg =  "Could not create a socket!"
		  Case 102
		    msg =  "Disconnected."
		  Case 103
		    msg =  "Unable to resolve hostname."
		  Case 105
		    msg =  "Unable to bind to port: in use."
		  Case 106
		    msg =  "The socket is not ready."
		  Case 107
		    msg =  "Unable to bind to port: invalid or restricted port number."
		  Case 108
		    msg =  "Out of memory."
		  Else
		    msg =  "System error code (" + Str(Sender.LastErrorCode) + ")."
		    #If TargetWin32 Then
		      Declare Function FormatMessageW Lib "Kernel32" (Flags As Integer, Source As Integer, _
		      MessageId As Integer, LangId As Integer, Buffer As ptr, nSize As Integer, Arguments As Integer) As Integer
		      Dim buffer As New MemoryBlock(2048)
		      If FormatMessageW(&h1000, 0, Sender.LastErrorCode, 0 , Buffer, Buffer.Size, 0) <> 0 Then msg =  Buffer.WString(0)
		    #endif
		  End Select
		  
		  Return msg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseDate(d As Date) As String
		  ' converts the passed Date into an RFC1123 Date string
		  Dim dt As String
		  d.GMTOffset = 0
		  Select Case d.DayOfWeek
		  Case 1
		    dt = dt + "Sun, "
		  Case 2
		    dt = dt + "Mon, "
		  Case 3
		    dt = dt + "Tue, "
		  Case 4
		    dt = dt + "Wed, "
		  Case 5
		    dt = dt + "Thu, "
		  Case 6
		    dt = dt + "Fri, "
		  Case 7
		    dt = dt + "Sat, "
		  End Select
		  
		  dt = dt  + Format(d.Day, "00") + " "
		  
		  Select Case d.Month
		  Case 1
		    dt = dt + "Jan "
		  Case 2
		    dt = dt + "Feb "
		  Case 3
		    dt = dt + "Mar "
		  Case 4
		    dt = dt + "Apr "
		  Case 5
		    dt = dt + "May "
		  Case 6
		    dt = dt + "Jun "
		  Case 7
		    dt = dt + "Jul "
		  Case 8
		    dt = dt + "Aug "
		  Case 9
		    dt = dt + "Sep "
		  Case 10
		    dt = dt + "Oct "
		  Case 11
		    dt = dt + "Nov "
		  Case 12
		    dt = dt + "Dec "
		  End Select
		  
		  dt = dt  + Format(d.Year, "0000") + " " + Format(d.Hour, "00") + ":" + Format(d.Minute, "00") + ":" + Format(d.Second, "00") + " GMT"
		  Return dt
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseDate(Data As String) As Date
		  ' converts the passed RFC1123 date string into a Date object
		  
		  Data = ReplaceAll(Data, "-", " ")
		  Dim d As Date
		  Dim members() As String = Split(Data, " ")
		  If UBound(members) = 5 Then
		    Dim dom, mon, year, h, m, s, tz As Integer
		    
		    dom = Val(members(1))
		    
		    Select Case members(2)
		    Case "Jan"
		      mon = 1
		    Case "Feb"
		      mon = 2
		    Case "Mar"
		      mon = 3
		    Case "Apr"
		      mon = 4
		    Case "May"
		      mon = 5
		    Case "Jun"
		      mon = 6
		    Case "Jul"
		      mon = 7
		    Case "Aug"
		      mon = 8
		    Case "Sep"
		      mon = 9
		    Case "Oct"
		      mon = 10
		    Case "Nov"
		      mon = 11
		    Case "Dec"
		      mon = 12
		    End Select
		    
		    year = Val(members(3))
		    
		    Dim time As String = members(4)
		    h = Val(NthField(time, ":", 1))
		    m = Val(NthField(time, ":", 2))
		    s = Val(NthField(time, ":", 3))
		    tz = Val(members(5))
		    
		    
		    
		    d = New Date(year, mon, dom, h, m, s, tz)
		  End If
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SchemeToPort(Scheme As String) As Integer
		  Static mPorts As Dictionary
		  If mPorts = Nil Then
		    mPorts = New Dictionary( _
		    "http":80, _
		    "https":443, _
		    "ftp":21, _
		    "ssh":22, _
		    "telnet":23, _
		    "smtp":25, _
		    "smtps":25, _
		    "pop2":109, _
		    "pop3":110, _
		    "ident":113, _
		    "auth":113, _
		    "sftp":115, _
		    "nntp":119, _
		    "ntp":123, _
		    "irc":6667)
		    #pragma Warning "To do"
		    ' Add more ports
		  End If
		  
		  Return mPorts.Lookup(Scheme, -1)
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
