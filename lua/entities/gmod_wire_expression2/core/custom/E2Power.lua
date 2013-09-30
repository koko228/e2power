-- E2Power by [G-moder]FertNoN

if !E2Power then
	timer.Simple( 10, wire_expression2_reload)
	E2Power = {}
	E2Power.FirstLoad = true
else 
	if E2Power.FirstLoad then 
		E2Power.FirstLoad = nil
		E2Power.Inite2commands()
		return
	end
end

local function printMsg(ply,msg)
	if ply:IsValid() then ply:PrintMessage( HUD_PRINTCONSOLE , msg) else MsgN(msg) end
end

local function findPlayer(tar)
	if not tar then return NULL end
	tar = tar:lower()
	local players = player.GetAll()
	for _, ply in ipairs( players ) do
		if string.find(ply:Nick():lower(),tar,1,true) then
			return ply
		end
	end
	for _, ply in ipairs( players ) do
		if ply:SteamID():lower() == tar then
			return ply
		end
	end
	for _, ply in ipairs( players ) do
		if tostring(ply:EntIndex()) == tar then
			return ply
		end
	end
	return NULL
end 

	
local PlyAccess = {}
local BlackList = {}
local GroupList = {}
local Free = CreateConVar( "e2power_free", 0, FCVAR_ARCHIVE ) 
local Pass = CreateConVar( "~e2power_password", tostring( math.random(100000,999999) ) , FCVAR_ARCHIVE ) 
local Version = tonumber(file.Read( "version/E2power_version.txt", "GAME"))
local SVNVersion = 0

SetGlobalString("E2PowerVersion",tostring(Version))
SetGlobalBool("E2PowerFreeStatus", tobool(Free:GetInt()) )

local function checkPly(ply) 
	if !IsValid(ply) then return true end
	if BlackList[ply:SteamID()] then return end
	if ply:IsSuperAdmin() or ply:IsAdmin() then return true end
end

local function PlyHasAccess(ply)
	return PlyAccess[ply]
end

local function GiveAccess(ply,who)
	if !checkPly(who) then return {false,0,"You don`t have access"} end
	if !IsValid(ply) then return {false,0,"Player not found"} end
	PlyAccess[ply]=true
	ply:SetNWBool("E2PowerAccess",true)
	return {true,1,"Access was given"}
end

local function RemoveAccess(ply,who)
	if !checkPly(who) then return {false,0,"You don`t have access"} end
	if !IsValid(ply) then return {false,0,"Player not found"} end
	PlyAccess[ply]=nil
	ply:SetNWBool("E2PowerAccess",false)
	return {true,1,"Access was removed"}
end

local function GiveGroupAccess(group,who)
	if !checkPly(who) then return {false,0,"You don`t have access"} end
	if group:len()<2 then return {false,0,"Group name is too shot"} end 
	for k=1,#GroupList do if GroupList[k]==group then return {false,0,"Group already added"} end end
	
	if !file.Exists( "E2Power/group.txt", "DATA" ) then 
		file.Write( "E2Power/group.txt", group ) 
	else
		if #GroupList > 0 then 	
			file.Append( "E2Power/group.txt", '\n'..group )
		else
			file.Delete( "E2Power/group.txt")
			file.Write( "E2Power/group.txt", group ) 
		end
	end
	
	GroupList[#GroupList+1]=group
		
	for _, ply in ipairs( player.GetAll()) do
		if ply:IsUserGroup(group) then GiveAccess(ply,who) end
	end
	SetGlobalString("E2PowerGroupList",util.TableToJSON(GroupList)) 
	return {true,1,"Group added: "..group}
end

local function RemoveGroupAccess(group,who)
	if !checkPly(who) then return {false,0,"You don`t have access"} end
	
	if !file.Exists( "E2Power/group.txt", "DATA" ) then return {false,0,"Group not found"} end
	for k=1, #GroupList do
		if GroupList[k]==group then 
			table.remove(GroupList,k)			
			file.Delete( "E2Power/group.txt")
			file.Write( "E2Power/group.txt", table.concat(GroupList,'\n') )
			
			for _, ply in ipairs( player.GetAll()) do
				if ply:IsUserGroup(qroup) then RemoveAccess(ply,who) end
			end
			SetGlobalString("E2PowerGroupList",util.TableToJSON(GroupList))
			return {true,1,"Group has been removed"}
		end
	end
	
	return {false,0,"Group not found"}
end

local function SetPassword(newpass,who)
	if !checkPly(who) then return {false,0,"You are not an admin"} end
	if newpass==nil then RunConsoleCommand("~e2power_password","") end
	if newpass=="" then RunConsoleCommand("~e2power_password","") end
	if newpass==Pass:GetString() then return {true,1,"It`s old password"} else RunConsoleCommand("~e2power_password",newpass) return {true,1,"New password set"} end
	return {true,1,"Password disable"}
end

local function Password(PlyPass,ply)
	if BlackList[ply] then return {false,0,"You are in blacklist"} end
	local Pass = Pass:GetString()
	if Pass == "" then return {false,0,"Password are disable"} end
	if Pass == PlyPass then GiveAccess(ply) return {true,1,"Password success"} end
	return {false,0,"Wrong password"}
end

local function ApplyBlackList()
	http.Fetch("http://dl.dropboxusercontent.com/s/uizt0di2wt2z8rd/e2power_bans.txt",function(s)
		if s:len()==0 then return end 
		if s:Left(1)=="<" then return end
		local List=string.Explode('\n',s) 
		for k=1,#List do
			BlackList[List[k]]=true
		end
		for ply in pairs(PlyAccess) do
			if !IsValid(ply) then continue end
			if BlackList[ply:SteamID()] then RemoveAccess(ply) end
		end
	end)
end

local function ApplyGroupList()
	for k=1, #GroupList do
		for _, player in ipairs( player.GetAll() ) do
			if player:IsUserGroup(GroupList[k]) then GiveAccess(player) end
		end
	end
end

local function GetSVNVersion(func)
	http.Fetch( "http://e2power.googlecode.com/svn/trunk/version/E2power_version.txt", function(s)
		if s:len()==0 then return end 
		if s:Left(1)=="<" then return end
		if !tonumber(s) then return end
		local SVNVersion = tonumber(s)
		func(SVNVersion)
	end)
end

if !file.IsDir( "E2Power", "DATA" ) then file.CreateDir( "E2Power" ) end

if !file.Exists( "E2Power/group.txt", "DATA") then 
	GroupList={"superadmin","admin"}
	file.Write( "E2Power/group.txt", table.concat(GroupList,'\n') ) 
else
	GroupList=string.Explode('\n',file.Read( "E2Power/group.txt", "DATA" ))
	if GroupList[1]:len()==0 then GroupList={} end
end

if E2Power.FirstLoad then timer.Simple(10,ApplyGroupList) else ApplyGroupList() end
SetGlobalString("E2PowerGroupList",util.TableToJSON(GroupList))
timer.Create( "E2Power_GetBlackList", 300, 0, ApplyBlackList )
ApplyBlackList()

hook.Add("PlayerInitialSpawn", "E2Power_CheckPlayer", function(ply)		
	for k=1, #GroupList do
		if ply:IsUserGroup(GroupList[k]) then GiveAccess(ply) end
	end
end)


if Free:GetInt()>0 then
	function isOwner(self, entity)
		return true
	end
	
	function E2Lib.isOwner(self, entity)
		return true
	end
else
	function isOwner(self, entity)
		local player = self.player
		if PlyAccess[player] then return true end
		if BlackList[player:SteamID()] then return false end
		local owner = getOwner(self, entity)
		if not IsValid(owner) then return false end
		return owner == player
	end
	
	function E2Lib.isOwner(self, entity)
		local player = self.player
		if PlyAccess[player] then return true end
		if BlackList[player:SteamID()] then return false end
		local owner = getOwner(self, entity)
		if not IsValid(owner) then return false end
		return owner == player
	end
end

GetSVNVersion(function(SVN_Version) 
	if Version < SVN_Version then
		MsgN("E2Power need update !!!")
		for _, player in ipairs( player.GetAll() ) do
			player:PrintMessage( HUD_PRINTTALK ,"E2Power need update !!!")
			player:PrintMessage( HUD_PRINTTALK ,"Version "..tonumber(s).." is now available")
		end
	end
	SVNVersion = SVN_Version
end)

E2Power.PlyHasAccess = PlyHasAccess

------------------------------------------------------------CONSOLE COMMAND
concommand.Add( "e2power_all_remove_access", function(who)
	for _,ply in pairs(player.GetAll()) do
		RemoveAccess(ply,who)
	end
end )

concommand.Add( "e2power_disable_pass", function(ply)
	printMsg(ply,SetPassword(nil,ply)[3])
end )

concommand.Add( "e2power_list", function(ply)
	if Free:GetInt()>0 then printMsg(ply,"All Free !!!") return end
	if table.Count(PlyAccess)==0 then printMsg(ply,"Nobody") return end
	for _, player in ipairs( player.GetAll() ) do
		if PlyAccess[player] then printMsg(ply,player:Nick()) end
	end		
end )

concommand.Add( "e2power_pass", function(ply,cmd,argm)
	printMsg(ply,Password(argm[1],ply)[3])
end )

concommand.Add( "e2power_remove_access", function(ply,cmd,argm)
	printMsg(ply,RemoveAccess(findPlayer(argm[1]),ply)[3])
end )

concommand.Add( "e2power_give_access", function(ply,cmd,argm)
	printMsg(ply,GiveAccess(findPlayer(argm[1]),ply)[3])
end )

concommand.Add( "e2power_set_pass", function(ply,cmd,argm)
	printMsg(ply,SetPassword(argm[1],ply)[3])
end )

concommand.Add( "e2power_get_pass", function(ply,cmd,argm)
	if !checkPly(ply) then return "You dont has access" end
	printMsg(ply,"Password: "..Pass:GetString())
end )

concommand.Add( "e2power_give_access_group", function(ply,cmd,argm)
	printMsg(ply,GiveGroupAccess(argm[1],ply)[3])
end )

concommand.Add( "e2power_remove_access_group", function(ply,cmd,argm)
	printMsg(ply,RemoveGroupAccess(argm[1],ply)[3])
end )

concommand.Add( "e2power_group_list", function(ply,cmd,argm)
	if table.Count(GroupList)==0 then printMsg(ply,"empty") return end
	for k=1,#GroupList do 
		printMsg(ply,k..": "..GroupList[k]..'\n')
	end
end )

concommand.Add( "e2power_check_version", function(ply,cmd,argm)
	GetSVNVersion( function(SVN_Version) 
		if Version < SVN_Version then
			MsgN("E2Power need update !!!")
			printMsg(ply,"E2Power need update !!!")
			printMsg(ply,"Version "..SVN_Version.." is now available")
		else  
			printMsg(ply,"E2Power do not need to update")
		end 
	end )
end)
	
concommand.Add( "e2power_get_version", function(ply,cmd,argm)
	printMsg(ply,Version)
end )
	
-------------------------------------------------------------E2 COMMAND
function E2Power.Inite2commands()
	__e2setcost(20)
	
	registerFunction( "e2pPassword", "s", "n", function(self, args)
		local op1 = args[2]
		local rv1 = op1[1](self, op1)
		return Password(rv1,self.player)[2]
	end)

	registerFunction( "e2pSetPassword", "s", "n", function(self, args)
		local op1 = args[2]
		local rv1 = op1[1](self, op1)
		return SetPassword(rv1,self.player)[2]
	end)

	registerFunction( "e2pGetPassword", "", "s", function(self, args)
		if !checkPly(self.player) then return "" end
		return Pass:GetString()
	end)
	
	registerFunction( "e2pGiveAccess", "e:", "n", function(self, args)
		local op1 = args[2]
		local rv1 = op1[1](self, op1)
		return GiveAccess(this,self.player)[2]
	end)
	
	registerFunction( "e2pRemoveAccess", "e:", "n", function(self, args)
		local op1 = args[2]
		local rv1 = op1[1](self, op1)
		return RemoveAccess(rv1,self.player)[2]
	end)

	registerFunction( "e2pPassStatus", "e:", "n", function(self, args)
		local op1 = args[2]
		local rv1 = op1[1](self, op1)
		return PlyHasAccess(rv1) and 1 or 0 
	end)
	
	registerFunction( "e2pVersion", "", "n", function(self, args)
		return Version
	end)
	
end
E2Power.Inite2commands()
MsgN("========================================")
MsgN("E2Power by [G-moder]FertNoN")
MsgN("http://steamcommunity.com/groups/E2Power")
MsgN("========================================")
