__e2setcost(5)
e2function number entity:isPhysics()
	if !validPhysics(this) then return 0 else return 1 end
end

e2function string nullS()
	return nil
end

e2function entity nullE()
	return nil
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



e2function void entity:setInputNumber(string input,number num)
	if !validEntity(this) then return end
	if !isOwner(self,ent)  then return end
	if !isOwner(self,this)  then return end
	--this.Inputs[input]=ent.Outputs[output]
	this:TriggerInput( input , num )
end

e2function number entity:getOutputNumber(string output)
	if !validEntity(this) then return end
	if !isOwner(self,ent)  then return end
	if !isOwner(self,this)  then return end
	--this.Inputs[input]=ent.Outputs[output]
	--this:TriggerInput( input , num )
	return this.Outputs[output].Value
end


e2function void entity:setParent(entity ent)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetParent( ent )
end

e2function void entity:setKeyValue(string name,...)
	local ret = {...}
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetKeyValue(name,ret[1])
end

e2function void entity:physWake()
if !validEntity(this) then return end
if !isOwner(self,this)  then return end
local phys = this:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
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