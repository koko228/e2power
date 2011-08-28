--made by [G-moder]FertNoN
---------------------------------------------EFFECK SPAWN
/*
function Spawn_Effect(self, effect, ent, pos, rot, normal, size)
	
	--if ent!=nil then
	--	if !validEntity(ent)  then return end
	--	if !isOwner(self,ent)  then return end
	--end

	local effectdata = EffectData()
	
	if(pos!=nil) then effectdata:SetOrigin( Vector(pos[1],pos[2],pos[3]) ) end
	if(rot!=nil) then effectdata:SetAngle(Angle(rot[1],rot[2],rot[3])) end
	if(normal!=nil) then effectdata:SetNormal( Vector(normal[1],normal[2],normal[3]) ) end
	if(size!=nil) then effectdata:SetScale( size ) end
	if(start!=nil) then effectdata:SetStart(Vector(start[1],start[2],start[3])) end
	if(ent!=nil) then effectdata:SetEntity( ent ) end

	util.Effect( effect , effectdata )
end

--Spawn_Effect(self, effect, ent, pos, normal, rot, size)
*/

e2function void entity:effectSpawn(string effect,vector pos,vector start,angle rot,number size)	
	
	local effectdata = EffectData()
	
	effectdata:SetOrigin(Vector(pos[1],pos[2],pos[3]))
	effectdata:SetStart(Vector(start[1],start[2],start[3]))
	effectdata:SetAngle(Angle(rot[1],rot[2],rot[3]))
	effectdata:SetScale( size )
	effectdata:SetEntity( this )
	
	util.Effect( effect , effectdata )
end

e2function void entity:effectSpawn(string effect,vector pos,vector start,vector normal,number size)	
	
	local effectdata = EffectData()
	
	effectdata:SetOrigin(Vector(pos[1],pos[2],pos[3]))
	effectdata:SetStart(Vector(start[1],start[2],start[3]))
	effectdata:SetNormal( Vector(normal[1],normal[2],normal[3]) )
	effectdata:SetScale( size )
	effectdata:SetEntity( this )
	
	util.Effect( effect , effectdata )
end

e2function void entity:effectSpawn(string effect,vector pos,vector normal,number size)	
	
	local effectdata = EffectData()
	
	effectdata:SetOrigin(Vector(pos[1],pos[2],pos[3]))
	effectdata:SetNormal( Vector(normal[1],normal[2],normal[3]) )
	effectdata:SetScale( size )
	effectdata:SetEntity( this )
	
	util.Effect( effect , effectdata )
end

e2function void effectSpawn(string effect,vector pos,number size)	
	
	local effectdata = EffectData()
	
	effectdata:SetOrigin(Vector(pos[1],pos[2],pos[3]))
	effectdata:SetScale( size )
		
	util.Effect( effect , effectdata )
end

e2function void entity:effectSpawn(string effect,vector pos,number size)	
	
	local effectdata = EffectData()
	
	effectdata:SetOrigin(Vector(pos[1],pos[2],pos[3]))
	effectdata:SetScale( size )
	effectdata:SetEntity( this )
		
	util.Effect( effect , effectdata )
end

e2function void entity:effectSpawn(string effect,vector pos,number size,vector hitbox)	
	
	local effectdata = EffectData()
	
	effectdata:SetOrigin(Vector(pos[1],pos[2],pos[3]))
	effectdata:SetScale( size )
	effectdata:SetEntity( this )
	effectdata:SetHitBox( Vector(hitbox[1],hitbox[2],hitbox[3]) )
		
	util.Effect( effect , effectdata )
end

e2function void entity:effectSpawn(string effect,number size)	
	
	local effectdata = EffectData()

	effectdata:SetEntity( this )
	effectdata:SetScale( size )
		
	util.Effect( effect , effectdata )
end