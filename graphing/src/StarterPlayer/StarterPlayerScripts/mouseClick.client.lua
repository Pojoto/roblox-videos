


local player = game:GetService("Players").LocalPlayer

local mouse = player:GetMouse()

local UserInputService = game:GetService("UserInputService")

wait()
local cam = workspace:WaitForChild("Camera")

-- A sample function providing one usage of InputBegan


local function makePlane(origin, v1, v2)

	local tanPlane = Instance.new("Part")

	tanPlane.Anchored = true
	tanPlane.Parent = game.Workspace.GraphFolder or game.Workspace
	tanPlane.Material = Enum.Material.Neon
	tanPlane.Color = Color3.new(1, 0, 0)
	tanPlane.Size = Vector3.new(10,10,0.1)
	tanPlane.Position = origin

	local xVector = tanPlane.CFrame:PointToObjectSpace(v1)
	local zVector = tanPlane.CFrame:PointToObjectSpace(v2)
	
	local normalVector = xVector:Cross(zVector)

	local normWorldVector = tanPlane.CFrame:PointToWorldSpace(normalVector)

	tanPlane.CFrame = CFrame.lookAt(origin, normWorldVector)

end


local function onInputBegan(input, gameProcessed)
	
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
		
		local xHyperParabPartialVector = Vector3.new(pos.X + 1, pos.Y - (pos.X)/6, pos.Z)
		local zHyperParabPartialVector = Vector3.new(pos.X, pos.Y + (2*(pos.Z))/27, pos.Z + 1)

		local xParabPartialVector = Vector3.new(pos.X + 1, pos.Y + (pos.X)/3, pos.Z)
		local zParabPartialVector = Vector3.new(pos.X, pos.Y + (2*(pos.Z))/5, pos.Z + 1)
		
		local xMainPartial = Vector3.new(pos.X + 1, pos.Y + 3*(math.pow(pos.X, 2))/100, pos.Z)
		local zMainPartial = Vector3.new(pos.X, pos.Y + pos.Z/10, pos.Z + 1)

		makePlane(pos, xMainPartial, zMainPartial)
		--makePlane(pos, xHyperParabPartialVector, zHyperParabPartialVector)
		--makePlane(pos, xParabPartialVector, zParabPartialVector)

	end
end

UserInputService.InputBegan:Connect(onInputBegan)









