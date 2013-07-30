__e2setcost(20)
e2function void entity:setHealth(number Health)
    if !IsValid(this)  then return end
	if !isOwner(self, this)  then return end
	Health=math.Clamp(Health,0, 1000000000)
	this:SetHealth(Health)
end

e2function void entity:setArmor(number Armor)
	if !IsValid(this)  then return end
	if !isOwner(self, this)  then return end
	if !this:IsPlayer() then return end
	Armor=math.Clamp(Armor, 0, 1000000000)
	this:SetArmor(Armor)
end

e2function void entity:takeDamage(number Amount, entity Attacker, entity Inflictor)
	if !IsValid(this)  then return end
	if !isOwner(self, this)  then return end
	this:TakeDamage(Amount, Attacker, Inflictor)
end

e2function void entity:heal(number Health)
	if !IsValid(this)  then return end
	if !isOwner(self, this)  then return end
	if !this:IsPlayer() then return end
	Health=this:Health()+Health
	Health=math.Clamp(Health,0, 1000000000)
	this:SetHealth(Health)
end

e2function void entity:extinguish()
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	this:Extinguish()
end

e2function void entity:ignite(number l)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	local _length	= math.Max( l , 2 )
	this:Ignite( _length, 0 )
end

e2function void entity:setMaxHealth(number Health)
	if !IsValid(this) then return end
	if !isOwner(self,this)  then return end
	this:SetMaxHealth(Health)
	this:SetHealth(Health)
end

__e2setcost(50)

hook.Add("EntityTakeDamage", "CheckE2PowerDamage", function( ent, dmginfo )
	if !ent.e2pDebag then return end
	
	ent.e2pInflictor = dmginfo:GetInflictor()
	ent.e2pAttacker = dmginfo:GetAttacker()
	ent.e2pDamage = dmginfo:GetDamage()
	ent.e2pCheck = {}
end)

e2function number entity:getDamage()
	if !IsValid(this) then return end
	if !this.e2pDebag then this.e2pDamage=0 this.e2pCheck = {} this.e2pDebag=true return 0 end
	if this.e2pCheck[self.entity]==nil then
		this.e2pCheck[self.entity] = {}
		this.e2pCheck[self.entity].dem = false 
	end 
	if this.e2pCheck[self.entity].dem then return 0 end
	this.e2pCheck[self.entity].dem=true
	return this.e2pDamage
end

e2function entity entity:getAttacker()
	if !IsValid(this) then return end
	if !this.e2pDebag then this.e2pAttacker=nil this.e2pCheck = {} this.e2pDebag=true return nil end
	if this.e2pCheck[self.entity]==nil then
		this.e2pCheck[self.entity] = {}
		this.e2pCheck[self.entity].att = false 
	end
	if this.e2pCheck[self.entity].att then return nil end
	this.e2pCheck[self.entity].att=true
	return this.e2pAttacker
end

e2function entity entity:getInflictor()
	if !IsValid(this) then return end
	if !this.e2pDebag then this.e2pInflictor=nil this.e2pCheck = {} this.e2pDebag=true return nil end
	if this.e2pCheck[self.entity]==nil then
		this.e2pCheck[self.entity] = {}
		this.e2pCheck[self.entity].inf = false 
	end 
	if this.e2pCheck[self.entity].inf then return nil end
	this.e2pCheck[self.entity].inf=true
	return this.e2pInflictor
end