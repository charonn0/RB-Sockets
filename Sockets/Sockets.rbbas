#tag Module
Protected Module Sockets
	#tag Method, Flags = &h0
		Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SocketErrorMessage(Sender As SocketCore) As String
		  Dim err As String = "Socket error " + Str(Sender.LastErrorCode)
		  Select Case Sender.LastErrorCode
		  Case 102
		    err = err + ": Disconnected."
		  Case 100
		    err = err + ": Could not create a socket!"
		  Case 103
		    err = err + ": Unable to contact host."
		  Case 105
		    err = err + ": That port number is already in use."
		  Case 106
		    err = err + ": You can't do that right now."
		  Case 107
		    err = err + ": Could not bind to port."
		  Case 108
		    err = err + ": Out of memory."
		  Else
		    If Not Sender.IsConnected Then
		      err = err + ": Socket not connected."
		    Else
		      err = err + ": System error code."
		    End If
		  End Select
		  
		  Return err
		End Function
	#tag EndMethod


End Module
#tag EndModule
