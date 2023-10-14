
generate = game:GetService("ReplicatedStorage").generate

swap = game:GetService("ReplicatedStorage").swap

local CreationModule = require(game:GetService("ServerScriptService").Creation)

local OptimizationModule = require(game:GetService("ServerScriptService").Optimization)

------------------------------------------------------------------------------------

local main_folder

local num_points = 50

local bounds =
	{
		x = 100,
		y = 100,
		z = 100
	}

local function create()

	local temp_points = {}
	local points = {}

	local point_folder = Instance.new("Folder")
	point_folder.Name = "PointFolder"
	point_folder.Parent = main_folder

	local paths = {}

	local path_folder = Instance.new("Folder")
	path_folder.Name = "PathFolder"
	path_folder.Parent = main_folder

	for i = 1, num_points do	

		local point = CreationModule.makePoint(bounds)

		point.Parent = point_folder

		table.insert(temp_points, point)

	end

	local index = math.random(1, #temp_points)

	local total_distance = 0

	while #temp_points > 1 do

		print(index)

		local old_index = index

		local old_part = temp_points[old_index]

		table.insert(points, old_part)
		table.remove(temp_points, old_index)

		index = math.random(1, #temp_points)

		print("index:")
		print(temp_points[index])	

		print("old:")
		print(old_part)

		local distance = (old_part.Position - temp_points[index].Position).Magnitude

		total_distance += distance

		old_part.Color = Color3.new(1, 0, 0)
		temp_points[index].Color = Color3.new(0, 1, 0)

		local path = CreationModule.makePath(old_part, temp_points[index])
		path.Parent = path_folder

		table.insert(paths, path)

		--wait(.1)

	end

	--insert the last remaining point in temp_points (it was never removed/processed)
	table.insert(points, temp_points[1])

	print(total_distance)

	paths[1].Color = Color3.new(0, 0.0509804, 1)
	points[1].Color = Color3.new(0, 0.898039, 1)
	points[2].Color = Color3.new(0, 0.898039, 1)
	
	return points, paths
	

end


local point_list, path_list = nil

local function init()

	main_folder = Instance.new("Folder")
	main_folder.Name = "MainFolder"
	main_folder.Parent = game.Workspace

	point_list, path_list = create()
	
	--OptimizationModule
	
end

local function swap_func()
	
	--OptimizationModule.test(point_list, path_list)
	print(OptimizationModule.better_neighbor(point_list, path_list))
	
end



generate.OnServerEvent:Connect(init)

swap.OnServerEvent:Connect(swap_func)
