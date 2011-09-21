AddCSLuaFile( "cl_KeyPressinit.lua" )
E2KeyEvents = {}
function searchforkey() 
	for i = 1,130 do
		if(input.IsKeyDown(i)) then
			if(!E2KeyEvents[i]) then
				RunConsoleCommand("wire_e2_keypress",tostring(i),"1")
				E2KeyEvents[i]=true
			end
		end
		if(E2KeyEvents[i]) then 
			if(!input.IsKeyDown(i)) then 
				RunConsoleCommand("wire_e2_keypress",tostring(i),"0")
				E2KeyEvents[i]=nil
			end
		end
	end
end

function e2_key_run() 
hook.Add( "Think", "E2_KeyPress", searchforkey )
end

function e2_key_stop() 
hook.Remove( "Think", "E2_KeyPress")
end

usermessage.Hook("e2_key_run",e2_key_run )
usermessage.Hook("e2_key_stop",e2_key_stop )
