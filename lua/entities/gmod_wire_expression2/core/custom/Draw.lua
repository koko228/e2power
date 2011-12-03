--Draw mod made by [G-moder]FertNoN

-----------------------SPRITIES

local sbox_E2_maxSpritesPerSecond = CreateConVar( "sbox_E2_maxSpritesPerSecond", "12", FCVAR_ARCHIVE )
local sbox_E2_maxSprites = CreateConVar( "sbox_E2_maxSprites", "300", FCVAR_ARCHIVE )
local SpritesSpawnInSecond=0
local SpritesCount=0

timer.Create( "ResetTempSprites", 1, 0, function()
SpritesSpawnInSecond=0
end)



function E2_spawn_sprite(self,this,mat,pos,color,alpha,sizex,sizey)
	
	if SpritesSpawnInSecond >= sbox_E2_maxSpritesPerSecond:GetInt() then return end
	if SpritesCount >= sbox_E2_maxSprites:GetInt() then return end

	local sprite=ents.Create("e2_sprite")
	sprite:SetModel("models/effects/teleporttrail.mdl")
	sprite:SetMaterial(mat)
	sprite:SetPos(Vector(pos[1],pos[2],pos[3]))
	sprite:SetAngles(Angle(0,0,0))
	sprite:SetColor(color[1],color[2],color[3],alpha)
	sprite:SetOwner(self.player)
	if validEntity(this) and isOwner(self,this) then
		sprite:SetParent( this )
	end
	
	sprite:SetNWFloat("x",sizex)
	sprite:SetNWFloat("y",sizey)

	sprite:Spawn()
	sprite:Activate()
	
	sprite:CallOnRemove("minus_sprite",function()
		SpritesCount=SpritesCount-1
	end)
	
	SpritesSpawnInSecond=SpritesSpawnInSecond+1
	SpritesCount=SpritesCount+1

	undo.Create("E2_sprite")
		undo.AddEntity(sprite)
		undo.SetPlayer(self.player)
	undo.Finish()

return sprite
end


__e2setcost(200)
e2function entity entity:drawSprite(string mat,vector pos,vector color,number alpha,sizex,sizey)
if !validEntity(this) then return nil end  
if !isOwner(self,this) then return nil end  
return E2_spawn_sprite(self,this,mat,pos,color,alpha,sizex,sizey)
end

e2function entity drawSprite(string mat,vector pos,vector color,number alpha,sizex,sizey)
return E2_spawn_sprite(self,this,mat,pos,color,alpha,sizex,sizey)
end

__e2setcost(20)
e2function void entity:spriteSize(sizex,sizey)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
	
	this:SetNWFloat("x",sizex)
	this:SetNWFloat("y",sizey)
end
--------------------------------------BEAM
local sbox_E2_maxBeamPerSecond = CreateConVar( "sbox_E2_maxBeamPerSecond", "12", FCVAR_ARCHIVE )
local sbox_E2_maxBeam = CreateConVar( "sbox_E2_maxBeam", "300", FCVAR_ARCHIVE )
local BeamSpawnInSecond=0
local BeamCount=0

timer.Create( "ResetTempBeam", 1, 0, function()
BeamSpawnInSecond=0
end)


function E2_spawn_beam(self,this,mat,pos,endpos,color,alpha,width,textstart,textend)

if BeamSpawnInSecond >= sbox_E2_maxBeamPerSecond:GetInt() then return end
if BeamCount >= sbox_E2_maxBeam:GetInt() then return end

local beam=ents.Create("e2_beam")
	beam:SetModel("models/props_phx/huge/evildisc_corp.mdl")
	beam:SetMaterial(mat)
	beam:SetPos(Vector(pos[1],pos[2],pos[3]))
	beam:SetAngles(Angle(0,0,0))
	beam:SetColor(color[1],color[2],color[3],alpha)
	beam:SetOwner(self.player)
	if validEntity(this) and isOwner(self,this) then
		beam:SetParent( this )
	end
	beam.mc = true
	beam.endpos = Vector( endpos[1],endpos[2],endpos[3] )
	beam:SetNWVector("endpos",Vector( endpos[1],endpos[2],endpos[3] ) )
	beam:SetNWFloat("width",width)
	beam:SetNWFloat("TextStart",textstart)
	beam:SetNWFloat("TextEnd",textend)

	beam:Spawn()
	beam:Activate()
	
	beam:CallOnRemove("minus_sprite",function()
		BeamCount=BeamCount-1
	end)
	
	BeamSpawnInSecond=BeamSpawnInSecond+1
	BeamCount=BeamCount+1

undo.Create("E2_beam")
    undo.AddEntity(beam)
    undo.SetPlayer(self.player)
undo.Finish()

return beam
end

__e2setcost(200)
e2function entity entity:drawBeam(string mat,vector pos,vector endpos,vector color,number alpha,width,textstart,textend)
if !validEntity(this) then return nil end  
if !isOwner(self,this) then return nil end  
return E2_spawn_beam(self,this,mat,pos,endpos,color,alpha,width,textstart,textend)
end

e2function entity drawBeam(string mat,vector pos,vector endpos,vector color,number alpha,width,textstart,textend)
return E2_spawn_beam(self,this,mat,pos,endpos,color,alpha,width,textstart,textend)
end

e2function void entity:setBeamEndPos(vector endpos)
if !validEntity(this)  then return end
if !isOwner(self,this)  then return end
this:SetNWVector("endpos",Vector( endpos[1],endpos[2],endpos[3] ) )
this.mc = true
this.endpos=Vector( endpos[1],endpos[2],endpos[3] )
end

e2function void entity:setBeamWidth(number width)
if !validEntity(this)  then return end
if !isOwner(self,this)  then return end
this:SetNWFloat("width",width)
end

e2function void entity:setBeamText(number textstart,number textend)
if !validEntity(this)  then return end
if !isOwner(self,this)  then return end
this:SetNWFloat("TextStart",textstart)
this:SetNWFloat("TextEnd",textend)
end

-----------------------Quad

local sbox_E2_maxQuadsPerSecond = CreateConVar( "sbox_E2_maxQuadsPerSecond", "12", FCVAR_ARCHIVE )
local sbox_E2_maxQuads = CreateConVar( "sbox_E2_maxQuads", "300", FCVAR_ARCHIVE )
local QuadsSpawnInSecond=0
local QuadsCount=0

timer.Create( "ResetTempQuads", 1, 0, function()
QuadsSpawnInSecond=0
end)

function E2_spawn_quad(self,this,mat,pos,ang,color,alpha,sizex,sizey)
	
	if QuadsSpawnInSecond >= sbox_E2_maxQuadsPerSecond:GetInt() then return end
	if QuadsCount >= sbox_E2_maxQuads:GetInt() then return end

	local quad=ents.Create("e2_quad")
	quad:SetModel("models/hunter/plates/plate32x32.mdl")
	quad:SetMaterial(mat)
	quad:SetPos(Vector(pos[1],pos[2],pos[3]))
	quad:SetAngles(Angle(ang[1],ang[2],ang[3]))
	quad:SetColor(color[1],color[2],color[3],alpha)
	quad:SetOwner(self.player)
	if validEntity(this) and isOwner(self,this) then
		quad:SetParent( this )
	end
	quad:SetNWFloat("x",sizex)
	quad:SetNWFloat("y",sizey)

	quad:Spawn()
	quad:Activate()
	
	quad:CallOnRemove("minus_quad",function()
		QuadsCount=QuadsCount-1
	end)
	
	QuadsSpawnInSecond=QuadsSpawnInSecond+1
	QuadsCount=QuadsCount+1

	undo.Create("E2_quad")
		undo.AddEntity(quad)
		undo.SetPlayer(self.player)
	undo.Finish()

return quad
end


__e2setcost(200)
e2function entity entity:drawQuad(string mat,vector pos,angle ang,vector color,number alpha,sizex,sizey)
if !validEntity(this) then return nil end  
if !isOwner(self,this) then return nil end  
return E2_spawn_quad(self,this,mat,pos,ang,color,alpha,sizex,sizey)
end

e2function entity drawQuad(string mat,vector pos,angle ang,vector color,number alpha,sizex,sizey)
return E2_spawn_quad(self,this,mat,pos,ang,color,alpha,sizex,sizey)
end

__e2setcost(20)
e2function void entity:quadSize(sizex,sizey)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
	
	this:SetNWFloat("x",sizex)
	this:SetNWFloat("y",sizey)
end

-------------------------------PROP_DYN
--Props_dynamic
--prop_dynamic
local sbox_E2_maxProps_dynamicPerSecond = CreateConVar( "sbox_E2_maxProps_dynamicPerSecond", "12", FCVAR_ARCHIVE )
local sbox_E2_maxProps_dynamic = CreateConVar( "sbox_E2_maxProps_dynamic", "300", FCVAR_ARCHIVE )
local Props_dynamicSpawnInSecond=0
local Props_dynamicCount=0

timer.Create( "ResetTempProps_dynamic", 1, 0, function()
Props_dynamicSpawnInSecond=0
end)

function E2_spawn_prop_dynamic(self,this,pos,size,radius)
	
	if Props_dynamicSpawnInSecond >= sbox_E2_maxProps_dynamicPerSecond:GetInt() then return end
	if Props_dynamicCount >= sbox_E2_maxProps_dynamic:GetInt() then return end

	local prop_dynamic=ents.Create("e2_prop_dynamic")
	prop_dynamic:SetModel("models/effects/teleporttrail.mdl")
	prop_dynamic:SetPos(Vector(pos[1],pos[2],pos[3]))
	--prop_dynamic:SetAngles(Angle(0,0,0))
	prop_dynamic:SetColor(255,255,255,0)
	prop_dynamic:SetOwner(self.player)
	if validEntity(this) and isOwner(self,this) then
		prop_dynamic:SetParent( this )
	end
	prop_dynamic.sphere=radius
	if size!=nil then prop_dynamic.size=Vector(size[1],size[2],size[3]) end
	
	prop_dynamic:Spawn()
	prop_dynamic:Activate()
	
	prop_dynamic:CallOnRemove("minus_prop_dynamic",function()
		Props_dynamicCount=Props_dynamicCount-1
	end)
	
	Props_dynamicSpawnInSecond=Props_dynamicSpawnInSecond+1
	Props_dynamicCount=Props_dynamicCount+1

	undo.Create("E2_prop_dynamic")
		undo.AddEntity(prop_dynamic)
		undo.SetPlayer(self.player)
	undo.Finish()

return prop_dynamic
end


__e2setcost(200)
e2function entity entity:propDynamicSpawn(vector pos,vector size)
if !validEntity(this) then return nil end  
if !isOwner(self,this) then return nil end  
return E2_spawn_prop_dynamic(self,this,pos,size,radius)
end

e2function entity propDynamicSpawn(vector pos,vector size)
return E2_spawn_prop_dynamic(self,this,pos,size,radius)
end

e2function entity entity:propDynamicSpawn(vector pos,radius)
if !validEntity(this) then return nil end  
if !isOwner(self,this) then return nil end  
return E2_spawn_prop_dynamic(self,this,pos,size,radius)
end

e2function entity propDynamicSpawn(vector pos,radius)
return E2_spawn_prop_dynamic(self,this,pos,size,radius)
end

e2function void ranger:drawPaint(string mat)
	util.Decal(mat,this.HitPos + this.HitNormal ,this.HitPos - this.HitNormal)
end