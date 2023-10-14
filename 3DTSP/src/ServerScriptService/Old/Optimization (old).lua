
local CreationModule = require(script.Parent.Creation)

local function find_distance(points)
	
	local total_distance = 0
	
	for i = 1, #points - 1 do
		local distance = (points[i].Position - points[i + 1].Position).Magnitude
		total_distance += distance
	end
	
	return total_distance
	
end

local function paths_update(points, paths, index)
	
	if paths[index - 1] and points[index - 1] then
		paths[index - 1]:Destroy()
		paths[index - 1] = CreationModule.makePath(points[index - 1], points[index])
		paths[index - 1].Parent = game.Workspace
	end
	
	if paths[index] and points[index + 1] then
		paths[index]:Destroy()
		paths[index] = CreationModule.makePath(points[index], points[index + 1])
		paths[index].Parent = game.Workspace
	end
	
end

local function swap(points, paths, index1, index2)
	
	local temp = points[index1]
	
	points[index1] = points[index2]
	
	points[index2] = temp
	
	paths_update(points, paths, index1)
	paths_update(points, paths, index2)
	
	return 
	
end

local function swap_difference(points, index1, index2)
	
	local total_diff = 0
	
	if points[index1 - 1] then
		local curr_distance = (points[index1 - 1].Position - points[index1].Position).Magnitude
		local swap_distance = (points[index1 - 1].Position - points[index2].Position).Magnitude
		
		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end

	end
	
	if points[index1 + 1] then
		local curr_distance = (points[index1 + 1].Position - points[index1].Position).Magnitude
		local swap_distance = (points[index1 + 1].Position - points[index2].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end
	end
	
	if points[index2 - 1] then
		local curr_distance = (points[index2 - 1].Position - points[index2].Position).Magnitude
		local swap_distance = (points[index2 - 1].Position - points[index1].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end
	end
	
	if points[index2 + 1] then
		local curr_distance = (points[index2 + 1].Position - points[index2].Position).Magnitude
		local swap_distance = (points[index2 + 1].Position - points[index1].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end
	end
	return total_diff
end


local Optimization = {}

function Optimization.better_neighbor(points, paths)
	
	local i = 1
	
	while i <= #points do
		
		local j = 1
		
		while j <= #points do 

			local diff = swap_difference(points, i, j)

			if diff < 0 then
				--print("swap")
				swap(points, paths, i, j)
				i = 1
				j = 0
			end
			
			--wait()			
			
			j += 1	

		end
		
		i += 1
	end
	
	return find_distance(points)
	
end

function Optimization.test(points, paths)
	
	local random1 = math.random(1, #points)
	local random2 = math.random(1, #paths)
	
	swap(points, paths, random1, random2)
end

return Optimization
