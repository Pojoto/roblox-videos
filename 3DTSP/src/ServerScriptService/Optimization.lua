
local CreationModule = require(script.Parent.Creation)
local GraphObject = require(script.Parent.GraphObject)
local RS = game:GetService("RunService")


local Optimization = {}

function Optimization.better_neighbor(graph)
	
	local points = graph.points
	local i = 1
	
	while i <= #points do

		local j = 1
		while j <= #points do 
			local diff = graph:swap_difference(i, j)

			if diff < 0 then
				--print("swap")
				points[i].Color = Color3.new(0, 0.890196, 0.0745098)
				points[j].Color = Color3.new(0, 0.890196, 0.0745098)
				RS.Heartbeat:Wait()
				graph:swap_points(i, j)
				points[i].BrickColor = BrickColor.Gray()
				points[j].BrickColor = BrickColor.Gray()
				i = 1
				j = 0
			end
			--wait()
			
			j += 1	
		end
		
		--RS.Heartbeat:Wait()
		i += 1
		
	end
	
	return graph:find_distance()
	
end

function Optimization.best_neighbor(graph)
	local points = graph.points

	local i = 1

	while i <= #points do
		
		local best_index = nil

		local j = 1
		while j <= #points do 
			local diff = graph:swap_difference(i, j)

			if diff < 0 then
				best_index = j
			end
			--wait()						
			j += 1	
		end
		
		if best_index then
			points[i].Color = Color3.new(0, 0.890196, 0.0745098)
			points[best_index].Color = Color3.new(0, 0.890196, 0.0745098)
			graph:swap_points(i, best_index)
			RS.Heartbeat:Wait()
			points[i].BrickColor = BrickColor.Gray()
			points[best_index].BrickColor = BrickColor.Gray()
			i = 0
			j = 0
		end

		i += 1

	end

	return graph:find_distance()

end

function Optimization.stochastic(graph)
	local points = graph.points

	local i = 1

	while i <= #points do

		local better_indices = {}

		local j = 1
		while j <= #points do 
			local diff = graph:swap_difference(i, j)

			if diff < 0 then
				table.insert(better_indices, j)
			end
			--wait()						
			j += 1	
		end

		if #better_indices > 0 then
			local random_index = better_indices[math.random(1, #better_indices)]
			points[i].Color = Color3.new(0, 0.890196, 0.0745098)
			points[random_index].Color = Color3.new(0, 0.890196, 0.0745098)
			graph:swap_points(i, random_index)
			RS.Heartbeat:Wait()
			points[i].BrickColor = BrickColor.Gray()
			points[random_index].BrickColor = BrickColor.Gray()
			i = 0
			j = 0
		end

		i += 1

	end

	return graph:find_distance()

end

function Optimization.simulated_annealing(graph)
	
	local points = graph.points
	
	local temperature = 100

	local i = 1

	while i <= #points do

		local j = 1
		while j <= #points do 
			local diff = graph:swap_difference(i, j)

			--print(diff)
			--print(i .. j)

			if diff < 0 then
				--print("swap")
				--wait(.5)
				points[i].Color = Color3.new(0, 0.890196, 0.0745098)
				points[j].Color = Color3.new(0, 0.890196, 0.0745098)
				RS.Heartbeat:Wait()
				graph:swap_points(i, j)
				points[i].BrickColor = BrickColor.Gray()
				points[j].BrickColor = BrickColor.Gray()
				i = 1
				j = 0
			else
				local p = math.exp(-(diff)/temperature)
				--print("p: " .. p)
				if diff ~= 0 and temperature ~= 0 and p >= math.random(0, 1000)/1000 then
					print("swap 2")
					points[i].Color = Color3.new(0, 0.890196, 0.0745098)
					points[j].Color = Color3.new(0, 0.890196, 0.0745098)
					--wait(.5)
					RS.Heartbeat:Wait()
					graph:swap_points(i, j)
					points[i].BrickColor = BrickColor.Gray()
					points[j].BrickColor = BrickColor.Gray()
					i = 1
					j = 0
				end
			end

			--wait()						
			j += 1	
			temperature = temperature * 0.93
			--print("temp: " .. temperature)
		end

		--RS.Heartbeat:Wait()
		i += 1

	end

	return graph:find_distance()
end

function Optimization.genetic_algorithm(graph)
	return ""
end

function Optimization.test(graph)
	
	local random1 = math.random(1, #graph.points)
	local random2 = math.random(1, #graph.points)
	
	graph:swap(random1, random2)
end

return Optimization
