-- This file is only used to define variables and sub functions.

function execute_movement(final_coordinates)
    -- Defined waypoints based on current position 
    local C1 = {0, -300, 30, 100}
    local C2 = {150, -250, 30, 100}
    local C3 = {300, 0, 30, 100}
    local C4 = {150, 250, 30, 100}
    local C5 = {0, 300, 30, 100}
	
	local instructions = {
    ["1,1"] = function() Wait(100) end,
    ["1,2"] = function() Move(C1) end,
    ["1,3"] = function() Move(C1); Move(C2); Move(C3) end,
    ["1,4"] = function() Move(C1); Move(C2); Move(C3); Move(C4); Move(C5) end,
    ["2,1"] = function() Move(C1) end,
    ["2,2"] = function() Wait(100) end, 
    ["2,3"] = function() Move(C3) end,
    ["2,4"] = function() Move(C3); Move(C4); Move(C5) end,
    ["3,1"] = function() Move(C3); Move(C2); Move(C1) end,
    ["3,2"] = function() Move(C3) end,
    ["3,3"] = function() Wait(100) end,
    ["3,4"] = function() Move(C5) end,
    ["4,1"] = function() Move(C5); Move(C4); Move(C3); Move(C2); Move(C1) end,
    ["4,2"] = function() Move(C5); Move(C4); Move(C3) end,
    ["4,3"] = function() Move(C5) end,
    ["4,4"] = function() Wait(100) end
	}
    
	local function get_quadrant(x, y)
		if x < 0 and y < 0 then return 1
		elseif x > 0 and y < 0 then return 2
		elseif x > 0 and y > 0 then return 3
		elseif x < 0 and y > 0 then return 4
		else return nil -- On the axes
		end
	end
	
	local function execute_instructions(current, final)
		local key = current .. "," .. final
		if instructions[key] then
			instructions[key]()
		else
			print("Path not defined for this combination")
		end
	end
	
	local current_pos = {(GetPose().coordinate[1]), (GetPose().coordinate[2])}
	local current_quadrant = get_quadrant(current_pos[1], current_pos[2])
	local final_quadrant = get_quadrant(final_coordinates[1], final_coordinates[2])
	
	-- Additional checks for proximity near C3
	if current_quadrant == 2 and current_pos[2] > -200 and final_quadrant ~= 4 then
		print("Proximity Check: Moving to C2 to avoid error")
		Move(C2) -- Move to C2 first
	elseif current_quadrant == 3 and current_pos[2] < 100 and final_quadrant ~= 1 then
		print("Proximity Check: Moving to C4 to avoid error")
		Move(C4) -- Move to C4 first
	end
	
	-- Execute the regular instructions based on quadrants
	if current_quadrant and final_quadrant then
        SpeedL(60)
		execute_instructions(current_quadrant, final_quadrant)
     
	else
		print("Invalid coordinates")
	end
end
