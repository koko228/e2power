__e2setcost(5)
e2function number entity:isPhysics()
	if !validPhysics(this) then return 0 else return 1 end
end

__e2setcost(20)
e2function void entity:setVel(vector vel)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
	if validPhysics(this) then 
	this:GetPhysicsObject():SetVelocity(Vector(vel[1],vel[2],vel[3])) 
	else
	this:SetVelocity(Vector(vel[1],vel[2],vel[3]))
	end
end

e2function void entity:remove()
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
        if (this:IsPlayer()) then return end
	this:Remove()
end


e2function void entity:tele(vector vec)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
	this:SetPos(Vector(vec[1], vec[2], vec[3]))
end

----------------------------------------------------Wire
e2function void entity:setInput(string input,...)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	local ret = {...}
	this:TriggerInput( input , ret[1] )
end

e2function array entity:getOutput(string output)
	if !validEntity(this) then return end
	local ret =  {}
	ret[1]=this.Outputs[output].Value
	return ret 
end

e2function string entity:getOutputType(string output)
	if !validEntity(this) then return end
	return type(this.Outputs[output].Value)
end

e2function string entity:getInputType(string input)
	if !validEntity(this) then return end
	return type(this.Inputs[input].Value)
end

e2function array entity:getInputsList()
	if !validEntity(this) then return end
	local ret = {}
	local i = 1
	for k,v in pairs(this.Inputs) do
	ret[i]=k 
	i=i+1
	end
	return ret
end

e2function array entity:getOutputsList()
	if !validEntity(this) then return end
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
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	if !validEntity(ent) then return end
	if !isOwner(self,ent)  then return end
	if ent:GetParent()==this  then return end
	this:SetParent( ent )
end

e2function void entity:unParent()
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetParent()
end

e2function void entity:setKeyValue(string name,...)
	local ret = {...}
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetKeyValue(name,ret[1])
end

e2function void setUndoName(string name)
	undo.Create( name )
	undo.AddEntity( self.entity )
	undo.SetPlayer( self.player )
	undo.Finish()
end

e2function void entity:setUndoName(string name)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end

	undo.Create( name )
	undo.AddEntity( this )
	undo.SetPlayer( self.player )
	undo.Finish()
end

e2function void array:setUndoName(string name)
	
	undo.Create( name )
	
	for k,v in pairs(this) do
	if validEntity(v) and isOwner(self,v) then undo.AddEntity( v ) end
	end

	undo.SetPlayer( self.player )
	undo.Finish()
end


e2function void entity:deleteOnRemove(entity ent)
	if !validEntity(this) then return end
	if !validEntity(ent) then return end
	if !isOwner(self,ent)  then return end

	this:DeleteOnRemove(ent)
end

e2function void setFOV(FOV)
	self.player:SetFOV(FOV)
end

e2function number entity:getFOV()
	return	this:GetFOV()
end

e2function void entity:setViewEntity()
	if !validEntity(this) then return end
	self.player:SetViewEntity(this)
end

e2function void setEyeAngles(angle rot)
self.player:SetEyeAngles( Angle(rot[1],rot[2],rot[3]) )
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

e2function void entity:spectateEntity()
	if !validEntity(this) then return end
	self.player:SpectateEntity(this)
end

e2function void stripWeapons()
	self.player:StripWeapons() 
end

e2function void spawn()
ULib.spawn(self.player,true)
end

e2function void entity:giveWeapon(string weap)
if !validEntity(this) then return end
if !this:IsPlayer() then return end
this:GetWeapon(weap)
end

e2function void entity:use(entity ply)
	if !validEntity(this) then return end
	if !validEntity(ply) then return end
	if !ply:IsPlayer() then return end
	if !this:IsVehicle() then this:Use(ply) end
end

e2function void entity:use()
	if !validEntity(this) then return end
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
if !validEntity(this) then return end
if !this:IsPlayer() then return end
return this:GetWeapons( )
end

__e2setcost(200)
e2function void entity:shootTo(vector start,vector dir,number spread,number force,number damage,string effect)
	if !validEntity(this) then return end
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