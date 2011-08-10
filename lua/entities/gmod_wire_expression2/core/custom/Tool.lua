__e2setcost(20)

e2function void entity:unConstrain()
if !validEntity(this) then return end
if !validPhysics(this) then return end
if !isOwner(self,this)  then return end
constraint.RemoveAll(this)
end


e2function number entity:getNoCollide()
if !validEntity(this) then return 0 end
if !validPhysics(this) then return 0 end
if this.Entity.CollisionGroup == COLLISION_GROUP_WORLD then
return 0
	else
return 1
end
end


e2function void entity:setNoCollide(entity ent)

	if !validEntity(this) then return end
	if !validPhysics(this) then return end

	if !validEntity(ent) then return end
	if !validPhysics(ent) then return end

	if !isOwner(self,ent)  then return end
	if !isOwner(self,this)  then return end
//local Ent1,  Ent2  = this:GetEnt(1),  ent:GetEnt(2)
local Bone1, Bone2 = this:GetPhysicsObjectNum(1), this:GetPhysicsObjectNum(1)

constraint.NoCollide(this, ent, Bone1, Bone2)
--table.insert(constraints, constraint)
end

e2function void entity:setNoCollideAnyProp(colide)
if !validEntity(this) then return end
if !validPhysics(this) then return end
if !isOwner(self,this)  then return end
if rv2 ~= 0 then

		this.Entity:SetCollisionGroup( COLLISION_GROUP_WORLD )
		this.Entity.CollisionGroup = COLLISION_GROUP_WORLD
		
	else
		
		this.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )
		this.Entity.CollisionGroup = COLLISION_GROUP_NONE
end
end


e2function void entity:setWeld(entity ent,number force,number nocolide)

	if !validEntity(this) then return end
	if !validPhysics(this) then return end

	if !validEntity(ent) then return end
	if !validPhysics(ent) then return end

	if !isOwner(self,ent)  then return end
	if !isOwner(self,this)  then return end
//local Ent1,  Ent2  = this:GetEnt(1),  ent:GetEnt(2)
local Bone1, Bone2 = this:GetPhysicsObjectNum(1), this:GetPhysicsObjectNum(1)

		local constraint = constraint.Weld( this, ent, Bone1, Bone2, force, nocolide )

//if (constraint) then 


	//		undo.Create("E2 Weld")
		//	undo.AddEntity( constraint )
			//undo.SetPlayer( self )
			//undo.Finish()
		//	self:AddCleanup( "E2 constraints", constraint )
		
	//	end


end
