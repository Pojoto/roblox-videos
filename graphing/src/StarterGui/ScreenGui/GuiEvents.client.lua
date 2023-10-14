
local screen = script.Parent
local manager = game:GetService("ReplicatedStorage").ExecManager
local player = game:GetService("Players").LocalPlayer
print(player)
local graphButton = screen.LeftBar.Graph
local chooseGraphFrame = screen.ChooseGraph
local graphParab = chooseGraphFrame.Paraboloid
local graphHyperParab = chooseGraphFrame.HyperbolicParaboloid
local graphCone = chooseGraphFrame.Cone
local graphRandom = screen.LeftBar.Settings
local makeTrace = screen.LeftBar.MakeTrace
local findPartials = screen.LeftBar.FindPartials
local help = screen.LeftBar.Help
local helpFrame = screen.HelpMenu

local i = Vector3.new(1, 0, 0)
local j = Vector3.new(0, 0, 1)
local k = Vector3.new(0, 1, 0)

local textBox = screen.LeftBar.InputGraph
local remote = game.ReplicatedStorage.playerText


local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
wait()
local cam = workspace:WaitForChild("Camera")

local partialToggle = false

screen.Intro.Visible = true


--local function makePlane(origin, v1, v2)

--	local tanPlane = Instance.new("Part")

--	tanPlane.Anchored = true
--	tanPlane.Parent = game.Workspace.GraphFolder or game.Workspace
--	tanPlane.Material = Enum.Material.Neon
--	tanPlane.Color = Color3.new(1, 0, 0)
--	tanPlane.Size = Vector3.new(10,10,0.1)
--	tanPlane.Position = origin

--	local xVector = tanPlane.CFrame:PointToObjectSpace(v1)
--	local zVector = tanPlane.CFrame:PointToObjectSpace(v2)

--	local normalVector = xVector:Cross(zVector)

--	local normWorldVector = tanPlane.CFrame:PointToWorldSpace(normalVector)

--	tanPlane.CFrame = CFrame.lookAt(origin, normWorldVector)

--end

local function makePlane(origin, n, length, color)

	local plane = Instance.new("Part")

	plane.Anchored = true
	plane.Parent = game.Workspace.GraphFolder or game.Workspace
	--tanPlane.Material = Enum.Material.Neon
	plane.Color = color
	plane.Size = Vector3.new(length,length,0.1)
	plane.Transparency = 0.8
	plane.Position = origin



	local normalVector = n

	local normWorldVector = plane.CFrame:PointToWorldSpace(normalVector)

	plane.CFrame = CFrame.lookAt(origin, normWorldVector)

end

local function makeLine(origin, point, length)

	local line = Instance.new("Part")
	line.Position = origin
	line.Size = Vector3.new(0.11, 0.11, length)--Vector3.new(length, 0.11, 0.11)
	line.Color = Color3.new(0, 0, 0)
	line.Anchored = true
	line.CFrame = CFrame.lookAt(origin, point)

	line.Parent = game.Workspace

end


local function onInputBegan(input, gameProcessed)
	if partialToggle == false then
		if input.UserInputType == Enum.UserInputType.MouseButton1 and (math.sqrt(math.abs(mouse.Hit.p.X)^2 + math.abs(mouse.Hit.p.Z)^2)  < 300)  then
			local pos = mouse.Hit.p
			print("The left mouse button has been pressed!")
			local bubble = Instance.new("Part")
			bubble.Shape = "Ball"
			bubble.Size = Vector3.new(1,1,1)
			bubble.Transparency = 0.7
			bubble.Color = Color3.new(0.952941, 1, 0)
			bubble.Anchored = true
			bubble.Position = pos
			bubble.Parent = game.Workspace.GraphFolder or game.Workspace



			--local tanPlane = Instance.new("Part")

			--tanPlane.Anchored = true
			--tanPlane.Parent = game.Workspace.GraphFolder or game.Workspace
			--tanPlane.Material = Enum.Material.Neon
			--tanPlane.Color = Color3.new(1, 0, 0)
			--tanPlane.Size = Vector3.new(10,.1,10)


			--local raycastResult = workspace:Raycast(cam.CFrame.p, pos - cam.CFrame.p)

			--if raycastResult then
			--	tanPlane.CFrame = CFrame.lookAt(pos, -raycastResult.Normal) 
			--end


			--xPartialVector and zPartialVector are both tangent vectors at 'pos' with one X or Z unit in their respective directions. They are just for  
			--noting the direction of the partial tangent lines, which are both then used as v1 and v2 in the makePlane function

			local posCF = CFrame.new(pos)


			local xHyperParabPartialVector = Vector3.new(pos.X + 1, pos.Y - (pos.X)/6, pos.Z)
			local zHyperParabPartialVector = Vector3.new(pos.X, pos.Y + (2*(pos.Z))/27, pos.Z + 1)

			local xParabPartialVector = Vector3.new(pos.X + 1, pos.Y + (pos.X)/3, pos.Z)
			local zParabPartialVector = Vector3.new(pos.X, pos.Y + (2*(pos.Z))/5, pos.Z + 1)

			local xMainPartial = posCF:PointToObjectSpace(Vector3.new(pos.X + 1, pos.Y + 3*(math.pow(pos.X, 2))/100, pos.Z))
			local zMainPartial = posCF:PointToObjectSpace(Vector3.new(pos.X, pos.Y + pos.Z/10, pos.Z + 1))



			makePlane(pos, xMainPartial:Cross(zMainPartial), 10, Color3.new(1, 0.294118, 0.305882))
			--makePlane(pos, xHyperParabPartialVector, zHyperParabPartialVector)
			--makePlane(pos, xParabPartialVector, zParabPartialVector)

		end
	elseif partialToggle and input.UserInputType == Enum.UserInputType.MouseButton1 then

		local pos = mouse.Hit.p

		makePlane(pos, j, 100, Color3.new(0.4, 1, 0))

		local partialPoint = Vector3.new(pos.X + 1, pos.Y + 3*(math.pow(pos.X, 2))/100, pos.Z)
		local partialVector = Vector3.new(pos.X + 1, pos.Y - (pos.X)/6, pos.Z) - Vector3.new(pos.X, pos.Y, pos.Z)
		
		local partial = Instance.new("Part")
		partial.Shape = "Ball"
		partial.Size = Vector3.new(1,1,1)
		partial.Transparency = .2
		partial.Color = Color3.new(0.952941, 1, 0)
		partial.Anchored = true
		partial.Position = partialPoint
		partial.Parent = game.Workspace

		makeLine(pos, partialPoint, 100)



	end

end




--local findd = chooseGraphFrame.FindDD
local graphs = 
	{
		"Monkey",
		"Rough",
		"Ripple",
		"Volcano",
		"Fence",
		"Pyramid",
		"Cubic"


	}


local GuiManager = require(manager)




graphButton.MouseButton1Click:Connect(function()
	print(player)
	GuiManager.chooseGraph(game:GetService("Players").LocalPlayer)
end)

graphParab.MouseButton1Click:Connect(function()

	print(player)
	GuiManager.graph(game:GetService("Players").LocalPlayer, "parab", false)


end)

graphHyperParab.MouseButton1Click:Connect(function()
	print(player)
	GuiManager.graph(game:GetService("Players").LocalPlayer, "hyperparab", false)
end)

graphCone.MouseButton1Click:Connect(function()
	print(player)
	GuiManager.graph(game:GetService("Players").LocalPlayer, "cone", true)
end)

graphRandom.MouseButton1Click:Connect(function()
	print(player)

	local randomGraph = graphs[math.random(1, #graphs)]

	GuiManager.graph(game:GetService("Players").LocalPlayer, randomGraph, true)

	print(randomGraph)
end)

makeTrace.MouseButton1Click:Connect(function()

	local randomNormal = Vector3.new(math.random(-5, 10), math.random(-5, 10), math.random(-5, 10)).Unit;


	GuiManager.trace(randomNormal)

end)

findPartials.MouseButton1Click:Connect(function()

	if partialToggle then
		partialToggle = false
	else
		partialToggle = true
	end


end)

help.MouseButton1Click:Connect(function()
	
	if helpFrame.Visible then
		helpFrame.Visible = false
	else
		helpFrame.Visible = true;
	end
	
end)


textBox.FocusLost:Connect(function(enterPressed)
	if(textBox.text ~= "") then
		print("The player typed: " .. textBox.Text)
		-- Color the text box according to the typed color
		remote:FireServer(textBox.Text)
		---local brickColor = BrickColor.new(textBox.Text)
		--textBox.BackgroundColor3 = brickColor.Color
	end
end)




UserInputService.InputBegan:Connect(onInputBegan)
