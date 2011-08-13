--Light mod made by [G-moder]FertNoN
--http://www.gmodlive.com/forum/44-338-1

local Clamp = math.Clamp



------------------------------------------Dynamic LIGHT
__e2setcost(200)

e2function entity entity:setdLight(vector pos,vector color,number brightness,number size,number delay)

if !validEntity(this)  then return end
if !isOwner(self,this)  then return end

local dynlight = ents.Create( "light_dynamic" )
		
	dynlight:SetPos( Vector(pos[1],pos[2],pos[3]) )
	dynlight:SetKeyValue( "_light", Clamp(color[1], 0, 255) .. " " .. Clamp(color[2], 0, 255) .. " " .. Clamp(color[3], 0, 255) .. " " .. 255 )
	dynlight:SetKeyValue( "style", delay )
	dynlight:SetKeyValue( "distance", Clamp(size, 0, 5000) )
	dynlight:SetKeyValue( "brightness", Clamp(brightness, 0, 15) )
	dynlight:SetParent( this )
	--dynlight:setOwner( self.player )

	if validEntity(this.e2_dlight) then this.e2_dlight:Remove() end
        this.e2_dlight=dynlight
        
	dynlight:Spawn()
        return dynlight

end

__e2setcost(20)
e2function void entity:dLightPos(vector pos)
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:SetPos( Vector(pos[1],pos[2],pos[3]) )
end

e2function void entity:dLightColor(vector color)
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:SetKeyValue( "_light", Clamp(color[1], 0, 255) .. " " .. Clamp(color[2], 0, 255) .. " " .. Clamp(color[3], 0, 255) .. " " .. 255 )
end

e2function void entity:dLightBrightness(number brightness)
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:SetKeyValue( "brightness", Clamp(brightness, 0, 15) )
end

e2function void entity:dLightSize(number size)
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:SetKeyValue( "distance", Clamp(size, 0, 5000) )
end

e2function void entity:dLightDelay(number delay)
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:SetKeyValue( "style", delay )
end

e2function void entity:dLightReParent(entity parent)
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:SetParent( parent )
parent.e2_dlight=this.e2_dlight
this.e2_dlight=nil
end

e2function void entity:dLightRemove()
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
if !isOwner(self,this)  then return end
this.e2_dlight:Remove()
this.e2_dlight=nil
end

e2function entity entity:dLightEntity()
if !validEntity(this)  then return end
if !validEntity(this.e2_dlight)  then return end
return this.e2_dlight
end

------------------------------------------Flash LIGHT

__e2setcost(200)
e2function entity entity:setfLight(vector pos,vector color,angle ang,string material,number fov,number farz,number nearz)
	local flashlight = ents.Create( "env_projectedtexture" )
	flashlight:SetParent( this )	
	flashlight:SetPos( Vector( pos[1], pos[2], pos[3] ) )
	flashlight:SetAngles( Angle( ang[1] , ang[2] , ang[3] ) )
	flashlight:SetKeyValue( "enableshadows", 1 )
	flashlight:SetKeyValue( "farz", farz )
	flashlight:SetKeyValue( "nearz", nearz )
	flashlight:SetKeyValue( "lightfov", fov )
	flashlight:SetKeyValue( "lightcolor", Clamp(color[1], 0, 255) .. " " .. Clamp(color[2], 0, 255) .. " " .. Clamp(color[3], 0, 255) )	
	--flashlight:setPlayer( self.player )	

	if validEntity(this.e2_flight) then this.e2_flight:Remove() end
        this.e2_flight=flashlight

	flashlight:Spawn()
	flashlight:Input( "SpotlightTexture", NULL, NULL, material )
	
	return flashlight
end

__e2setcost(20)
e2function void entity:fLightPos(vector pos)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetPos( Vector(pos[1],pos[2],pos[3]) )
end

e2function void entity:fLightAng(angle ang)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetAngles( Angle( ang[1] , ang[2] , ang[3] ) )
end

e2function void entity:fLightColor(vector color)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetKeyValue( "lightcolor", Clamp(color[1], 0, 255) .. " " .. Clamp(color[2], 0, 255) .. " " .. Clamp(color[3], 0, 255) )
end

e2function void entity:fLightMaterial(string material)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:Input( "SpotlightTexture", NULL, NULL, material )
end

e2function void entity:fLightFOV(number fov)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetKeyValue( "lightfov", fov )
end

e2function void entity:fLightFarz(number farz)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetKeyValue( "farz", farz )
end

e2function void entity:fLightNearz(number nearz)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetKeyValue( "nearz", nearz )
end

e2function void entity:fLightReParent(entity parent)
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:SetParent( parent )
parent.e2_flight=this.e2_flight
this.e2_flight=nil
end

e2function void entity:fLightRemove()
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
if !isOwner(self,this)  then return end
this.e2_flight:Remove()
this.e2_flight=nil
end

e2function entity entity:fLightEntity()
if !validEntity(this)  then return end
if !validEntity(this.e2_flight)  then return end
return this.e2_flight
end

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

/*
------------------------------------SPRITE DRAW
e2function void drawSprite(vector Pos,number Size)
umsg.Start("DrawSprite", self.player )
     --umsg.Short( e2 )
     --umsg.String( k )
     --umsg.String( s )
    umsg.End()
end

e2function void drawSprite2(vector Pos)
if !validEntity(this)  then return end
DrawSprite2(Vector(Pos[1],Pos[2],Pos[3]))
end
*/
