--E2POWER made by [G-moder]FertNoN
local function printMsg(ply,msg)
	if ply:IsValid() then ply:PrintMessage( HUD_PRINTCONSOLE , msg) else Msg(msg) end
end

local function checkPly(ply) 
	if !ply:IsValid() then return true end
	if ply:IsSuperAdmin() or ply:IsAdmin() then return true end
end

local function findPlayer(ply,target)
	if not target then return nil end
	local players = player.GetAll()
	target = target:lower()
	
	for _, player in ipairs( players ) do
		if string.find(player:Nick():lower(),target,1,true) then
			printMsg(ply,"player: "..player:Nick())
			return player
		end
	end
	printMsg(ply,"Player not found")
	return nil
end

-----------------------------------------------------------setup PASS
E2Power_PassAlert = {}
E2Power_Free = false
E2Power_pass = file.Read( "E2Power/pass.txt", "DATA")

if E2Power_pass==nil then
	str="MingeBag"
	file.Write( "E2Power/pass.txt", str ) 
	E2Power_pass=str
end

if E2Power_pass=="null" then 
	E2Power_pass=nil
end

E2Power_Free=file.Read( "E2Power/free.txt" )	

if E2Power_Free=="free" then 
	E2Power_Free = true
end

------------------------------------------------------------CONSOLE COMMAND
concommand.Add( "e2power_all_remove_access", function()
	E2Power_PassAlert = {}
end )

concommand.Add( "e2power_disable_pass", function()
	E2Power_pass=nil
	E2Power_PassAlert = {}
	file.Write( "E2Power/pass.txt", "null" )
end )

concommand.Add( "e2power_list", function(ply,cmd,argm)
	
	if E2Power_Free then printMsg(ply,"All Free !!!") return end
	if table.Count(E2Power_PassAlert)==0 then printMsg(ply,"Nobody") return end
	for _, player in ipairs( player.GetAll() ) do
		if E2Power_PassAlert[player] then printMsg(ply,player:Nick()) end
	end		
end )

concommand.Add( "e2power_pass", function(ply,cmd,argm)
	if !ply:IsValid() then return end
	if E2Power_BlackList[ply:SteamID()] then return end
	if checkPly(ply) then 
		printMsg(ply,"the Password is correct")
		E2Power_PassAlert[ply]=true 
		return
	end
	
	if argm[1] == E2Power_pass then 
			printMsg(ply,"the password is correct")
			E2Power_PassAlert[ply]=true 
	else 
		printMsg(ply,"the password is incorrect") 
	end
end )

concommand.Add( "e2power_remove_access", function(ply,cmd,argm)
	if checkPly(ply) then
	local player=findPlayer(ply,argm[1])
	if !IsValid(player) then return end
	printMsg(player,"you from E2Power accessing")
	E2Power_PassAlert[player]=nil end
end )

concommand.Add( "e2power_give_access", function(ply,cmd,argm)
	if checkPly(ply) then 
	local player=findPlayer(ply,argm[1])
	if !IsValid(player) then return end
	if E2Power_BlackList[ply:SteamID()] then return end
	printMsg(player,"you were given E2Power access")
	E2Power_PassAlert[player]=true end
end )

concommand.Add( "e2power_set_pass", function(ply,cmd,argm)
	if checkPly(ply) then 

	local newpass
	newpass=argm[1]

	if newpass==nil then return end
	if newpass=="" then return end
	if newpass==E2Power_pass then return end
	if newpass=="null" then E2Power_pass=nil else E2Power_pass=newpass end
	file.Write( "E2Power/pass.txt", newpass ) 
	printMsg(ply,"pass set")
	end
end )

concommand.Add( "e2power_get_pass", function(ply,cmd,argm)
	if checkPly(ply) then  
		printMsg(ply,E2Power_pass)
	end
end )

concommand.Add( "e2power_set_pass_free", function(ply,cmd,argm)
	if checkPly(ply) then  
		if E2Power_Free==nil then E2Power_Free=false end 
		E2Power_Free = false == E2Power_Free
		if E2Power_Free then 
			file.Write( "E2Power/free.txt", "free" ) 
			printMsg(ply,"E2Power became a free")
			RunConsoleCommand("wire_expression2_reload")
		else
			file.Delete( "E2Power/free.txt" )
			printMsg(ply,"E2Power free use off")
			RunConsoleCommand("wire_expression2_reload")
		end
	end
end )


concommand.Add( "e2power_give_access_group", function(ply,cmd,argm)
	if checkPly(ply) then  
		if not file.Exists( "E2Power/group.txt", "DATA" ) then 
			file.Write( "E2Power/group.txt", argm[1] ) 
		else
			file.Append( "E2Power/group.txt", '\n'..argm[1] )
		end
		E2Power_GroupList[#E2Power_GroupList+1]=argm[1]
		
		for _, ply in ipairs( player.GetAll()) do
			if ply:IsUserGroup(argm[1]) then E2Power_PassAlert[ply] = !E2Power_BlackList[ply:SteamID()] end
		end
		printMsg(ply,"Group added: "..argm[1])
	end
end )

concommand.Add( "e2power_remove_access_group", function(ply,cmd,argm)
	if !checkPly(ply) then return end 
	if !file.Exists( "E2Power/group.txt", "DATA" ) then printMsg(ply,"Group not found") return end
		
	for k=1, #E2Power_GroupList do
		local qroup = E2Power_GroupList[k]
		if qroup==argm[1] then
			table.remove(E2Power_GroupList,k)
			
			file.Delete( "E2Power/group.txt")
			if #E2Power_GroupList > 0 then 
				file.Write( "E2Power/group.txt", table.concat(E2Power_GroupList,'\n') ) 
			end
				
			for _, ply in ipairs( player.GetAll()) do
				if ply:IsUserGroup(qroup) then E2Power_PassAlert[ply]=nil end
			end
			printMsg(ply,"Group has been removed")
			return
		end
	end
	printMsg(ply,"Group not found")
	
end )

concommand.Add( "e2power_group_list", function(ply,cmd,argm)
	if table.Count(E2Power_GroupList)==0 then printMsg(ply,"empty") return end
	for k=1,#E2Power_GroupList do 
		printMsg(ply,E2Power_GroupList[k]..'\n')
	end
end )


-------------------------------------------------------------E2 COMMAND

__e2setcost(20)
e2function void e2pPassword(string pass)
	if pass ==  E2Power_pass
	then 
		E2Power_PassAlert[self.player] = !E2Power_BlackList[self.player:SteamID()]
	end
end

e2function void e2pSetPassword(string newpass)
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	if newpass=="" then return end
	if newpass==E2Power_pass then return end
	if newpass=="null" then E2Power_pass=nil else E2Power_pass=newpass end
	file.Write( "E2Power/pass.txt", newpass ) 
end

e2function string e2pGetPassword()
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	return E2Power_pass
end

e2function void entity:e2pGiveAccess()
	if !IsValid(this)  then return end
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	E2Power_PassAlert[getOwner(self,this)]=!E2Power_BlackList[self.player:SteamID()]
end

e2function void entity:e2pRemoveAccess()
	if !IsValid(this)  then return end
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	E2Power_PassAlert[getOwner(self,this)]=nil
end

e2function number entity:e2pPassStatus()
	if !IsValid(this)  then return end
	if E2Power_PassAlert[this] then return 1 else return 0 end
end

e2function number e2pVersion()
	return E2Power_Version
end

-------------------------------------------------------------------------------------------------Access setting
if E2Power_Free then

	function isOwner(self, entity)
		return true
	end
	function E2Lib.isOwner(self, entity)
		return true
	end

else

	function isOwner(self, entity)
		if E2Power_PassAlert[self.player] then return true end
		local player = self.player
		local owner = getOwner(self, entity)
		if not IsValid(owner) then return false end
		return owner == player
	end

	function E2Lib.isOwner(self, entity)
		if E2Power_PassAlert[self.player] then return true end
		local player = self.player
		local owner = getOwner(self, entity)
		if not IsValid(owner) then return false end
		return owner == player
	end

end

E2Power_BlackList = {}
E2Power_GroupList = {}

if !E2Power_first_load then
	timer.Create( "e2power_access", 10, 0, function()
		timer.Destroy("e2power_access")	
		RunConsoleCommand("wire_expression2_reload")
	end)
	
	E2Power_first_load=true
	return
end 

function E2Power_GetGroupList(nr)
	if nr then return end
	if !file.Exists( "E2Power/group.txt", "DATA") then return end	
	E2Power_GroupList=string.Explode('\n',file.Read( "E2Power/group.txt", "DATA" ))
		
	for k=1, #E2Power_GroupList do
		for _, player in ipairs( player.GetAll() ) do
			if player:IsUserGroup(E2Power_GroupList[k]) then E2Power_PassAlert[player] = !E2Power_BlackList[player:SteamID()] end
		end
	end
	
end
	
function E2Power_GetBlackList(nr)
	http.Fetch("http://dl.dropboxusercontent.com/s/uizt0di2wt2z8rd/e2power_bans.txt",function(contents)
		local List=string.Explode('\n',contents) 
		for k=1,#List do
			E2Power_BlackList[List[k]]=true
		end
		E2Power_GetGroupList(nr)
	end,E2Power_GetGroupList(nr))
end
		
timer.Create( "E2Power_GetBlackList", 300, 0, E2Power_GetBlackList,true)
E2Power_GetBlackList(false)

hook.Add("PlayerInitialSpawn", "E2Power_CheckUser", function(ply)		
	for k=1, #E2Power_GroupList do
		if ply:IsUserGroup(E2Power_GroupList[k]) then E2Power_PassAlert[ply] = !E2Power_BlackList[ply:SteamID()] end
	end
end)

Msg("\n========================================")
Msg("\nE2Power by [G-moder]FertNoN")
		
E2Power_Version = tonumber(file.Read( "version/E2power_version.txt", "GAME"))
http.Fetch( "http://e2power.googlecode.com/svn/trunk/version/E2power_version.txt", function(s)
	if s:len()!=0 then 	
		if E2Power_Version < tonumber(s)  then
			Msg("\nE2Power need update !!!\n")
			for _, player in ipairs( player.GetAll() ) do
				player:PrintMessage( HUD_PRINTTALK ,"E2Power need update !!!")
				player:PrintMessage( HUD_PRINTTALK ,"Version "..tonumber(s).." is now available")
			end
		end
	end	
end )
		
--Msg("\nhttp://forum.gmodlive.com/viewtopic.php?f=11&t=36")
Msg("\n========================================\n")

concommand.Add( "e2power_check_version", function(ply,cmd,argm)
	http.Fetch( "http://e2power.googlecode.com/svn/trunk/version/E2power_version.txt", function(s)
		local SVN_Version =  tonumber(s)
		if E2Power_Version < SVN_Version then
			Msg("\nE2Power need update !!!\n")
			printMsg(ply,"E2Power need update !!!")
			printMsg(ply,"Version "..SVN_Version.." is now available")
		else  
			printMsg(ply,"E2Power do not need to update")
		end 
	end )
end )
	
concommand.Add( "e2power_get_version", function(ply,cmd,argm)
	printMsg(ply,E2Power_Version)
end )