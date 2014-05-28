#tag Window
Begin Window Window1
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   600
   Begin HTTP.Client Client1
      CertificateFile =   ""
      CertificatePassword=   ""
      CertificateRejectionFile=   ""
      ConnectionType  =   2
      Height          =   32
      Index           =   -2147483648
      Left            =   456
      LockedInPosition=   False
      Scope           =   1
      Secure          =   ""
      TabPanelIndex   =   0
      Top             =   14
      Width           =   32
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Untitled"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   423
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   58
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
#tag EndWindowCode

#tag Events Client1
	#tag Event
		Sub Connected()
		  Dim h As New HTTP.Headers
		  h.AppendHeader("Host", "www.google.com")
		  h.AppendHeader("Connection", "close")
		  h.AcceptableTypes.Append(New ContentType("text/html"))
		  Me.SendMessage("GET", "/", h, "", 1.1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub HandleResponse(Status As Integer, Headers As HTTP.Headers, Content As String, ProtocolVersion As Single)
		  Break
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  Client1.Address = "www.google.com"
		  Client1.Port = 80
		  Client1.Secure = False
		  Client1.Connect
		End Sub
	#tag EndEvent
#tag EndEvents
