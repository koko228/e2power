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

e2function void crosshairEnable()
self.player:CrosshairEnable()
end

e2function void crosshairDisable()
self.player:CrosshairDisable()
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