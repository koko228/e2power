--Draw mod made by [G-moder]FertNoN

-----------------------SPRITIES

local sbox_E2_maxSpritesPerSecond = CreateConVar( "sbox_E2_maxSpritesPerSecond", "12", FCVAR_ARCHIVE )
local sbox_E2_maxSprites = CreateConVar( "sbox_E2_maxSprites", "12", FCVAR_ARCHIVE )
local SpritesSpawnInSecond=0
local SpritesCount=0

timer.Create( "ResetTempSprites", 1, 0, function()
SpritesSpawnInSecond=0
end)



function E2_spawn_sprite(self,this,mat,pos,color,alpha,sizex,sizey)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end

	if SpritesSpawnInSecond >= sbox_E2_maxSpritesPerSecond:GetInt() then return end
	if SpritesCount >= sbox_E2_maxSprites:GetInt() then return end

	local sprite=ents.Create("e2_sprite")
	sprite:SetModel("models/effects/teleporttrail.mdl")
	sprite:SetMaterial(mat)
	sprite:SetPos(Vector(pos[1],pos[2],pos[3]))
	sprite:SetAngles(Angle(0,0,0))
	sprite:SetColor(color[1],color[2],color[3],alpha)
	sprite:SetParent( this )
	
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
return E2_spawn_sprite(self,this,mat,pos,color,alpha,sizex,sizey)
end


--------------------------------------BEAM
local sbox_E2_maxBeamPerSecond = CreateConVar( "sbox_E2_maxBeamPerSecond", "12", FCVAR_ARCHIVE )
local sbox_E2_maxBeam = CreateConVar( "sbox_E2_maxBeam", "12", FCVAR_ARCHIVE )
local BeamSpawnInSecond=0
local BeamCount=0

timer.Create( "ResetTempBeam", 1, 0, function()
BeamSpawnInSecond=0
end)


function E2_spawn_beam(self,this,mat,pos,endpos,color,alpha,width,textstart,textend)
if !validEntity(this)  then return end
if !isOwner(self,this)  then return end

if BeamSpawnInSecond >= sbox_E2_maxBeamPerSecond:GetInt() then return end
if BeamCount >= sbox_E2_maxBeam:GetInt() then return end

local beam=ents.Create("e2_beam")
	beam:SetModel("models/effects/teleporttrail.mdl")
	beam:SetMaterial(mat)
	beam:SetPos(Vector(pos[1],pos[2],pos[3]))
	beam:SetAngles(Angle(0,0,0))
	beam:SetColor(color[1],color[2],color[3],alpha)
	beam:SetParent( this )
	
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

e2function entity entity:drawBeam(string mat,vector pos,vector endpos,vector color,number alpha,width,textstart,textend)
return E2_spawn_beam(self,this,mat,pos,endpos,color,alpha,width,textstart,textend)
end

e2function void entity:setBeamEndPos(vector endpos)
if !validEntity(this)  then return end
if !isOwner(self,this)  then return end
this:SetNWVector("endpos",Vector( endpos[1],endpos[2],endpos[3] ) )
end