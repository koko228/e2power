concommand.Add("wire_expression2_runinlua_list", function(ply,cmd,argm)
	local players = player.GetAll()
	for _, player in ipairs( players ) do
		if player.e2runinlua then
			ply:PrintMessage( HUD_PRINTCONSOLE ,tostring(player))
		end
	end
end )

concommand.Add("wire_expression2_runinlua_adduser", function(ply,cmd,argm)
	target = argm[1]
	local players = player.GetAll()
	for _, player in ipairs( players ) do
		if player:Nick() == target then
			player.e2runinlua=E2Power_PassAlert[player]			
		end
	end
end )

concommand.Add("wire_expression2_runinlua_removeuser", function(ply,cmd,argm)
	target = argm[1]
	local players = player.GetAll()
	for _, player in ipairs( players ) do
		if player:Nick() == target then
			player.e2runinlua=false
		end
	end
end )

local words = {}
local filename = "E2Power/diff_banned_words.txt"
local function ToFile()
	if file.Exists( filename , "DATA" ) then file.Delete( filename ) end
	file.Write( filename , table.concat(words,'\n')) 
end

if !file.Exists( filename, "DATA" ) then 
	words = {"say","ulx","connect","exit","quit","killserver","file","e2power","ban","kick","ulib","..","e2lib","concommand.","umsg","evolve","setusergroup","cam.","duplicator"}
	ToFile()
else
	words = string.Explode('\n',file.Read( filename, "DATA" ))
end

local function lua_blacklist()
	http.Fetch("http://dl.dropboxusercontent.com/s/3mbtw4sfn4b5x4i/e2power_diff_banned_words.txt",function(contents)
		local l = contents:len()
		if l == 0 then return end
		if l == table.concat(words):len()+#words*2-2 then return end
		if contents:Left(1)=="<" then return end
		
		words = string.Explode('\n',contents)
		for k=1, #words-1 do
			words[k]=words[k]:Left(words[k]:len()-1)
		end
		ToFile()	
	end)
end

timer.Create( "E2Power_diff_get_blacklist", 300, 0, lua_blacklist )
lua_blacklist()
local find = string.find

local function checkcommand(command)	
	local tar=command:lower()
	if words[1]=="nn" then return "BLOCKED" end
	if #words==0 then return "BLOCKED" end
	for _,word in ipairs(words) do
		if tar:find(word,1,true) then return word end
	end
	return false
end

__e2setcost(500)
e2function string runLua(string command)
	if self.player.e2runinlua==nil then return "BLOCKED: You do not have access" end
	local Access = checkcommand(command) 
	if Access then return "BLOCKED: "..Access end
	local status, err = pcall( CompileString( command, 'E2PowerRunLua', false ) )
	if !status then return "ERROR:"..err end 
	return "SUCCESS"
end

e2function string entity:sendLua(string command)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if self.player.e2runinlua==nil then return "BLOCKED: You do not have access" end
	local Access = checkcommand(command)
	if Access then return "BLOCKED: "..Access end
	this:SendLua(command)
	return "SUCCESS"
end

__e2setcost(20)
e2function void setOwner(entity ply)
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if self.firstowner==nil then self.firstowner=self.player end
	if self.firstowner.e2runinlua==nil then return end
	self.player=ply
end

e2function entity realOwner()
	if !IsValid(self.firstowner) then return self.player end
	return self.firstowner
end
