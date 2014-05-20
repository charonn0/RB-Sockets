#tag Module
Protected Module IRC
	#tag Method, Flags = &h1
		Protected Function FormatReply(ReplyCode As Integer) As String
		  Static mReplies As Dictionary
		  If mReplies = Nil Then
		    mReplies = New Dictionary( _
		    ERR_NOSUCHNICK:"<nickname> :No such nick/channel", _
		    RPL_NONE:"Dummy reply number. Not used.", _
		    RPL_USERHOST:"[<reply>{<space><reply>}]", _
		    RPL_ISON:"[<nick> {<space><nick>}]", _
		    RPL_AWAY:"<nick> :<away message>", _
		    RPL_UNAWAY:"You are no longer marked as being away", _
		    RPL_NOWAWAY:"You have been marked as being away", _
		    RPL_WHOISUSER:"<nick> <user> <host> * :<real name>", _
		    RPL_WHOISSERVER:"<nick> <server> :<server info>", _
		    RPL_WHOISOPERATOR:"<nick> :is an IRC operator", _
		    RPL_WHOISIDLE:"<nick> <integer> :seconds idle", _
		    RPL_ENDOFWHOIS:"<nick> :End of /WHOIS list", _
		    RPL_WHOISCHANNELS:"<nick> :{[@|+]<channel><space>}", _
		    RPL_WHOWASUSER:"<nick> <user> <host> * :<real name>", _
		    RPL_ENDOFWHOWAS:"<nick> :End of WHOWAS", _
		    RPL_LISTSTART:"Channel :Users Name", _
		    RPL_LIST:"<channel> <# visible> :<topic>", _
		    RPL_LISTEND:"End of /LIST", _
		    RPL_CHANNELMODEIS:"<channel> <mode> <mode params>", _
		    RPL_NOTOPIC:"<channel> :No topic is set", _
		    RPL_TOPIC:"<channel> :<topic>", _
		    RPL_INVITING:"<channel> <nick>", _
		    RPL_SUMMONING:"<user> :Summoning user to IRC", _
		    RPL_VERSION:"<version>.<debuglevel> <server> :<comments>", _
		    RPL_WHOREPLY:"<channel> <user> <host> <server> <nick> <H|G>[*][@|+] :<hopcount> <real name>", _
		    RPL_ENDOFWHO:"<name> :End of /WHO list", _
		    RPL_NAMREPLY:"<channel> :[[@|+]<nick> [[@|+]<nick> [...]]]", _
		    RPL_ENDOFNAMES:"<channel> :End of /NAMES list", _
		    RPL_LINKS:"<mask> <server> :<hopcount> <server info>", _
		    RPL_ENDOFLINKS:"<mask> :End of /LINKS list", _
		    RPL_BANLIST:"<channel> <banid>", _
		    RPL_ENDOFBANLIST:"<channel> :End of channel ban list", _
		    RPL_INFO:"<string>", _
		    RPL_ENDOFINFO:"End of /INFO list", _
		    RPL_MOTDSTART:"- <server> Message of the day - ", _
		    RPL_MOTD:"- <text>", _
		    RPL_ENDOFMOTD:"End of /MOTD command", _
		    RPL_YOUREOPER:"You are now an IRC operator", _
		    RPL_REHASHING:"<config file> :Rehashing", _
		    RPL_TIME:"<server> :<string showing server's local time>", _
		    RPL_USERSSTART:"UserID Terminal Host", _
		    RPL_USERS:"%-8s %-9s %-8s", _
		    RPL_ENDOFUSERS:"End of users", _
		    RPL_NOUSERS:"Nobody logged in", _
		    RPL_TRACELINK:"Link <version & debug level> <destination> <next server>", _
		    RPL_TRACECONNECTING:"Try. <class> <server>", _
		    RPL_TRACEHANDSHAKE:"H.S. <class> <server>", _
		    RPL_TRACEUNKNOWN:"???? <class> [<client IP address in dot form>]", _
		    RPL_TRACEOPERATOR:"Oper <class> <nick>", _
		    RPL_TRACEUSER:"User <class> <nick>", _
		    RPL_TRACESERVER:"Serv <class> <int>S <int>C <server> <nick!user|*!*>@<host|server>", _
		    RPL_TRACENEWTYPE:"<newtype> 0 <client name>", _
		    RPL_TRACELOG:"File <logfile> <debug level>", _
		    RPL_STATSLINKINFO:"<linkname> <sendq> <sent messages> <sent bytes> <received messages> <received bytes> <time open>", _
		    RPL_STATSCOMMANDS:"<command> <count>", _
		    RPL_STATSCLINE:"C <host> * <name> <port> <class>", _
		    RPL_STATSNLINE:"N <host> * <name> <port> <class>", _
		    RPL_STATSILINE:"I <host> * <host> <port> <class>", _
		    RPL_STATSKLINE:"K <host> * <username> <port> <class>", _
		    RPL_STATSYLINE:"Y <class> <ping frequency> <connect frequency> <max sendq>", _
		    RPL_ENDOFSTATS:"<stats letter> :End of /STATS report", _
		    RPL_STATSLLINE:"L <hostmask> * <servername> <maxdepth>", _
		    RPL_STATSUPTIME:"Server Up %d days %d:%02d:%02d", _
		    RPL_STATSOLINE:"O <hostmask> * <name>", _
		    RPL_STATSHLINE:"H <hostmask> * <servername>", _
		    RPL_UMODEIS:"<user mode string>", _
		    RPL_LUSERCLIENT:"There are <integer> users and <integer> invisible on <integer> servers", _
		    RPL_LUSEROP:"<integer> :operator(s) online", _
		    RPL_LUSERUNKNOWN:"<integer> :unknown connection(s)", _
		    RPL_LUSERCHANNELS:"<integer> :channels formed", _
		    RPL_LUSERME:"I have <integer> clients and <integer> servers", _
		    RPL_ADMINME:"<server> :Administrative info", _
		    RPL_ADMINLOC1:"<admin info>", _
		    RPL_ADMINLOC2:"<admin info>", _
		    RPL_ADMINEMAIL:"<admin info>")
		  End If
		  
		  Return mReplies.Lookup(ReplyCode, "Unknown IRC code: " + Str(ReplyCode))
		End Function
	#tag EndMethod


	#tag Constant, Name = ERR_ALREADYREGISTRED, Type = Double, Dynamic = False, Default = \"462", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BADCHANMASK, Type = Double, Dynamic = False, Default = \"476", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BADCHANNAME, Type = Double, Dynamic = False, Default = \"479", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BADCHANNELKEY, Type = Double, Dynamic = False, Default = \"475", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BADMASK, Type = Double, Dynamic = False, Default = \"415", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BADPING, Type = Double, Dynamic = False, Default = \"513", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BANLISTFULL, Type = Double, Dynamic = False, Default = \"478", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BANNEDFROMCHAN, Type = Double, Dynamic = False, Default = \"474", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BANNICKCHANGE, Type = Double, Dynamic = False, Default = \"437", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_BANONCHAN, Type = Double, Dynamic = False, Default = \"435", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_CANNOTSENDTOCHAN, Type = Double, Dynamic = False, Default = \"404", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_CANTKILLSERVER, Type = Double, Dynamic = False, Default = \"483", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_CHANNELISFULL, Type = Double, Dynamic = False, Default = \"471", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_CHANOPRIVSNEEDED, Type = Double, Dynamic = False, Default = \"482", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_CHANTOORECENT, Type = Double, Dynamic = False, Default = \"487", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_DEAD, Type = Double, Dynamic = False, Default = \"438", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_DESYNC, Type = Double, Dynamic = False, Default = \"484", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_ERRONEUSNICKNAME, Type = Double, Dynamic = False, Default = \"432", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_FILEERROR, Type = Double, Dynamic = False, Default = \"424", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_GHOSTEDCLIENT, Type = Double, Dynamic = False, Default = \"503", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_HOSTILENAME, Type = Double, Dynamic = False, Default = \"455", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_IDCOLLISION, Type = Double, Dynamic = False, Default = \"452", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_INVALIDUSERNAME, Type = Double, Dynamic = False, Default = \"468", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_INVITEONLYCHAN, Type = Double, Dynamic = False, Default = \"473", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_ISCHANSERVICE, Type = Double, Dynamic = False, Default = \"484", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_KEYSET, Type = Double, Dynamic = False, Default = \"467", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_LAST_ERR_MSG, Type = Double, Dynamic = False, Default = \"504", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_LISTSYNTAX, Type = Double, Dynamic = False, Default = \"521", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_MODELESS, Type = Double, Dynamic = False, Default = \"477", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NCHANGETOOFAST, Type = Double, Dynamic = False, Default = \"438", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NEEDMOREPARAMS, Type = Double, Dynamic = False, Default = \"461", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NEEDREGGEDNICK, Type = Double, Dynamic = False, Default = \"477", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NICKCOLLISION, Type = Double, Dynamic = False, Default = \"436", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NICKLOST, Type = Double, Dynamic = False, Default = \"453", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NICKNAMEINUSE, Type = Double, Dynamic = False, Default = \"433", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NICKTOOFAST, Type = Double, Dynamic = False, Default = \"438", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOADMININFO, Type = Double, Dynamic = False, Default = \"423", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOCHANMODES, Type = Double, Dynamic = False, Default = \"477", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOCOLORSONCHAN, Type = Double, Dynamic = False, Default = \"408", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOLOGIN, Type = Double, Dynamic = False, Default = \"444", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOMOTD, Type = Double, Dynamic = False, Default = \"422", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NONICKNAMEGIVEN, Type = Double, Dynamic = False, Default = \"431", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOOPERHOST, Type = Double, Dynamic = False, Default = \"491", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOORIGIN, Type = Double, Dynamic = False, Default = \"409", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOPERMFORHOST, Type = Double, Dynamic = False, Default = \"463", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOPRIVILEGES, Type = Double, Dynamic = False, Default = \"481", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NORECIPIENT, Type = Double, Dynamic = False, Default = \"411", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOSERVICEHOST, Type = Double, Dynamic = False, Default = \"492", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOSUCHCHANNEL, Type = Double, Dynamic = False, Default = \"403", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOSUCHGLINE, Type = Double, Dynamic = False, Default = \"512", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOSUCHNICK, Type = Double, Dynamic = False, Default = \"401", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOSUCHSERVER, Type = Double, Dynamic = False, Default = \"402", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOSUCHSERVICE, Type = Double, Dynamic = False, Default = \"408", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOTEXTTOSEND, Type = Double, Dynamic = False, Default = \"412", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOTONCHANNEL, Type = Double, Dynamic = False, Default = \"442", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOTOPLEVEL, Type = Double, Dynamic = False, Default = \"413", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOTREGISTERED, Type = Double, Dynamic = False, Default = \"451", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NUMERIC_ERR, Type = Double, Dynamic = False, Default = \"999", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_ONLYSERVERSCANCHANGE, Type = Double, Dynamic = False, Default = \"468", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_PASSWDMISMATCH, Type = Double, Dynamic = False, Default = \"464", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_QUERYTOOLONG, Type = Double, Dynamic = False, Default = \"416", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_SERVICECONFUSED, Type = Double, Dynamic = False, Default = \"435", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_SERVICENAMEINUSE, Type = Double, Dynamic = False, Default = \"434", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_SERVICESDOWN, Type = Double, Dynamic = False, Default = \"440", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_SILELISTFULL, Type = Double, Dynamic = False, Default = \"511", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_SUMMONDISABLED, Type = Double, Dynamic = False, Default = \"445", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TARGETTOOFAST, Type = Double, Dynamic = False, Default = \"439", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOOMANYAWAY, Type = Double, Dynamic = False, Default = \"429", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOOMANYCHANNELS, Type = Double, Dynamic = False, Default = \"405", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOOMANYDCC, Type = Double, Dynamic = False, Default = \"514", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOOMANYMATCHES, Type = Double, Dynamic = False, Default = \"416", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOOMANYTARGETS, Type = Double, Dynamic = False, Default = \"407", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOOMANYWATCH, Type = Double, Dynamic = False, Default = \"512", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TSLESSCHAN, Type = Double, Dynamic = False, Default = \"488", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UMODEUNKNOWNFLAG, Type = Double, Dynamic = False, Default = \"501", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UNAVAILRESOURCE, Type = Double, Dynamic = False, Default = \"437", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UNIQOPPRIVSNEEDED, Type = Double, Dynamic = False, Default = \"485", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UNKNOWNCOMMAND, Type = Double, Dynamic = False, Default = \"421", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UNKNOWNMODE, Type = Double, Dynamic = False, Default = \"472", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_USERNOTINCHANNEL, Type = Double, Dynamic = False, Default = \"441", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_USERONCHANNEL, Type = Double, Dynamic = False, Default = \"443", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_USERSDISABLED, Type = Double, Dynamic = False, Default = \"446", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_USERSDONTMATCH, Type = Double, Dynamic = False, Default = \"502", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_VOICENEEDED, Type = Double, Dynamic = False, Default = \"489", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_WASNOSUCHNICK, Type = Double, Dynamic = False, Default = \"406", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_WHOLIMEXCEED, Type = Double, Dynamic = False, Default = \"523", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_WHOSYNTAX, Type = Double, Dynamic = False, Default = \"522", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_WILDTOPLEVEL, Type = Double, Dynamic = False, Default = \"414", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_YOUREBANNEDCREEP, Type = Double, Dynamic = False, Default = \"465", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_YOUWILLBEBANNED, Type = Double, Dynamic = False, Default = \"466", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ADMINEMAIL, Type = Double, Dynamic = False, Default = \"259", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ADMINLOC1, Type = Double, Dynamic = False, Default = \"257", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ADMINLOC2, Type = Double, Dynamic = False, Default = \"258", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ADMINME, Type = Double, Dynamic = False, Default = \"256", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_AWAY, Type = Double, Dynamic = False, Default = \"301", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_BADCHANPASS, Type = Double, Dynamic = False, Default = \"339", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_BANLIST, Type = Double, Dynamic = False, Default = \"367", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_BOUNCE, Type = Double, Dynamic = False, Default = \"005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CHANNELMODEIS, Type = Double, Dynamic = False, Default = \"324", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CHANPASSOK, Type = Double, Dynamic = False, Default = \"338", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CHPASSUNKNOWN, Type = Double, Dynamic = False, Default = \"327", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CLOSEEND, Type = Double, Dynamic = False, Default = \"363", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CLOSING, Type = Double, Dynamic = False, Default = \"362", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_COMMANDSYNTAX, Type = Double, Dynamic = False, Default = \"334", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CREATED, Type = Double, Dynamic = False, Default = \"003", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_CREATIONTIME, Type = Double, Dynamic = False, Default = \"329", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_DCCINFO, Type = Double, Dynamic = False, Default = \"620", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_DCCLIST, Type = Double, Dynamic = False, Default = \"618", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_DCCSTATUS, Type = Double, Dynamic = False, Default = \"617", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFBANLIST, Type = Double, Dynamic = False, Default = \"368", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFDCCLIST, Type = Double, Dynamic = False, Default = \"619", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFEXCEPTLIST, Type = Double, Dynamic = False, Default = \"349", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFGLIST, Type = Double, Dynamic = False, Default = \"281", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFINFO, Type = Double, Dynamic = False, Default = \"374", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFINVITELIST, Type = Double, Dynamic = False, Default = \"347", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFLINKS, Type = Double, Dynamic = False, Default = \"365", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFMOTD, Type = Double, Dynamic = False, Default = \"376", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFNAMES, Type = Double, Dynamic = False, Default = \"366", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFSERVICES, Type = Double, Dynamic = False, Default = \"232", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFSILELIST, Type = Double, Dynamic = False, Default = \"272", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFSTATS, Type = Double, Dynamic = False, Default = \"219", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFTRACE, Type = Double, Dynamic = False, Default = \"262", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFUSERS, Type = Double, Dynamic = False, Default = \"394", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFWATCHLIST, Type = Double, Dynamic = False, Default = \"607", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFWHO, Type = Double, Dynamic = False, Default = \"315", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFWHOIS, Type = Double, Dynamic = False, Default = \"318", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ENDOFWHOWAS, Type = Double, Dynamic = False, Default = \"369", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_EXCEPTLIST, Type = Double, Dynamic = False, Default = \"348", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_GLIST, Type = Double, Dynamic = False, Default = \"280", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_GLOBALUSERS, Type = Double, Dynamic = False, Default = \"266", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_HELPFWD, Type = Double, Dynamic = False, Default = \"294", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_HELPHDR, Type = Double, Dynamic = False, Default = \"290", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_HELPHLP, Type = Double, Dynamic = False, Default = \"293", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_HELPIGN, Type = Double, Dynamic = False, Default = \"295", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_HELPOP, Type = Double, Dynamic = False, Default = \"291", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_HELPTLR, Type = Double, Dynamic = False, Default = \"292", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_INFO, Type = Double, Dynamic = False, Default = \"371", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_INFOSTART, Type = Double, Dynamic = False, Default = \"373", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_INVITELIST, Type = Double, Dynamic = False, Default = \"346", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_INVITING, Type = Double, Dynamic = False, Default = \"341", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_ISON, Type = Double, Dynamic = False, Default = \"303", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_KILLDONE, Type = Double, Dynamic = False, Default = \"361", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LINKS, Type = Double, Dynamic = False, Default = \"364", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LIST, Type = Double, Dynamic = False, Default = \"322", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LISTEND, Type = Double, Dynamic = False, Default = \"323", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LISTSTART, Type = Double, Dynamic = False, Default = \"321", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LISTUSAGE, Type = Double, Dynamic = False, Default = \"334", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LOAD2HI, Type = Double, Dynamic = False, Default = \"263", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LOCALUSERS, Type = Double, Dynamic = False, Default = \"265", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LOGOFF, Type = Double, Dynamic = False, Default = \"601", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LOGON, Type = Double, Dynamic = False, Default = \"600", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LUSERCHANNELS, Type = Double, Dynamic = False, Default = \"254", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LUSERCLIENT, Type = Double, Dynamic = False, Default = \"251", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LUSERME, Type = Double, Dynamic = False, Default = \"255", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LUSEROP, Type = Double, Dynamic = False, Default = \"252", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_LUSERUNKNOWN, Type = Double, Dynamic = False, Default = \"253", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MAP, Type = Double, Dynamic = False, Default = \"005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MAPEND, Type = Double, Dynamic = False, Default = \"007", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MAPMORE, Type = Double, Dynamic = False, Default = \"006", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MOTD, Type = Double, Dynamic = False, Default = \"372", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MOTDSTART, Type = Double, Dynamic = False, Default = \"375", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MYINFO, Type = Double, Dynamic = False, Default = \"004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_MYPORTIS, Type = Double, Dynamic = False, Default = \"384", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NAMREPLY, Type = Double, Dynamic = False, Default = \"353", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOCHANPASS, Type = Double, Dynamic = False, Default = \"326", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NONE, Type = Double, Dynamic = False, Default = \"300", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOTOPERANYMORE, Type = Double, Dynamic = False, Default = \"385", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOTOPIC, Type = Double, Dynamic = False, Default = \"331", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOUSERS, Type = Double, Dynamic = False, Default = \"395", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOWAWAY, Type = Double, Dynamic = False, Default = \"306", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOWOFF, Type = Double, Dynamic = False, Default = \"605", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_NOWON, Type = Double, Dynamic = False, Default = \"604", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_PROTOCTL, Type = Double, Dynamic = False, Default = \"005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_REHASHING, Type = Double, Dynamic = False, Default = \"382", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SERVICE, Type = Double, Dynamic = False, Default = \"233", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SERVICEINFO, Type = Double, Dynamic = False, Default = \"231", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SERVLIST, Type = Double, Dynamic = False, Default = \"234", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SERVLISTEND, Type = Double, Dynamic = False, Default = \"235", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SILELIST, Type = Double, Dynamic = False, Default = \"271", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SNOMASK, Type = Double, Dynamic = False, Default = \"008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATMEM, Type = Double, Dynamic = False, Default = \"010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATMEMTOT, Type = Double, Dynamic = False, Default = \"009", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSBLINE, Type = Double, Dynamic = False, Default = \"247", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSBLINE_1, Type = Double, Dynamic = False, Default = \"222", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSCLINE, Type = Double, Dynamic = False, Default = \"213", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSCOMMANDS, Type = Double, Dynamic = False, Default = \"212", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSCONN, Type = Double, Dynamic = False, Default = \"250", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSCOUNT, Type = Double, Dynamic = False, Default = \"226", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSDEBUG, Type = Double, Dynamic = False, Default = \"249", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSDEFINE, Type = Double, Dynamic = False, Default = \"248", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSDELTA, Type = Double, Dynamic = False, Default = \"274", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSDLINE, Type = Double, Dynamic = False, Default = \"275", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSDLINE_1, Type = Double, Dynamic = False, Default = \"250", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSDLINE_2, Type = Double, Dynamic = False, Default = \"225", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSELINE, Type = Double, Dynamic = False, Default = \"223", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSFLINE, Type = Double, Dynamic = False, Default = \"224", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSGLINE, Type = Double, Dynamic = False, Default = \"227", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSGLINE_1, Type = Double, Dynamic = False, Default = \"247", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSHLINE, Type = Double, Dynamic = False, Default = \"244", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSIAUTH, Type = Double, Dynamic = False, Default = \"239", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSILINE, Type = Double, Dynamic = False, Default = \"215", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSKLINE, Type = Double, Dynamic = False, Default = \"216", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSLINKINFO, Type = Double, Dynamic = False, Default = \"211", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSLLINE, Type = Double, Dynamic = False, Default = \"241", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSNLINE, Type = Double, Dynamic = False, Default = \"214", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSOLINE, Type = Double, Dynamic = False, Default = \"243", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSPING, Type = Double, Dynamic = False, Default = \"246", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSPLINE, Type = Double, Dynamic = False, Default = \"217", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSPLINE_1, Type = Double, Dynamic = False, Default = \"220", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSQLINE, Type = Double, Dynamic = False, Default = \"217", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSSLINE, Type = Double, Dynamic = False, Default = \"245", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSTLINE_1, Type = Double, Dynamic = False, Default = \"246", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSULINE, Type = Double, Dynamic = False, Default = \"246", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSULINE_1, Type = Double, Dynamic = False, Default = \"248", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSUPTIME, Type = Double, Dynamic = False, Default = \"242", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSVLINE, Type = Double, Dynamic = False, Default = \"240", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSXLINE, Type = Double, Dynamic = False, Default = \"247", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSYLINE, Type = Double, Dynamic = False, Default = \"218", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_STATSZLINE, Type = Double, Dynamic = False, Default = \"225", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_SUMMONING, Type = Double, Dynamic = False, Default = \"342", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TEXT, Type = Double, Dynamic = False, Default = \"304", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TIME, Type = Double, Dynamic = False, Default = \"391", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TOPIC, Type = Double, Dynamic = False, Default = \"332", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TOPICWHOTIME, Type = Double, Dynamic = False, Default = \"333", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACECLASS, Type = Double, Dynamic = False, Default = \"209", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACECONNECTING, Type = Double, Dynamic = False, Default = \"201", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACEEND, Type = Double, Dynamic = False, Default = \"262", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACEHANDSHAKE, Type = Double, Dynamic = False, Default = \"202", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACELINK, Type = Double, Dynamic = False, Default = \"200", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACELOG, Type = Double, Dynamic = False, Default = \"261", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACENEWTYPE, Type = Double, Dynamic = False, Default = \"208", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACEOPERATOR, Type = Double, Dynamic = False, Default = \"204", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACEPING, Type = Double, Dynamic = False, Default = \"262", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACERECONNECT, Type = Double, Dynamic = False, Default = \"210", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACESERVER, Type = Double, Dynamic = False, Default = \"206", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACESERVICE, Type = Double, Dynamic = False, Default = \"207", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACEUNKNOWN, Type = Double, Dynamic = False, Default = \"203", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRACEUSER, Type = Double, Dynamic = False, Default = \"205", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_TRYAGAIN, Type = Double, Dynamic = False, Default = \"263", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_UMODEIS, Type = Double, Dynamic = False, Default = \"221", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_UNAWAY, Type = Double, Dynamic = False, Default = \"305", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_UNIQOPIS, Type = Double, Dynamic = False, Default = \"325", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_USERHOST, Type = Double, Dynamic = False, Default = \"302", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_USERIP, Type = Double, Dynamic = False, Default = \"307", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_USERS, Type = Double, Dynamic = False, Default = \"393", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_USERSSTART, Type = Double, Dynamic = False, Default = \"392", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_VERSION, Type = Double, Dynamic = False, Default = \"351", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WATCHLIST, Type = Double, Dynamic = False, Default = \"606", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WATCHOFF, Type = Double, Dynamic = False, Default = \"602", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WATCHSTAT, Type = Double, Dynamic = False, Default = \"603", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WELCOME, Type = Double, Dynamic = False, Default = \"001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISADMIN, Type = Double, Dynamic = False, Default = \"308", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISCHANNELS, Type = Double, Dynamic = False, Default = \"319", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISCHANOP, Type = Double, Dynamic = False, Default = \"316", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISIDLE, Type = Double, Dynamic = False, Default = \"317", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISOPERATOR, Type = Double, Dynamic = False, Default = \"313", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISREGNICK, Type = Double, Dynamic = False, Default = \"307", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISSADMIN, Type = Double, Dynamic = False, Default = \"309", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISSERVER, Type = Double, Dynamic = False, Default = \"312", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISSVCMSG, Type = Double, Dynamic = False, Default = \"310", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOISUSER, Type = Double, Dynamic = False, Default = \"311", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOREPLY, Type = Double, Dynamic = False, Default = \"352", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOSPCRPL, Type = Double, Dynamic = False, Default = \"354", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_WHOWASUSER, Type = Double, Dynamic = False, Default = \"314", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_YOURCOOKIE, Type = Double, Dynamic = False, Default = \"014", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_YOUREOPER, Type = Double, Dynamic = False, Default = \"381", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_YOURESERVICE, Type = Double, Dynamic = False, Default = \"383", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RPL_YOURHOST, Type = Double, Dynamic = False, Default = \"002", Scope = Protected
	#tag EndConstant


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
End Module
#tag EndModule
