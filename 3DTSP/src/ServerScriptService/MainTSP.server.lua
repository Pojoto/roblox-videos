
generate = game:GetService("ReplicatedStorage").generate

swap = game:GetService("ReplicatedStorage").swap

local CreationModule = require(game:GetService("ServerScriptService").Creation)

local OptimizationModule = require(game:GetService("ServerScriptService").Optimization)

local Graph = require(game:GetService("ServerScriptService").GraphObject)

---------------------------------------------------------------------------------------------------------------------

local NUM_POINTS = 100

local BOUNDS =
	{
		X = 100,
		Y = 100,
		Z = 100
	}

local graph = nil

local function make_graph()
	
	if game.Workspace:FindFirstChild("MainFolder") then
		game.Workspace.MainFolder:Destroy()
	end

	local main_folder = Instance.new("Folder")
	main_folder.Name = "MainFolder"
	main_folder.Parent = game.Workspace
	
	graph = Graph.new_random(NUM_POINTS, BOUNDS, main_folder)
	print(graph:find_distance())
	
end

local function swap_func(player, alg)
	
	if alg == "Simple" then
		print(OptimizationModule.better_neighbor(graph))		
	elseif alg == "Steepest" then
		print(OptimizationModule.best_neighbor(graph))
	elseif alg == "Stochastic" then
		print(OptimizationModule.stochastic(graph))
	elseif alg == "Simulated" then
		print(OptimizationModule.simulated_annealing(graph))
	elseif alg == "Genetic" then
		print(OptimizationModule.genetic_algorithm(graph))
	end
	
	--OptimizationModule.test(point_list, path_list)
	
end

--------------------------------------------------------------------------------------------------------------------

generate.OnServerEvent:Connect(make_graph)

swap.OnServerEvent:Connect(swap_func)
