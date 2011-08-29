__e2setcost(20)

CreateConVar("sbox_e2_constraints","1")

local function Weldit(self, ent1, ent2, nc, fl)
    if validEntity(ent1) and validEntity(ent2) and type(ent1)!="Player" and type(ent2)!="Player" then
        if ent1==ent2 then return end
        if isOwner(self, ent1) and isOwner(self, ent2) then
            local welded = constraint.Weld(ent1, ent2, 0, 0, fl, tobool(nc))
                undo.Create("Weld")
                undo.AddEntity(welded)
                undo.SetPlayer( self.player )
                undo.Finish()
                self.player:AddCleanup( "constraints", welded )
        else return end
    else return end
end

e2function void entity:weldTo(entity ent,number nocollide)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    Weldit(self, this, ent, nocollide, forcelimit)
end

e2function void entity:weldTo(entity ent,number forcelimit,number nocollide)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    Weldit(self, this, ent, nocollide, forcelimit)
end

local function AxisIt(self, ent1, ent2, lpos1, lpos2, fl, tl, fric, nc, laxis)
    if validEntity(ent1) and validEntity(ent2) and type(ent1)!="Player" and type(ent2)!="Player" then
        if isOwner(self, ent1) and isOwner(self, ent2) then
            local axis = constraint.Axis(ent1, ent2, 0, 0, lpos1, lpos2, fl, tl, fric, nc, laxis)
                undo.Create("Axis")
                undo.AddEntity(axis)
                undo.SetPlayer( self.player )
                undo.Finish()
                self.player:AddCleanup( "constraints", axis )
        else return end
    else return end
end

e2function void entity:axisTo(entity ent2,vector localposition1,vector localposition2,number forcelimit,number torquelimit,number friction,number nocollide,vector localaxis)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    if this==ent2 then return end
    local lpos1 = Vector(localposition1[1],localposition1[2],localposition1[3])
    local lpos2 = Vector(localposition2[1],localposition2[2],localposition2[3])
    if lpos2 == Vector(0,0,0) then
        lpos2 = lpos1
    end
    local laxis = Vector(localaxis[1],localaxis[2],localaxis[3])
    AxisIt(self, this, ent2, lpos1, lpos2, forcelimit, torquelimit, friction, nocollide, laxis)
end

e2function void entity:ropeTo(entity ent2,vector localposition1,vector localposition2,number addlength,number forcelimit,number width,string material,number rigid)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    local lpos1 = Vector(localposition1[1],localposition1[2],localposition1[3])
    local lpos2 = Vector(localposition2[1],localposition2[2],localposition2[3])
    local wpos1 = this:LocalToWorld(lpos1)
    local wpos2 = ent2:LocalToWorld(lpos2)
    if material==""    then material = "cable/cable2" end
    
    if validEntity(this) and validEntity(ent2) and type(this)!="Player" and type(ent2)!="Player" then
        if isOwner(self, this) and isOwner(self, ent2) then
            local length = (wpos1-wpos2):Length()
            local rope = constraint.Rope( this, ent2, 0, 0, lpos1, lpos2, length, addlength, forcelimit, width, material, tobool(rigid) )
                undo.Create("rope")
                undo.AddEntity(rope)
                undo.SetPlayer( self.player )
                undo.Finish()
                self.player:AddCleanup( "constraints", rope )
        else return end
    else return end
end

e2function void entity:setPhysProp(string material,number gravity)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    if this:IsPlayer() or !validEntity(this) or !this:IsValid() or !isOwner(self,this) then return end
    construct.SetPhysProp( self.player, this, 0, nil,  { GravityToggle = tobool(gravity), Material = material } )
    --DoPropSpawnedEffect( this )
end

local function BallsocketIt(self, ent1, ent2, LPos, forcelimit, torquelimit, nocollide )
    if validEntity(ent1) and validEntity(ent2) and type(ent1)!="Player" and type(ent2)!="Player" then
        if isOwner(self, ent1) and isOwner(self, ent2) and ent1!=ent2 then
            local Ballsocket = constraint.Ballsocket(ent1,ent2,0,0,LPos,forcelimit,torquelimit,nocollide)
                undo.Create("ballsocket")
                undo.AddEntity(Ballsocket)
                undo.SetPlayer( self.player )
                undo.Finish()
                self.player:AddCleanup( "constraints", Ballsocket )
        else return end
    else return end
end

e2function void entity:ballsocketTo(entity ent,vector localposition,number forcelimit,number torquelimit,number nocollide)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    local lpos = Vector(localposition[1],localposition[2],localposition[3])
    BallsocketIt(self, this, ent, lpos, forcelimit, torquelimit, nocollide)
end

e2function void entity:ballsocketTo(entity ent,number nocollide)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    local lpos = Vector(0,0,0)
    BallsocketIt(self, this, ent, lpos, forcelimit, torquelimit, nocollide)
end

e2function void entity:removeAllConstraints()
    if isOwner(self,this) and validEntity(this) then
        constraint.RemoveAll(this)
    else return end
end

e2function void entity:removeConstraint(string constraintname)
    if isOwner(self,this) and validEntity(this) then
        constraint.RemoveConstraints( this, constraintname )
    else return end
end

e2function void entity:noCollideAll(number)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    if isOwner(self,this) and validEntity(this) then
        if number!=1 then
            this:SetCollisionGroup( COLLISION_GROUP_NONE )    
        else
            this:SetCollisionGroup( COLLISION_GROUP_WORLD )        
        end
    else return end
end

e2function void entity:noCollide(entity ent)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    if isOwner(self,this) and this!=ent then
        local NoCollide = constraint.NoCollide(this, ent, 0, 0)
        undo.Create("NoCollide")
        undo.AddEntity( NoCollide )
        undo.SetPlayer( ply )
        undo.Finish()
        ply:AddCleanup( "nocollide", NoCollide )
    else return end
end

e2function void entity:sliderTo(entity ent, vector localpos1, vector localpos2, number width)
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    if isOwner(self,this) and this!=ent then
        local LPos1 = Vector(localpos1[1],localpos1[2],localpos1[3])
        local LPos2 = Vector(localpos2[1],localpos2[2],localpos2[3])
        local Num = math.Clamp(width,0,25)
        local constraint,rope = constraint.Slider( this, ent, 0, 0, LPos1, LPos2, Num )

        undo.Create("Slider")
        undo.AddEntity( constraint )
        if rope then undo.AddEntity( rope ) end
        undo.SetPlayer( ply )
        undo.Finish()
        ply:AddCleanup( "ropeconstraints", constraint )
        ply:AddCleanup( "ropeconstraints", rope )
    else return end
end

e2function void entity:elasticTo(entity ent, vector localpos1, vector localpos2, number constant, number damping, number rdamping, string material, number width, number stretchonly )
    local ply = self.player
    if GetConVar("sbox_e2_constraints"):GetInt() == 1 then
        if not ply:IsAdmin() then return end
    end
    if isOwner(self,this) and this!=ent then
        local LPos1 = Vector(localpos1[1],localpos1[2],localpos1[3])
        local LPos2 = Vector(localpos2[1],localpos2[2],localpos2[3])
        local Num = math.Clamp(width,0,25)
            if not material then
                local Mat = "cable/cable2"
            else
                local Mat = material
            end
        local constraint = constraint.Elastic( this, ent, 0, 0, LPos1, LPos2, constant, damping, rdamping, Mat, width, stretchonly )

        undo.Create("Elastic")
        undo.AddEntity( constraint )
        if rope then undo.AddEntity( rope ) end
        undo.SetPlayer( ply )
        undo.Finish()
        
        ply:AddCleanup( "ropeconstraints", constraint )
        if rope then ply:AddCleanup( "ropeconstraints", rope ) end
    else return end
end

e2function void entity:unConstrain()
	if !validEntity(this) then return end
	if !validPhysics(this) then return end
	if !isOwner(self,this)  then return end
	constraint.RemoveAll(this)
end
