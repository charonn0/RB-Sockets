#tag Class
Protected Class Mode
Implements Sockets.Serializable
	#tag Method, Flags = &h0
		 Shared Function FromString(ModeString As String) As IRC.Mode
		  Dim m As New IRC.Mode
		  m.Update(ModeString)
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(ComparedMode As IRC.Mode) As Integer
		  //This function determines equality or inequality of modes, not greater-than or less-than.
		  
		  If UBound(BanMasks) = UBound(ComparedMode.BanMasks) Then
		    For i As Integer = 0 To UBound(BanMasks)
		      If StrComp(BanMasks(i), ComparedMode.BanMasks(i), 0) <> 0 Then //Case-sensitive string compare.
		        Return 1
		      End If
		    Next
		  Else
		    Return 1
		  End If
		  
		  If StrComp(ChannelKey, ComparedMode.ChannelKey, 0) <> 0 Then Return 1
		  If Founder <> ComparedMode.Founder Then Return 1
		  If HalfOp <> ComparedMode.HalfOp Then Return 1
		  If Invisible <> ComparedMode.Invisible Then Return 1
		  If InviteOnly <> ComparedMode.InviteOnly Then Return 1
		  If KeyRequired <> ComparedMode.KeyRequired Then Return 1
		  If Limit <> ComparedMode.Limit Then Return 1
		  If Moderated <> ComparedMode.Moderated Then Return 1
		  If NoOutsideMessages <> ComparedMode.NoOutsideMessages Then Return 1
		  If Operator <> ComparedMode.Operator Then Return 1
		  If PrivateChannel <> ComparedMode.PrivateChannel Then Return 1
		  If ReceivesSNotices <> ComparedMode.ReceivesSNotices Then Return 1
		  If SecretChannel <> ComparedMode.SecretChannel Then Return 1
		  If TopicProtected <> ComparedMode.TopicProtected Then Return 1
		  If Voiced <> ComparedMode.Voiced Then Return 1
		  If HideHost <> ComparedMode.HideHost Then Return 1
		  
		  Return 0  //The modes are identical.
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim mode As String
		  
		  If Operator Then mode = "o"
		  If PrivateChannel Then mode = mode + "p"
		  If SecretChannel Or ReceivesSNotices Then mode = mode + "s"
		  If InviteOnly Or Invisible Then mode = mode + "i"
		  If TopicProtected Then mode = mode + "t"
		  If NoOutsideMessages Then mode = mode + "n"
		  If Moderated Then mode = mode + "m"
		  If Limit > -1 Then mode = mode + "l " + Str(Limit)
		  If Voiced Then mode = mode + "v"
		  If KeyRequired Then mode = mode + "k"
		  If HalfOp Then mode = mode + "h"
		  If Founder Then mode = mode + "q"
		  If HideHost Then mode = mode + "x"
		  
		  Return mode
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(ModeModifier As String)
		  Dim modes() As String = Split(ModeModifier, "")
		  Dim direction As Boolean
		  
		  If modes(0) = "-" Then
		    direction = False
		  Else
		    direction = True
		  End If
		  
		  For i As Integer = 0 To UBound(modes)
		    Select Case modes(i)
		      
		    Case "o"
		      Operator = direction
		      
		    Case "p"
		      PrivateChannel = direction
		      
		    Case "s"
		      SecretChannel = direction
		      ReceivesSNotices = direction
		      
		    Case "i"
		      InviteOnly = direction
		      Invisible = direction
		      
		    Case "t"
		      TopicProtected = direction
		      
		    Case "n"
		      NoOutsideMessages = direction
		      
		    Case "m"
		      Moderated = direction
		      
		    Case "l"
		      Limit = Val(NthField(ModeModifier, " ", 2))
		      
		    Case "b"
		      BanMasks.Append(NthField(ModeModifier, " ", 2))
		      
		    Case "v"
		      Voiced = direction
		      
		    Case "k"
		      KeyRequired = direction
		      If direction Then
		        ChannelKey = NthField(ModeModifier, " ", 2)
		      End If
		      
		    Case "h"
		      HalfOp = direction
		      
		    Case "q"
		      Founder = direction
		      
		    Case "x"
		      HideHost = direction
		      
		    Case "+"
		      If Not direction Then direction = Not direction
		      
		    Case "-"
		      If direction Then direction = Not direction
		      
		    Else
		      If modes(i).Trim = "" Then Exit For  //No more modes!
		      //An invalid MODE character.
		      Dim ircerr As New RuntimeException
		      ircerr.ErrorNumber = 472  //ERR_UNKNOWNMODE
		      ircerr.Message = modes(i) + " :is unknown mode char to me"
		      Raise ircerr
		      
		    End Select
		    
		  Next
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Validate(ModeString As String) As String
		  //Returns the first invalid mode character in the passed mode string.
		  //If no characters are invalid, returns an empty string.
		  
		  Dim modes() As String = Split(ModeString, "")
		  
		  For i As Integer = 0 To UBound(modes)
		    Select Case modes(i)
		    Case "o", "p", "s", "i", "t", "n", "m", "l", "b", "v", "k", "h", "q", "+", "-"
		      Continue
		    Else
		      //An invalid MODE character.
		      Return Modes(i)
		    End Select
		  Next
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Comparing IRC.Mode instances
		You can directly compare any two instances of this class to test for equality:
		
		   Dim d, e As IRC.Mode //Create two new, identical IRC.Mode instances
		   d = New IRC.Mode
		   e = New IRC.Mode
		
		   e.Voiced = True  //Change one, they are no longer equal
		  
		   If d = e Then   //Perform the comparison; in this case, d is not equal to e
		     MsgBox("The modes are identical")
		   Else
		     MsgBox("The modes are NOT identical")
		   End If
		
		
		Any two given instances of this class are deemed to be equal only if ALL possible 
		IRC modes are identical between them.
	#tag EndNote

	#tag Note, Name = Getting a Mode string back out of this class
		To get a properly formatted string representing the currently set modes (e.g. "qo" for a channel founder and channel op)
		simply assign the class instance to a string:
		
		   Dim mode As New IRC.Mode
		   mode = "+o"
		   mode = "-v"
		   Dim modestring As String = mode  //modestring now contains the string "ov"
	#tag EndNote

	#tag Note, Name = Parsing and assigning modes
		Modes can be set by assigning the raw mode string to an instance of the class:
		
		   Dim mode As New IRC.Mode
		   mode = "+v"  //m now has the Voiced property set to true. 
		
		Multiple modes can be set in a single mode string:
		
		   Dim mode As New IRC.Mode
		   mode = "-v+o"  //mode now has the Voiced property set to False, and the Operator property set to True.
		
		Modes which are not present in the mode string are not affected. So, these two snippets are functionally
		identical:
		
		   Dim mode As New IRC.Mode
		   mode = "-v+o"
		
		and
		
		   Dim mode As New IRC.Mode
		   mode = "+o"
		   mode = "-v"
	#tag EndNote

	#tag Note, Name = Read Me
		This class provides an object to store and manipulate IRC modes. Modes for both
		channels and users can be stored in this object; no checking is performed on 
		whether a given mode is appropriate or even legal in IRC (for example, setting
		+k on a user.)
		
		When this class is instantiated, all possible modes will be set to their defaults.
		The defaults correspond to "no mode". Once instantiated, you may change modes directly
		(e.g. SomeMode.Invisible = True) or by assigning its IRC string equivalent 
		(e.g. SomeMode = "+i").
	#tag EndNote


	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		BanMasks() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		ChannelKey As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Users only
		#tag EndNote
		Founder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Users only
		#tag EndNote
		HalfOp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Users only
		#tag EndNote
		HideHost As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Users only
		#tag EndNote
		Invisible As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		InviteOnly As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		KeyRequired As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		Limit As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		Moderated As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		NoOutsideMessages As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			This can be either a channel op or and IRCOP
		#tag EndNote
		Operator As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		PrivateChannel As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Users only
		#tag EndNote
		ReceivesSNotices As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		SecretChannel As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Channels only
		#tag EndNote
		TopicProtected As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Users only
		#tag EndNote
		Voiced As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ChannelKey"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Founder"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HalfOp"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HideHost"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Invisible"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InviteOnly"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyRequired"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Limit"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Moderated"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NoOutsideMessages"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Operator"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrivateChannel"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReceivesSNotices"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecretChannel"
			Group="Behavior"
			Type="Boolean"
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
		#tag ViewProperty
			Name="TopicProtected"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Voiced"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
