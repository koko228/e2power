--E2POWER made by [G-moder]FertNoN

local function findPlayer(ply,target)
	if not target then return 1 end
	local players = player.GetAll()
	target = target:lower()
	
	for _, player in ipairs( players ) do
		if string.find(player:Nick():lower(),target,1,true) then
			ply:PrintMessage( HUD_PRINTCONSOLE ,"player find: "..player:Nick())
			return player
		end
	end
	ply:PrintMessage( HUD_PRINTCONSOLE ,"Player not find")
	return 0
end

-----------------------------------------------------------setup PASS
E2Power_PassAlert = {}
E2Power_Free = false
E2Power_pass = file.Read( "E2Power/pass.txt" )

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

concommand.Add( "e2power_disable", function()
	E2Power_pass=nil
	E2Power_PassAlert = {}
	file.Write( "E2Power/pass.txt", "null" )
end )

concommand.Add( "e2power_list", function(ply,cmd,argm)
	
	if E2Power_Free then ply:PrintMessage( HUD_PRINTCONSOLE ,"All Free !!!") end
	local players = player.GetAll()
	
	for _, player in ipairs( players ) do
		ply:PrintMessage( HUD_PRINTCONSOLE ,player:Nick().." "..tostring(E2Power_PassAlert[player]))
	end		
end )

concommand.Add( "e2power_pass", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then 
	ply:PrintMessage( HUD_PRINTCONSOLE ,"the Password is correct")
	E2Power_PassAlert[ply]=true 
	return
	end
	
	if argm[1] == E2Power_pass then 
	ply:PrintMessage( HUD_PRINTCONSOLE ,"the password is correct")
	E2Power_PassAlert[ply]=true else 
	ply:PrintMessage( HUD_PRINTCONSOLE ,"the password is fail") end
end )

concommand.Add( "e2power_remove_access", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then
	local player=findPlayer(ply,argm[1])
	player:PrintMessage( HUD_PRINTTALK ,"you from E2Power accessing")
	E2Power_PassAlert[player]=nil end
end )

concommand.Add( "e2power_give_access", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then 
	local player=findPlayer(ply,argm[1])
	player:PrintMessage( HUD_PRINTTALK ,"you were given E2Power access")
	E2Power_PassAlert[player]=true end
end )

concommand.Add( "e2power_set_pass", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then 

	local newpass
	newpass=argm[1]

	if newpass==nil then return end
	if newpass=="" then return end
	if newpass==E2Power_pass then return end
	if newpass=="null" then E2Power_pass=nil else E2Power_pass=newpass end
	file.Write( "E2Power/pass.txt", newpass ) 
	ply:PrintMessage( HUD_PRINTCONSOLE ,"pass set")
	end
end )

concommand.Add( "e2power_get_pass", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then  
		ply:PrintMessage( HUD_PRINTCONSOLE ,E2Power_pass)
	end
end )

concommand.Add( "e2power_set_pass_free", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then  
		if E2Power_Free==nil then E2Power_Free=false end 
		E2Power_Free = false == E2Power_Free
		if E2Power_Free then 
			file.Write( "E2Power/free.txt", "free" ) 
			ply:PrintMessage( HUD_PRINTCONSOLE ,"E2Power became a free")
			RunConsoleCommand("wire_expression2_reload")
		else
			file.Delete( "E2Power/free.txt" )
			ply:PrintMessage( HUD_PRINTCONSOLE ,"E2Power now recovery record")
			RunConsoleCommand("wire_expression2_reload")
		end
	end
end )
-------------------------------------------------------------E2 COMMAND

__e2setcost(20)
e2function void e2pPassword(string pass)
	if pass ==  E2Power_pass
	then 
		E2Power_PassAlert[self.player]=true
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
	if !validEntity(this)  then return end
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	E2Power_PassAlert[getOwner(self,this)]=true
end

e2function void entity:e2pRemoveAccess()
	if !validEntity(this)  then return end
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	E2Power_PassAlert[getOwner(self,this)]=nil
end

e2function number entity:e2pPassStatus()
	if !validEntity(this)  then return end
	if E2Power_PassAlert[this] then return 1 else return 0 end
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
	if not validEntity(owner) then return false end
	return owner == player
end

function E2Lib.isOwner(self, entity)
	if E2Power_PassAlert[self.player] then return true end
	local player = self.player
	local owner = getOwner(self, entity)
	if not validEntity(owner) then return false end
	return owner == player
end

end

if !E2Power_first_load then
	timer.Create( "e2power_access", 10, 0, function()
		timer.Destroy("e2power_access")	
--		E2Lib.isOwner=isOwner
--		_G[isOwner]=isOwner
		RunConsoleCommand("wire_expression2_reload")
	end)
	
	E2Power_first_load=true
else 
	Msg("\n========================================")
	Msg("\nE2Power by [G-moder]FertNoN")
	
	local Version = tonumber(file.Read( "E2power_version.txt" ))
	http.Get( "http://e2power.googlecode.com/svn/trunk/data/E2power_version.txt", "", function(s)
		if s==nil then E2Power_Version=Version else E2Power_Version = tonumber(s) end
	end )
	if Version < E2Power_Version then
		Msg("\nE2Power need update !!!")
	
		local players = player.GetAll()
		for _, player in ipairs( players ) do
			player:PrintMessage( HUD_PRINTTALK ,"E2Power need update !!!")
		end
	
	end
	
	Msg("\nhttp://forum.gmodlive.com/viewtopic.php?f=11&t=36")
	Msg("\n========================================\n")
end


local cvar = GetConVar("sv_tags")
local tags = cvar:GetString()
if (!tags:find( "E2Power" )) then
	local tag = "E2Power"
	RunConsoleCommand( "sv_tags", tags .. "," .. tag )
end	

timer.Create("Wire_Tags",3,0,function()
	local cvar = GetConVar("sv_tags")
	local tags = cvar:GetString()
	if (!tags:find( "E2Power" )) then
		local tag = "E2Power"
		RunConsoleCommand( "sv_tags", tags .. "," .. tag )
	end	
end)

------------------------------------------------------------------------