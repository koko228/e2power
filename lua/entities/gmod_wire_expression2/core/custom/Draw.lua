--Draw mod made by [G-moder]FertNoN
__e2setcost(200)
e2function entity drawSprite(string mat,vector pos,vector color,number alpha,sizex,sizey)
local sprite=ents.Create("e2_sprite")
	sprite:SetModel("models/effects/teleporttrail.mdl")
	sprite:SetMaterial(mat)
	sprite:SetPos(Vector(pos[1],pos[2],pos[3]))
	sprite:SetColor(color[1],color[2],color[3],alpha)
	
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