-- KeyPress client side 
-- made by [G-moder]FertNoN

E2KeyEvents = {}
E2KeyEntity = {}
function e2searchforkey() 
	for i = 1,130 do
		if(input.IsKeyDown(i)) then
			if(!E2KeyEvents[i]) then
				RunConsoleCommand("wire_e2kp",tostring(i),"1")
				E2KeyEvents[i]=true
				continue
			end
		end
		if(E2KeyEvents[i]) then 
			if(!input.IsKeyDown(i)) then 
				RunConsoleCommand("wire_e2kp",tostring(i),"0")
				E2KeyEvents[i]=nil
				continue
			end
		end
	end
end

function e2keyHook(msg) 
	local ent = msg:ReadEntity()
	local status = msg:ReadBool()
	if !ent:IsValid() then return end
	if status then E2KeyEntity[ent]=true else E2KeyEntity[ent]=nil return end
	if table.Count(E2KeyEntity)==1 then
		hook.Add( "Think", "E2_KeyPress", e2searchforkey)
		timer.Create("e2ClKeyPress",1,0,function() 
			for k,v in pairs(E2KeyEntity) do
				if !k:IsValid() then E2KeyEntity[k]=nil end
			end
			if table.Count(E2KeyEntity)==0 then hook.Remove( "Think", "E2_KeyPress") timer.Destroy("e2ClKeyPress") end
		end)
	end 
end

usermessage.Hook("e2keyHook",e2keyHook)
------------------------------------------------------------------------------------

local mousekeys = {
["4"]= MOUSE_4,
["5"]= MOUSE_5,
["count"]= MOUSE_COUNT,
["first"]= MOUSE_FIRST,
["last"]= MOUSE_LAST,
["left"]= MOUSE_LEFT,
["middle"]= MOUSE_MIDDLE,
["right"]= MOUSE_RIGHT,
["wheel_down"]= MOUSE_WHEEL_DOWN,
["wheel_up"]= MOUSE_WHEEL_UP,
}

E2mKeyEntity = {}
E2MouseKeyEvents = {}
function e2searchformousekey() 
	for k,v in pairs( mousekeys ) do
		if(input.IsMouseDown(v)) then
			if(!E2MouseKeyEvents[k]) then
				RunConsoleCommand("wire_e2mkp",k,"1")
				E2MouseKeyEvents[k]=true
				continue
			end
		end
		if(E2MouseKeyEvents[k]) then 
			if(!input.IsMouseDown(v)) then 
				RunConsoleCommand("wire_e2mkp",k,"0")
				E2MouseKeyEvents[k]=nil
				continue
			end
		end
	end
end

function e2mkeyHook(msg) 
	local ent = msg:ReadEntity()
	local status = msg:ReadBool()
	if !ent:IsValid() then return end
	if status then E2mKeyEntity[ent]=true else E2mKeyEntity[ent]=nil return end
	if table.Count(E2mKeyEntity)==1 then
		hook.Add( "Think", "E2_MouseKeyPress", e2searchformousekey )
		hook.Add("PlayerBindPress", "E2MouseWheel", function(ply, bind, pressed)
			if (bind == "invprev") or (bind == "invnext") then
				RunConsoleCommand("wire_e2mkp",bind,"1")
			else return end
		end)
		timer.Create("e2ClmKeyPress",1,0,function() 
			for k,v in pairs(E2mKeyEntity) do
				if !k:IsValid() then E2mKeyEntity[k]=nil end
			end
			if table.Count(E2mKeyEntity)==0 then 
				hook.Remove( "Think", "E2_MouseKeyPress")
				hook.Remove( "PlayerBindPress", "E2MouseWheel") 
				timer.Destroy("e2ClmKeyPress") 
			end
		end)
	end 
end

usermessage.Hook("e2mkeyHook",e2mkeyHook)