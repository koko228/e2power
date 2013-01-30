
if SERVER then 
	AddCSLuaFile("entities/gmod_wire_expression2/core/custom/cl_e2derma.lua")
	AddCSLuaFile("entities/gmod_wire_expression2/core/custom/cl_huddraw.lua")
	AddCSLuaFile("entities/gmod_wire_expression2/core/custom/cl_KeyPress.lua")
	AddCSLuaFile("entities/gmod_wire_expression2/core/custom/cl_particles.lua")
	AddCSLuaFile("autorun/autoloade2p.lua")
else 
	timer.Simple(10, function() 
		include("entities/gmod_wire_expression2/core/custom/cl_e2derma.lua")
		include("entities/gmod_wire_expression2/core/custom/cl_huddraw.lua")
		include("entities/gmod_wire_expression2/core/custom/cl_KeyPress.lua")
		include("entities/gmod_wire_expression2/core/custom/cl_particles.lua")
	end)
end