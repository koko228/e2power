__e2setcost(5)
e2function number entity:isPhysics()
	if !validPhysics(this) then return 0 else return 1 end
end

e2function number entity:isExist()
	if !IsValid(this) then return 0 else return 1 end
end

e2function string entity:getUserGroup()
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	return this:GetUserGroup() 
end

__e2setcost(20)
e2function void entity:setVel(vector vel)
	if !IsValid(this)  then return end
	if !isOwner(self,this)  then return end
	if validPhysics(this) then 
	this:GetPhysicsObject():SetVelocity(Vector(vel[1],vel[2],vel[3])) 
	else
	this:SetVelocity(Vector(vel[1],vel[2],vel[3]))
	end
end


/*
function void bone:boneGravity(status)
	if !validBone(this) then return end
	local status = status > 0
	this:EnableGravity(status) 
end
*/
e2function void bone:setVel(vector vel)
	if !this:IsValid()  then return end
	if !isOwner(self,this)  then return end
	this:SetVelocity(Vector(vel[1],vel[2],vel[3])) 
end

e2function void entity:remove()
	if !IsValid(this)  then return end
	if !isOwner(self,this)  then return end
    if this:IsPlayer() then return end
	this:Remove()
end


e2function void entity:tele(vector pos)
	if !IsValid(this)  then return end
	if !isOwner(self,this)  then return end
	this:SetPos(Vector(math.Clamp(pos[1], -50000, 50000),math.Clamp(pos[2], -50000, 50000),math.Clamp(pos[3], -50000, 50000)))
end

e2function void entity:setPos(vector pos)
	if !IsValid(this)  then return end
	if !isOwner(self, this) then return end
	if validPhysics(this) then 
		local phys = this:GetPhysicsObject()
		phys:SetPos(Vector(math.Clamp(pos[1], -50000, 50000),math.Clamp(pos[2], -50000, 50000),math.Clamp(pos[3], -50000, 50000)))
		phys:Wake()
	else
		this:SetPos(Vector(math.Clamp(pos[1], -50000, 50000),math.Clamp(pos[2], -50000, 50000),math.Clamp(pos[3], -50000, 50000)))
	end
end

e2function void entity:setAng(angle rot)
	if !IsValid(this)  then return end
	if !isOwner(self, this) then return end
	if validPhysics(this) then 
		local phys = this:GetPhysicsObject()
		phys:SetAngles(Angle(rot[1],rot[2],rot[3]))
		phys:Wake()
	else
		this:SetAngles(Angle(rot[1],rot[2],rot[3]))
	end
end

----------------------------------------------------Wire
e2function void entity:setInput(string input,...)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	local ret = {...}
	this:TriggerInput( input , ret[1] )
end

e2function array entity:getOutput(string output)
	if !IsValid(this) then return end
	local ret =  {}
	ret[1]=this.Outputs[output].Value
	return ret
end

e2function angle entity:getOutputAngle(string output)
	if !IsValid(this) then return end
	return {this.Outputs[output].Value.p, this.Outputs[output].Value.y, this.Outputs[output].Value.r}
end

e2function string entity:getOutputType(string output)
	if !IsValid(this) then return end
	return type(this.Outputs[output].Value)
end

e2function string entity:getInputType(string input)
	if !IsValid(this) then return end
	return type(this.Inputs[input].Value)
end

e2function array entity:getInputsList()
	if !IsValid(this) then return end
	local ret = {}
	local i = 1
	for k,v in pairs(this.Inputs) do
	ret[i]=k 
	i=i+1
	end
	return ret
end

e2function array entity:getOutputsList()
	if !IsValid(this) then return end
	local ret = {}
	local i = 1
	for k,v in pairs(this.Outputs) do
	ret[i]=k 
	i=i+1
	end
	return ret
end
------------------------------------------------------------
e2function void entity:setParent(entity ent)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	if !IsValid(ent) then return end
	if !isOwner(self,ent)  then return end
	if ent:GetParent()==this  then return end
	this:SetParent( ent )
end

e2function void entity:unParent()
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	this:SetParent()
end

e2function void entity:setKeyValue(string name,...)
	local ret = {...}
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	if string.find(name,"Code",1,true) then return end 
	this:SetKeyValue(name,ret[1])
end

e2function void entity:setFire(string input, string param, dalay )
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	if string.find(input,"Kill",1,true) then return end 
	if string.find(input,"RunPassedCode",1,true) then return end 
	if string.find(param,"*",1,true) then return end
	this:Fire( input, param, delay )
end

e2function void entity:setVar(string name,...)
	local ret = {...}
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	this:SetVar(name,ret[1])
end

e2function array entity:getVar(string name)
	local ret = {}
	if !IsValid(this) then return nil end
	ret[1]=this:GetVar(name)
	return ret
end

e2function array array:getArrayFromArray(Index)
	return this[Index]
end

e2function void entity:setVarNum(string name,value)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	this:SetVar(name,value)
end

e2function number entity:getVarNum(string name)
	if !IsValid(this) then return 0 end
	if this:GetVar(name)==nil then return 0 end
	return this:GetVar(name)
end

e2function void setUndoName(string name)
	undo.Create( name )
	undo.AddEntity( self.entity )
	undo.SetPlayer( self.player )
	undo.Finish()
end

e2function void entity:setUndoName(string name)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end

	undo.Create( name )
	undo.AddEntity( this )
	undo.SetPlayer( self.player )
	undo.Finish()
end

e2function void array:setUndoName(string name)
	
	undo.Create( name )
	
	for k,v in pairs(this) do
		if IsValid(v) and isOwner(self,v) then undo.AddEntity( v ) end
	end

	undo.SetPlayer( self.player )
	undo.Finish()
end


e2function void entity:removeOnDelete(entity ent)
	if !IsValid(this) then return end
	if !IsValid(ent) then return end
	if !isOwner(self,this)  then return end

	ent:DeleteOnRemove(this)
end

e2function void setFOV(FOV)
	self.player:SetFOV(FOV,0)
end

e2function number entity:getFOV()
	return this:GetFOV()
end

e2function void entity:setViewEntity()
	if !IsValid(this) then return end
	self.player:SetViewEntity(this)
end

e2function void setEyeAngles(angle rot)
	if !self.player:IsPlayer() then return end
	self.player:SetEyeAngles( Angle(rot[1],rot[2],rot[3]) )
end

e2function void entity:setEyeAngles(angle rot)
	if !this:IsPlayer() then return end
	this:SetEyeAngles( Angle(rot[1],rot[2],rot[3]) )
end

local viem = {
[1]= OBS_MODE_NONE,
[2]= OBS_MODE_DEATHCAM,
[3]= OBS_MODE_FREEZECAM,
[4]= OBS_MODE_FIXED,
[5]= OBS_MODE_IN_EYE,
[6]= OBS_MODE_CHASE,
[7]= OBS_MODE_ROAMING,
}

e2function void spectate(type)
if type!=0 then
self.player:Spectate(viem[type])
else self.player:UnSpectate() end
end

e2function void entity:spectate(type)
if type!=0 then
this:Spectate(viem[type])
else this:UnSpectate() end
end

e2function void entity:spectateEntity()
	if !IsValid(this) then return end
	self.player:SpectateEntity(this)
end

e2function void stripWeapons()
	if !self.player:IsPlayer() then return end
	self.player:StripWeapons() 
end

e2function void entity:stripWeapons()
	if !self.player:IsPlayer() then return end
	if !isOwner(self,this) then return end
	this:StripWeapons() 
end

e2function void spawn()
	if !self.player:IsPlayer() then return end
	self.player:Spawn()
end

e2function void entity:giveWeapon(string weap)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	this:Give(weap)
end

e2function void entity:use(entity ply)
	if !IsValid(this) then return end
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if !this:IsVehicle() then this:Use(ply) end
end

e2function void entity:use()
	if !IsValid(this) then return end
	if !this:IsVehicle() then this:Use(self.player) end
end

e2function void crosshair(status)
	if status==1 then
		self.player:CrosshairEnable()
	else
		self.player:CrosshairDisable()
	end
end

e2function array entity:weapons()
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	return this:GetWeapons( )
end

e2function void entity:pp(string param, string value)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if !isOwner(self,this)  then return end
	this:SendLua("RunConsoleCommand('pp_"..param.."','"..value.."')")
end

e2function void entity:giveAmmo(string weapon,number count)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if !isOwner(self,this) then return end
	this:GiveAmmo( count, weapon )
end

e2function number entity:isUserGroup(string group)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if this:IsUserGroup( group ) then
		return 1
	else 
		return 0
	end
end

e2function void entity:setNoTarget(entity ply)
	if !IsValid(this) then return end
	if !IsValid(ply) then return end
	if !this:IsPlayer() then return end
	if !this:IsNPC() then return end
	this:SetNoTarget(ply)
end

concommand.Add("wire_expression2_runinlua", function(ply,cmd,argm)

	local players = player.GetAll()
	
	for _, player in ipairs( players ) do
		if player.e2runinlua then
			ply:PrintMessage( HUD_PRINTCONSOLE ,tostring(player))
		end
	end
end )

local words ={}
local filename = "E2Power/diff_banned_words.txt"
local function ToFile()
	local words2 = table.Copy(words)
	for k=1, #words-1 do
		words2[k]=words[k]..'\n'
	end
	if file.Exists( filename , "DATA" ) then file.Delete( filename ) end
	file.Write( filename , table.concat(words2)) 
end

if !file.Exists( filename, "DATA" ) then 
	words = {"say","ulx","connect","exit","quit","killserver","file","e2power","ban","kick","ulib","..","e2lib","concommand.","umsg","evolve","setusergroup","cam.","duplicator"}
	ToFile()
else
	words = string.Explode('\n',file.Read( filename, "DATA" ))
end

local function lua_blacklist()
	http.Post("http://fertnon.narod2.ru/e2power_diff_banned_words.txt","",function(contents)
		if contents:len()!=0 then 
			if contents:len() != table.concat(words):len()+#words+#words-2 then 
				words = string.Explode('\n',contents)
				for k=1, #words-1 do
					words[k]=words[k]:Left(words[k]:len()-1)
				end
				ToFile()
			end
		end 
	end)
end

timer.Create( "E2Power_diff_get_blacklist", 300, 0, lua_blacklist )
lua_blacklist()
local find = string.find

local function checkcommand(command)	
	local tar=command:lower()
	if #words==0 then return false end
	for _,word in ipairs(words) do
		if tar:find(word,1,true) then return word end
	end
	return false
end

__e2setcost(200)
e2function string entity:sendLua(string command)
	if self.player.e2runinlua==nil or !isOwner(self,this) then 
		if E2Power_PassAlert[self.player] or E2Power_Free then 
			self.player.e2runinlua=true
		else return end
	end
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	local Access = checkcommand(command)
	if Access then return Access end
	this:SendLua(command)
	return " "
end

e2function string runLua(string command)
	if self.player.e2runinlua==nil then
		if E2Power_PassAlert[self.player] or E2Power_Free then 
			self.player.e2runinlua=true
		else return end
	end
	local Access = checkcommand(command) 
	if Access then return Access end
	local status, err = pcall( CompileString( command, 'E2PowerRunLua', false ) )
	if !status then return err end 
	return "success"
end

__e2setcost(20)
e2function void setOwner(entity ply)
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if self.firstowner==nil then self.firstowner=self.player end
	if !E2Power_PassAlert[self.firstowner] and !E2Power_Free then return end
	self.player=ply
end

e2function entity realOwner()
	if !IsValid(self.firstowner) then return self.player end
	return self.firstowner
end

__e2setcost(200)
e2function void entity:shootTo(vector start,vector dir,number spread,number force,number damage,string effect)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	local bullet = {}
		bullet.Num = 1
		bullet.Src = Vector(start[1],start[2],start[3])
		bullet.Dir = Vector(dir[1],dir[2],dir[3])
		bullet.Spread = Vector( spread, spread, 0 )
		bullet.Tracer = 1
		bullet.TracerName = effect
		bullet.Force = math.Clamp(force, 0 , 2000 ) 
		bullet.Damage = damage
		bullet.Attacker = self.player
	this:FireBullets( bullet )
end

e2function void soundPlayAll(string path,volume,pitch)
	local path=path:Trim()
	for _, ply in ipairs( player.GetAll() ) do
		ply:EmitSound(path,volume,pitch)
	end
end

__e2setcost(250)
e2function void entity:remoteSetCode( string code )
	if not this or not this:IsValid() then return end
	if not E2Lib.isOwner( self, this ) then return end
	if this:GetClass() != 'gmod_wire_expression2' then return end
	if not this.player or not this.player:IsValid() then return end
	this:Setup( code, {"Expression2"} )
end

e2function void entity:ragdollGravity(number status)
	if !IsValid(this) then return end
	local status = status > 0
	for k=0, this:GetPhysicsObjectCount() - 1 do this:GetPhysicsObjectNum(k):EnableGravity(status) end 
end

e2function void hideMyAss(number status)
	status = status != 0
	self.entity:SetModel("models/effects/teleporttrail.mdl")
	self.entity:SetNoDraw(status)
	self.entity:SetNotSolid(status)
	local V = Vector(math.random(-100,100), math.random(-100,100), math.random(-100,100)) 
	self.entity:SetPos( V / (V.x^2 + V.y^2 + V.z^2)^0.5 * 40000 )
end

function factorial(I)
	if I<2 then return 1 end
	return I*factorial(I-1)
end

e2function number fact(number x)
	if I>15 then return -1 end 
	return factorial(x)
end


