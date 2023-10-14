local GuiManager = {}

local onScreen = false

--local graphType = "parab"



local origin = Vector3.new(0,0,0)
local o = Instance.new("Part")
o.Parent = game.Workspace
o.Size = Vector3.new(0.1,0.1,0.1)
o.Shape = "Ball"
o.Position = origin
o.Anchored = true
o.Color = Color3.new(1, 0, 0)
o.CanCollide = false
local points = {}
--print(#points)


local operators = "(          -+         /*         ^         qioacte            )"
local trig = "qioacte"
local letters = "abcdefghijklmnopqrstuvwz"
local numbers = "1234567890xy"

local function tprint(tab)

	for count = 1, #tab, 1 do
		print("[" .. count .. "]: " .. tab[count])
	end

end


local function replace(stack1, x, z)
	

	local stack = stack1
	

	
	
	for count = 1, #stack, 1 do
		if stack[count] == "x" then
			stack[count] = z
		elseif stack[count] == "y" then
			stack[count] = x
		end
	end
	
	return stack
	
end



local function search(s, char)

	for i = 1, #s, 1 do
		if(string.sub(s, i, i) == char) then
			return i
		end
	end
	return nil

end


local function calculate(stack1)

	local stack = stack1

	local count = 1

	while(count <= #stack) do

		local item = stack[count]

		if(not search(numbers, item)) then
			if(item == "i") then
				local result = math.sin(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "o") then
				local result = math.cos(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "a") then
				local result = math.tan(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "c") then
				local result = 1 / math.sin(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "e") then
				local result = 1 / math.cos(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "t") then
				local result = 1 / math.tan(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "q") then
				local result = math.sqrt(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "-") then
				local result = tonumber(stack[count - 2]) - tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "+") then
				local result = tonumber(stack[count - 2]) + tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "/") then
				local result = tonumber(stack[count - 2]) / tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "*") then
				local result = tonumber(stack[count - 2]) * tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "^") then

				--print(stack[count - 2])
				--print(stack[count - 1])
				--print(count)
				local result = stack[count - 2]^stack[count - 1]
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			end

			--elseif() then

		end

		count = count + 1
	end
	
	return stack[1]
end




local function graphParab(x, z)
	--local y = (5*sqrtle((x^2 / 30) - (z / 11))) -- dont use
	--local y = (5*sqrt())
	local y = (x^2)/6 + (z^2)/5   -- paraboloid    --math.sqrt(z - x^2)
	--local y = math.sqrt(3) * math.sqrt(1 - (z^2/9) - (x^2/4)) --ellipsoid
	--local y = (1/3) * ((z^2 / 9) - (x^2 / 4)) -- hyperbolic paraboloid
	--local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 3) - 1) -- hyperboloid of one sheet
	--local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 4)) --elliptic cone
	return y
end

local function graphHyperParab(x,z)
	local y = (1/3) * ((z^2 / 9) - (x^2 / 4))
	return y
end

local function graphCone(x,z)
	local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 4)) --elliptic cone
	return y
end

local function graphMonkey(x,z)
	local y = .015 * x^3 - 0.015 * x * z^2 --monkey saddle
	return y
end

local function graphRough(x,z) 
	local y = math.sin(40*x)*math.cos(40*z)/.5 -- rough terrain
	return y
end

local function graphRipple(x,z)
	local y = math.sin(.075 * (x^2 + z^2))/.5 -- ripple
	return y
end

local function graphVolcano(x,z)
	local y = 100/math.log(10 * (x^2+z^2)) --weird inverted volcano thing
	return y
end

local function graphFence(x,z)
	local y = 5/math.exp((x*5)^2*(z*5)^2) --intersecting fences
	return y
end

local function graphPyramid(x,z)
	local y = 1-math.abs(x+z)-math.abs(z-x) --pyramid
	return y
end

local function graphCubic(x,z)
	local y = 0.01 * (x^3 + 5 * z^2) -- parabola cubic thingy
	return y
end
--local y = (5*sqrtle((x^2 / 30) - (z / 11))) -- dont use
--local y = (5*sqrt())
--local y = (x^2)/6 + (z^2)/5   -- paraboloid    --math.sqrt(z - x^2)
--local y = math.sqrt(10) * math.sqrt(15 - (z^2/8) - (x^2/11)) --ellipsoid
--local y = (1/3) * ((z^2 / 9) - (x^2 / 4)) -- hyperbolic paraboloid
--local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 3) - 1) -- hyperboloid of one sheet
--local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 4)) --elliptic cone
--local y = .015 * x^3 - 0.015 * x * z^2 --monkey saddle
--local y = (x^2 + (9/4)*(y^2) + z^2 -1)^3 - (x^2)*(z^3) -(9/200)*(y^2)*(z^3) --heart
--local y = math.sin(40*x)*math.cos(40*z)/.5 -- rough terrain
--local y = math.sin(.075 * (x^2 + z^2))/.5 -- ripple
--local y = 100/math.log(10 * (x^2+z^2)) --weird inverted volcano thing
--local y = 5/math.exp((x*5)^2*(z*5)^2) --intersecting fences
--local y = math.sign(x*z) * math.sign(1-(x*9)^2+(z*9)^2)/.5 --windmill
--local y = 1-math.abs(x+z)-math.abs(z-x) --pyramid
--local y = 0.01 * (x^3 + 5 * z^2) -- parabola cubic thingy

local function triangulate(a, b, c, parent)

	local ta
	local tb

	ta, tb = require(game:GetService("ReplicatedStorage").Triangle)(a.Position, b.Position, c.Position, parent, ta, tb)
	print("Ran")
end

function GuiManager.chooseGraph(player)
	print(player)
	--player.PlayerGui.ScreenGui.LeftBar.Graph.Visible = false
	
	
	
	if(onScreen) then
		player.PlayerGui.ScreenGui.ChooseGraph.Visible = false
		onScreen = false
	else
		player.PlayerGui.ScreenGui.ChooseGraph.Visible = true
		onScreen = true
	end

end



function GuiManager.graph(player, graphType, flip, stack1)
	
	local stack = stack1
	
	
	game.Workspace.GraphFolder:Destroy()
	
	local folder = Instance.new("Folder")
	folder.Parent = game.Workspace
	folder.Name = "GraphFolder"
	
	local count = 0 --variable that is incremented through each point creation - variable that contains total number of points

	local lower = -10 
	local upper = 10

	local allCols = {} --this table will contain more tables - it serves to house all the column tables so we can jump across them

	for x = lower, upper do --this loop can be thought of as the rows of columns - every time x goes up, we move to the next column
		local col = {} --create a new column table to store the following points
		table.insert(allCols, col) --insert this column into the table of all the columns
		for z = lower, upper do --loop through the individual points in a column - every time z goes up we move to the next point in the column
			local o2 = o:Clone()
			
			local yVal
			
			if(graphType == "parab") then
				yVal = graphParab(x, z)
			elseif(graphType == "hyperparab") then
				yVal = graphHyperParab(x, z)
			elseif(graphType == "cone") then
				yVal = graphCone(x, z)
			elseif(graphType == "Monkey") then
				yVal = graphMonkey(x, z)
			elseif(graphType == "Rough") then
				yVal = graphRough(x, z)
			elseif(graphType == "Ripple") then
				yVal = graphRipple(x, z)
			elseif(graphType == "Volcano") then
				yVal = graphVolcano(x, z)
			elseif(graphType == "Fence") then
				yVal = graphFence(x, z)
			elseif(graphType == "Pyramid") then
				yVal = graphPyramid(x, z)
			elseif(graphType == "Cubic") then
				yVal = graphCubic(x, z)
			elseif(graphType == "input") then
				
				--(y^2)/6+(x^2)/5
				local tempStack = {table.unpack(stack1)}
				
				
				
				local newStack = replace(tempStack, x, z)
				
				
				
				yVal = calculate(newStack)
				
			end		
			
			--local yVal = graph(x, z)
			o2.Position = Vector3.new(x, yVal, z)
			o2.Parent = folder


			table.insert(col, o2)


			count += 1
			o2.Name = "Part" .. tostring(count)

			if(x > lower) then --this ensures we start at the second column - we essentially skip the first column because the triangles are essentially creaetd backwards
				if(z == lower) then
					triangulate(col[z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1 + 1], folder)


				elseif(z == upper) then
					triangulate(col[z - lower + 1], col[z - lower + 1 - 1], allCols[x - lower + 1 - 1][z - lower + 1], folder)

				else
					triangulate(col[z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1 + 1], folder)

					triangulate(col[z - lower + 1], col[z - lower + 1 - 1], allCols[x - lower + 1 - 1][z - lower + 1], folder)



				end



			end

			
		end
		if(flip == 5) then
			local index = 0
			
			local trueUpper = upper
			
			if(graphType == "cone")then
				trueUpper = upper - 1
				index += 1
			end
			for z2 = trueUpper, lower, -1 do
				--x - lower + 1
				--if(allCols[x - lower + 1][z2 + upper  + lower  - lower + 1] ) then

				--end
				local o2 = o:Clone()

				local yVal

				if(graphType == "parab") then
					yVal = graphParab(x, z2)
				elseif(graphType == "hyperparab") then
					yVal = graphHyperParab(x, z2)
				elseif(graphType == "cone") then
					yVal = graphCone(x, z2)
				end				
				--local yVal = graph(x, z2)
			

				o2.Position = Vector3.new(x, -yVal, z2)
				o2.Parent = folder


				table.insert(col, o2)
				--end
				index += 1
				count += 1

				o2.Name = "Part" .. tostring(count)

				if(x > lower) then


					print(col[index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower) + 1])
					triangulate(col[index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower) + 1], folder)
		
					triangulate(col[index + (upper  - lower)], col[index + (upper  - lower) - 1], allCols[x - lower + 1 - 1][index + (upper  - lower)], folder)



				end

			end
		end
		
		game:GetService("RunService").Heartbeat:Wait()
	end
	
	
end

function GuiManager.endIntro(player)
	
	player.PlayerGui.ScreenGui.Intro.Visible = false
	
end

function GuiManager.trace(normal)
	
	local kVector = Vector3.new(0, 1, 0)
	
	local angle = math.acos(kVector.Magnitude * normal.Magnitude)
	
	
	
	
	
end

function GuiManager.partials()
	
	local plane = Instance.new("Part")
	plane.Position = Vector3.new()
	
end


--while true do loop that creates a raycast from player cam to mousehit. if mouse hit block is a point then enlarge it. if click on 







return GuiManager
