
-- Function to determine waypoints based on quadrants
function calculateWaypointsBasedOnQuadrants(initialPos, finalPos)
    local waypoints = {}

    -- Common waypoints for traversal
    local coordinate1 = {0, -300, initialPos[3], initialPos[4]}  -- Midpoint on x-axis for initial x
    local coordinate2 = {150, -250, initialPos[3], initialPos[4]}  -- Midpoint on y-axis for initial y
    local coordinate3 = {300, 0, initialPos[3], initialPos[4]}             -- Origin
    local coordinate4 = {150, 250, initialPos[3], initialPos[4]}   -- Midpoint on x-axis for final x
    local coordinate5 = {0, 300, finalPos[3], finalPos[4]}   -- Midpoint on y-axis for final y

    -- Determine path based on initial and final positions
    if initialPos[1] < 0 and initialPos[2] < 0 and finalPos[1] < 0 and finalPos[2] > 0 then
        -- Case 1: (x-, y-) to (x-, y+)
        waypoints = {initialPos, coordinate1, coordinate2, coordinate3, coordinate4, coordinate5, finalPos}
    elseif initialPos[1] > 0 and initialPos[2] < 0 and finalPos[1] < 0 and finalPos[2] > 0 then
        -- Case 2: (x+, y-) to (x-, y+)
        waypoints = {initialPos, coordinate3, coordinate4, coordinate5, finalPos}
    elseif initialPos[1] > 0 and initialPos[2] > 0 and finalPos[1] < 0 and finalPos[2] > 0 then
        -- Case 3: (x+, y+) to (x-, y+)
        waypoints = {initialPos, coordinate5, finalPos}
    else
        -- Default case: direct move (for any other scenario not specified)
        waypoints = {initialPos, finalPos}
    end

    return waypoints
end

-- Define the initial and final positions
local initialPos = {-260, -100, 30, 0}
local finalPos = {-260, 100, 10, 45}

-- Calculate waypoints based on quadrants
local waypoints = calculateWaypointsBasedOnQuadrants(initialPos, finalPos)

-- Command to move through the waypoints
for _, pos in ipairs(waypoints) do
    Jump({coordinate = pos, tool = 0, user = 0}, {Start = NaN, ZLimit = NaN, End = NaN})
end
