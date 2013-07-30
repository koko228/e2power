-- made by [G-moder]FertNoN

local keys = {
["w"]= IN_FORWARD,
["a"]= IN_MOVELEFT,
["s"]= IN_BACK,
["d"]= IN_MOVERIGHT,
["mouse1"]= IN_ATTACK,
["mouse2"]= IN_ATTACK2,
["reload"]= IN_RELOAD,
["jump"]= IN_JUMP,
["speed"] = IN_SPEED,
["run"] = IN_SPEED,
["zoom"]= IN_ZOOM,
["walk"]= IN_WALK,
["turnleftkey"]= IN_LEFT,
["turnrightkey"]= IN_RIGHT,
["duck"]= IN_DUCK,
["use"]= IN_USE,
["cancel"]= IN_CANCEL,
}

local KeyAct={}
local MKeyAct={}

local function keyMemory(ply)
	ply.e2Keys = {}
	ply.e2mKeys = {}
	ply.e2KeyAsk = {}
	ply.e2mKeyAsk = {}
end

hook.Add("PlayerInitialSpawn", "E2KeyPress", function(ply)		
	keyMemory(ply)
end)
	
for _, ply in ipairs( player.GetAll() ) do
	keyMemory(ply)
end

concommand.Add("wire_e2kp",function(ply, cmd, argm)
	local key = tonumber(argm[1])
	if tonumber(argm[2])==1 then
		ply.e2Keys[key] = 1
		ply.e2LastKeyPress=key
		ply.e2KeyAsk[key] = {}
		ply.e2KeyAsk[0] = nil
		for k,v in pairs(KeyAct) do
			if !k:IsValid() then KeyAct[k]=nil continue end
			k:Execute()
		end
	else
		ply.e2Keys[key] = nil
	end
end)

__e2setcost(20)
e2function number clKeyPress(number key)
	return self.player.e2Keys[key] or 0
end

e2function number clKeyPressVel(number key)
	if self.player.e2Keys[key] then
		if self.player.e2KeyAsk[key][self.entity]!=nil then return 0 end
		self.player.e2KeyAsk[key][self.entity]=true
		return 1
	else
		return 0
	end
end

e2function number clLastKeyPress()
	return self.player.e2LastKeyPress or 0
end

e2function number clLastKeyPressVel()
	if self.player.e2LastKeyPress then 
		if self.player.e2KeyAsk[0]!=nil then return 0 end
		self.player.e2KeyAsk[0]=true
		return self.player.e2LastKeyPress
	else 
		return 0 
	end
end

e2function void runOnKey(number active)
	if tobool(active) == KeyAct[self.entity] then return end
	umsg.Start("e2keyHook", self.player)
	umsg.Entity(self.entity)
	if active!=0 then
		KeyAct[self.entity]=true
		umsg.Bool(true)		
	else
		KeyAct[self.entity]=nil
		umsg.Bool(false)
	end
	umsg.End()
end

e2function void runKey(number active)
	local act = tobool(active)
	umsg.Start("e2keyHook", self.player)
	umsg.Entity(self.entity)
	umsg.Bool(act)		
	umsg.End()
end

__e2setcost(2000)
e2function void clKeyClearBuffer()
	keyMemory(self.player)
	self.player.e2LastKeyPress = nil
end

--------------------MOUSE
concommand.Add("wire_e2mkp",function(ply, cmd, argm)
	if tonumber(argm[2])==1 then
		ply.e2mKeys[argm[1]] = 1
		ply.e2LastmKeyPress=argm[1]
		ply.e2mKeyAsk[argm[1]] = {}
		ply.e2mKeyAsk["last"] = nil
		for k,v in pairs(MKeyAct) do
			if k:IsValid() then 
				k:Execute()
			end
		end
	else
		ply.e2mKeys[argm[1]] = nil
	end
end)

__e2setcost(20)
e2function number clMouseKeyPress(string key)
	return self.player.e2mKeys[key] or 0
end

e2function number clMouseKeyPressVel(string key)
	if self.player.e2mKeys[key] then
		if self.player.e2mKeyAsk[key][self.entity]!=nil then return 0 end
		self.player.e2mKeyAsk[key][self.entity]=true
		return 1
	else
		return 0
	end
end

e2function string clLastMouseKeyPress()
	return self.player.e2mLastKeyPress or "null"
end

e2function string clLastMouseKeyPressVel()
	if self.player.e2mLastKeyPress then 
		if self.player.e2mKeyAsk["last"]!=nil then return "null" end
		self.player.e2mKeyAsk["last"]=true
		return self.player.e2mLastKeyPress
	else 
		return "null"
	end
end

e2function void runOnMouseKey(number active)
	if tobool(active) == MKeyAct[self.entity] then return end
	umsg.Start("e2mkeyHook", self.player)
	umsg.Entity(self.entity)
	if active!=0 then
		MKeyAct[self.entity]=true
		umsg.Bool(true)		
	else
		MKeyAct[self.entity]=nil
		umsg.Bool(false)
	end
	umsg.End()
end

e2function void runMouseKey(number active)
	local act = tobool(active)
	umsg.Start("e2mkeyHook", self.player)
	umsg.Entity(self.entity)
	umsg.Bool(act)		
	umsg.End()
end

__e2setcost(2000)
e2function void clMouseKeyClearBuffer()
	keyMemory(self.player)
	self.player.e2mLastKeyPress = nil
end

__e2setcost(20)
e2function number keyPress(string key)
	if self.player:KeyDown(keys[key:lower()]) then return 1 else return 0 end
end

__e2setcost(50)
e2function number entity:inUse()
	if !IsValid(this) then return 0 end
	if this.e2UseKeyAsk==nil then this.e2UseKeyAsk={} end
	if this.e2UseKeyAsk[self.entity]==nil then this.e2UseKeyAsk[self.entity]={} end
	if this.e2UseKeyAsk[self.entity].use==nil then this.e2UseKeyAsk[self.entity].use=true else return 0 end
	if this.user==nil then return 0 end
	return 1
end

e2function entity entity:inUseBy()
    if !IsValid(this) then return nil end
	if this.e2UseKeyAsk==nil then this.e2UseKeyAsk={} end
	if this.e2UseKeyAsk[self.entity]==nil then this.e2UseKeyAsk[self.entity]={} end
	if this.e2UseKeyAsk[self.entity].useBy==nil then this.e2UseKeyAsk[self.entity].useBy=true else return nil end
	return this.user
end

e2function void runOnUse(number active)
    if active!=0 then
		self.entity.Use = function(ent,ply)
			if ply.CantUseE2 != nil then return end
			local plyID = tostring(ply:EntIndex())
			hook.Add( "Think", "e2RunUse"..plyID , function() 
				if ply:IsValid() then 
					if !ply:KeyDown(IN_USE) then ply.CantUseE2=nil hook.Remove("Think","e2RunUse"..plyID) return else return end
				end
				hook.Remove("Think","e2RunUse"..plyID)
			end,nil,ply,plyID) 
			ply.CantUseE2=true
			self.entity.user=ply
			self.entity:Execute()
		end
	else
		self.entity.Use = nil
	end
end

e2function void runOnUse(number active, entity ent)
	if !ent:IsValid() then return end
	if active!=0 then
		if ent.E2Execute == nil then ent.E2Execute = {} end
		ent.E2Execute[self.entity]=true 
	else
		ent.E2Execute[self.entity]=nil
	end
end 

function e2_use()
	for k,v in pairs ( player.GetAll() ) do
		if v:KeyDown(IN_USE) then 
			local rv1=v:GetEyeTraceNoCursor().HitPos
			local rv2=v:GetShootPos()
			local rvd1, rvd2, rvd3 = rv1[1] - rv2[1], rv1[2] - rv2[2], rv1[3] - rv2[3]
	        local dis=(rvd1 * rvd1 + rvd2 * rvd2 + rvd3 * rvd3) ^ 0.5
			if dis<40 then
				local ent = v:GetEyeTraceNoCursor().Entity
	            if ent:IsValid() then 
					ent.user=v
					ent.e2UseKeyAsk={} 
					if ent.E2Execute != nil then 
						if v.doexecte==nil then
							v.doexecte=true
							local ply = v
							local plyID = tostring(ply:EntIndex())
							hook.Add( "Think", "e2EntRunUse"..plyID , function() 
								if ply:IsValid() then 
									if !ply:KeyDown(IN_USE) then ply.doexecte=nil hook.Remove("Think","e2EntRunUse"..plyID) return else return end
								end 
								hook.Remove("Think","e2EntRunUse"..plyID)
							end,nil,ply,plyID) 
							for k,v in pairs(ent.E2Execute) do
								if k:IsValid() then 
									k:Execute()
								else
									ent.E2Execute[k]=nil
								end
							end
						end
					end
				end
			end
		end
	end
end 

hook.Add( "Think", "e2_use" ,e2_use) 