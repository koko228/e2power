-- made by [G-moder]FertNoN

local keys = {
["W"]= IN_FORWARD,
["A"]= IN_MOVELEFT,
["S"]= IN_BACK,
["D"]= IN_MOVERIGHT,
["Mouse1"]= IN_ATTACK,
["Mouse2"]= IN_ATTACK2,
["Reload"]= IN_RELOAD,
["Jump"]= IN_JUMP,
["Speed"] = IN_SPEED,
["Run"] = IN_SPEED,
["Zoom"]= IN_ZOOM,
["Walk"]= IN_WALK,
["TurnLeftKey"]= IN_LEFT,
["TurnRightKey"]= IN_RIGHT,
}



__e2setcost(20)
e2function number keyPress(string key)
if self.player:KeyDown(keys[key]) then return 1 else return 0 end
end