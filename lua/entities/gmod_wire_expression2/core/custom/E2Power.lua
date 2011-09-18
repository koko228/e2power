//E2POWER made by [G-moder]FertNoN

local function findPlayer(ply,target)
	if not target then return 1 end
	local players = player.GetAll()
	target = target:lower()
	
	for _, player in ipairs( players ) do
		if string.find(player:Nick():lower(),target,1,true) then
			ply:PrintMessage( HUD_PRINTCONSOLE ,"player find: "..player:Nick())
			player:PrintMessage( HUD_PRINTTALK ,"you have e2p access")
			return player
		end
	end
	ply:PrintMessage( HUD_PRINTCONSOLE ,"Player not find")
	return 1
end

-----------------------------------------------------------setup PASS
PassAlert = {}

Password = file.Read( "E2Power/pass.txt" )
if Password==nil then
	local str
	str="MingeBag"
	file.Write( "E2Power/pass.txt", str ) 
	Password=str
end

if Password=="null" then 
	Password=nil
end

------------------------------------------------------------CONSOLE COMMAND
concommand.Add( "e2power_all_remove_access", function()
	PassAlert = {}
end )

concommand.Add( "e2power_disable", function()
	Password=nil
	PassAlert = {}
	file.Write( "E2Power/pass.txt", "null" )
end )

concommand.Add( "e2power_list", function(ply,cmd,argm)

	local players = player.GetAll()
	
	if ply:IsSuperAdmin() or ply:IsAdmin() then 

		for _, player in ipairs( players ) do
			ply:PrintMessage( HUD_PRINTCONSOLE ,player:Nick().." "..tostring(PassAlert[player]))
		end
	else
		ply:PrintMessage( HUD_PRINTCONSOLE ,"You are not Admin")
	end
		
end )

concommand.Add( "e2power_pass", function(ply,cmd,argm)
	if !ply:IsSuperAdmin() and !ply:IsAdmin() then PassAlert[ply]=true end
	if argm[1] == Password then PassAlert[ply]=true end
end )

concommand.Add( "e2power_remove_access", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then PassAlert[findPlayer(ply,argm[1])]=nil end
end )

concommand.Add( "e2power_give_access", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then PassAlert[findPlayer(ply,argm[1])]=true end
end )

concommand.Add( "e2power_set_pass", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then 

	local newpass
	newpass=argm[1]

	if newpass==nil then return end
	if newpass=="" then return end
	if newpass==Password then return end
	if newpass=="null" then Password=nil else Password=newpass end
	file.Write( "E2Power/pass.txt", newpass ) 
	ply:PrintMessage( HUD_PRINTCONSOLE ,"pass set")
	end
end )

concommand.Add( "e2power_get_pass", function(ply,cmd,argm)
	if ply:IsSuperAdmin() or ply:IsAdmin() then  
		ply:PrintMessage( HUD_PRINTCONSOLE ,Password)
	end
end )

-------------------------------------------------------------E2 COMMAND

__e2setcost(20)
e2function void e2pPassword(string pass)
	if pass ==  Password
	then 
		PassAlert[self.player]=true
	end
end

e2function void e2pSetPassword(string newpass)
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	if newpass=="" then return end
	if newpass==Password then return end
	if newpass=="null" then Password=nil else Password=newpass end
	file.Write( "E2Power/pass.txt", newpass ) 
end

e2function string e2pGetPassword()
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	return Password
end

e2function void entity:e2pGiveAccess()
	if !validEntity(this)  then return end
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	PassAlert[getOwner(self,this)]=true
end

e2function void entity:e2pRemoveAccess()
	if !validEntity(this)  then return end
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	PassAlert[getOwner(self,this)]=nil
end

e2function number entity:e2pPassStatus()
	if !validEntity(this)  then return end
	if PassAlert[this] then return 1 else return 0 end
end

-------------------------------------------------------------------------------------------------Access setting
function isOwner(self, entity)
	if PassAlert[self.player] then return true end
	local player = self.player
	local owner = getOwner(self, entity)
	if not validEntity(owner) then return false end
	return owner == player
end

function E2Lib.isOwner(self, entity)
	if PassAlert[self.player] then return true end
	local player = self.player
	local owner = getOwner(self, entity)
	if not validEntity(owner) then return false end
	return owner == player
end

------------------------------------------------------------------------

Msg("\n========================================")
Msg("\nE2Power by [G-moder]FertNoN\n")
Msg("\nhttp://www.gmodlive.com/forum/59-314-1")
Msg("========================================\n")