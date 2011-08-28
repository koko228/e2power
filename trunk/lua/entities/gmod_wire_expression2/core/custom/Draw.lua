--Draw mod made by [G-moder]FertNoN
__e2setcost(200)
e2function entity entity:drawSprite(string mat,vector pos,vector color,number alpha,sizex,sizey)

if !validEntity(this)  then return end
if !isOwner(self,this)  then return end

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

undo.Create("E2_sprite")
    undo.AddEntity(sprite)
    undo.SetPlayer(self.player)
undo.Finish()

return sprite
end

e2function entity entity:drawBeam(string mat,vector pos,vector endpos,vector color,number alpha,width,textstart,textend)

if !validEntity(this)  then return end
if !isOwner(self,this)  then return end

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

undo.Create("E2_beam")
    undo.AddEntity(beam)
    undo.SetPlayer(self.player)
undo.Finish()

return beam
end

e2function void entity:setBeamEndPos(vector endpos)
	this:SetNWVector("endpos",Vector( endpos[1],endpos[2],endpos[3] ) )
end