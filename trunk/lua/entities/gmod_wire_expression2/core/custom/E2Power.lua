//E2POWER made by [G-moder]FertNoN



-------------------------------------------------------------------------------------Password setting
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

concommand.Add( "wire_expression2_e2power_all_remove_access", function()
PassAlert = {}
end )

concommand.Add( "wire_expression2_e2power_disable", function()
Password=nil
PassAlert = {}
file.Write( "E2Power/pass.txt", "null" )
end )


__e2setcost(20)
e2function void e2pPassword(string pass)
	if pass ==  Password
	then 
		PassAlert[self.entity]=true
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
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	PassAlert[this]=true
end

e2function void entity:e2pRemoveAccess()
	if !self.player:IsSuperAdmin() and !self.player:IsAdmin() then return end
	PassAlert[this]=nil
end

e2function number entity:e2pPassStatus()
	if PassAlert[this] then return 1 else return 0 end
end

-------------------------------------------------------------------------------------------------Access setting
function isOwner(self, entity)
	if PassAlert[self.entity] then return true end
	local player = self.player
	local owner = getOwner(self, entity)
	if not validEntity(owner) then return false end
	return owner == player
end
------------------------------------------------------------------------

include("entity.lua")

Msg("\n===================")
Msg("\nE2Power v7 load\n")
Msg("http://www.gmodlive.com/forum/44-338-1 visit for update\n")
Msg("===================\n")