
local CreationModule = require(script.Parent.Creation)

local Graph = {}
Graph.__index = Graph

local function make_random(num_points, bounds, point_folder, path_folder)
	local temp_points = {}
	local points = {}
	local paths = {}
	
	for i = 1, num_points do	
		local point = CreationModule.makePoint(bounds)
		point.Parent = point_folder
		table.insert(temp_points, point)
	end

	local index = math.random(1, #temp_points)

	local total_distance = 0

	while #temp_points > 1 do
		local old_index = index
		local old_part = temp_points[old_index]

		table.insert(points, old_part)
		table.remove(temp_points, old_index)

		index = math.random(1, #temp_points)
		local new_part = temp_points[index]

		local distance = (old_part.Position - new_part.Position).Magnitude

		total_distance += distance

		local path = CreationModule.makePath(old_part, new_part)
		path.Parent = path_folder

		table.insert(paths, path)
	end

	--insert the last remaining point in temp_points (it was never removed/processed)
	table.insert(points, temp_points[1])
	return points, paths
end

function Graph.new(point_list, path_list, num_points, bounds, main_folder)
	
	local new_graph = {}
	new_graph.points = point_list
	new_graph.paths = path_list
	new_graph.folder = main_folder
	setmetatable(new_graph, Graph)
end

function Graph.new_random(num_points, bounds, main_folder)

	local point_folder = Instance.new("Folder")
	point_folder.Name = "PointFolder"
	point_folder.Parent = main_folder

	local path_folder = Instance.new("Folder")
	path_folder.Name = "PathFolder"
	path_folder.Parent = main_folder
	
	local points, paths = make_random(num_points, bounds, point_folder, path_folder)
	
	local new_graph = {}
	new_graph.points = points 
	new_graph.paths = paths 
	new_graph.folder = main_folder
	setmetatable(new_graph, Graph)
	
	return new_graph
	
end

------------------------------------------------------------------------

function Graph:find_distance()
	local total_distance = 0

	for i = 1, #self.points - 1 do
		local distance = (self.points[i].Position - self.points[i + 1].Position).Magnitude
		total_distance += distance
	end

	return total_distance
end

function Graph:paths_update(index)
	
	local path_color = Color3.new(0, 0, 0)
	
	if self.paths[index - 1] and self.points[index - 1] then
		self.paths[index - 1]:Destroy()
		self.paths[index - 1] = CreationModule.makePath(self.points[index - 1], self.points[index], path_color)
		self.paths[index - 1].Parent = self.folder.PathFolder
	end

	if self.paths[index] and self.points[index + 1] then
		self.paths[index]:Destroy()
		self.paths[index] = CreationModule.makePath(self.points[index], self.points[index + 1], path_color)
		self.paths[index].Parent = self.folder.PathFolder
	end
end

function Graph:swap_points(index1, index2)

	local temp = self.points[index1]

	self.points[index1] = self.points[index2]

	self.points[index2] = temp

	self:paths_update(index1)
	self:paths_update(index2)

	return 

end

function Graph:swap_difference(index1, index2)

	local total_diff = 0

	if self.points[index1 - 1] then
		local curr_distance = (self.points[index1 - 1].Position - self.points[index1].Position).Magnitude
		local swap_distance = (self.points[index1 - 1].Position - self.points[index2].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end

	end

	if self.points[index1 + 1] then
		local curr_distance = (self.points[index1 + 1].Position - self.points[index1].Position).Magnitude
		local swap_distance = (self.points[index1 + 1].Position - self.points[index2].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end
	end

	if self.points[index2 - 1] then
		local curr_distance = (self.points[index2 - 1].Position - self.points[index2].Position).Magnitude
		local swap_distance = (self.points[index2 - 1].Position - self.points[index1].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end
	end

	if self.points[index2 + 1] then
		local curr_distance = (self.points[index2 + 1].Position - self.points[index2].Position).Magnitude
		local swap_distance = (self.points[index2 + 1].Position - self.points[index1].Position).Magnitude

		if swap_distance ~= 0 then
			local diff = swap_distance - curr_distance
			total_diff += diff
		end
	end
	return total_diff
end

---------------------------------------------------------------------------

return Graph
