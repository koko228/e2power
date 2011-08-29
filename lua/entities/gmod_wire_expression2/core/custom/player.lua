__e2setcost(20)
e2function void entity:playerFreeze()
	if !validEntity(this)  then return end
	if !isOwner(self, this)  then return end
	if !this:IsPlayer() then return end
        this:Lock()
       this:DisallowSpawning( true )
end

e2function void entity:playerUnFreeze()
 if !validEntity(this)  then return end
	if !isOwner(self, this)  then return end
	if !this:IsPlayer() then return end
       this:UnLock()
       this:DisallowSpawning( false )
end

e2function void entity:playerRemove()
    if (!self.player:IsSuperAdmin()) then return end
    if (!this:IsPlayer()) then return end
    this:Remove()
end

e2function void entity:playerSetAlpha(rv2)
	if !validEntity(this) then return end
	if !isOwner(self, this) then return end
	if !this:IsPlayer() then return end
	local r,g,b = this:GetColor()
	this:SetColor(r, g, b, math.Clamp(rv2, 0, 255))
end

e2function void entity:playerNoclipOff()
	if !validEntity(this) then return end
	if !isOwner(self, this) then return end
	if !this:IsPlayer() then return end
	this:SetMoveType( MOVETYPE_WALK )
end

e2function void entity:playerNoclipOn()
	if !validEntity(this) then return end
	if !isOwner(self, this) then return end
	if !this:IsPlayer() then return end
	this:SetMoveType( MOVETYPE_NOCLIP )
end