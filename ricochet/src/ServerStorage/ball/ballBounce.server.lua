

local part = script.Parent

part.BrickColor = BrickColor.Random()



local attach = Instance.new("Attachment")
attach.Parent = part
attach.Name = "attachment"


local force = Instance.new("VectorForce")
force.Attachment0 = attach
force.Parent = part
force.Force = Vector3.new(0, game.Workspace.Gravity, 0)



local velo = Instance.new("LinearVelocity")
velo.Attachment0 = attach
--velo.VectorVelocity = Vector3.new(3, 0, 2)--part.CFrame.LookVector * 5--Vector3.new(-4, 0, 0)
velo.Parent = part
velo.Name = "Velo"

local function bounce(hit)
	if(hit.Parent:FindFirstChild("Humanoid") or hit.Name == "ball") then
		return
	end
	local rayOrigin = part.Position
	local currentNormal = velo.VectorVelocity.Unit--part.Velo.VectorVelocity--part.CFrame.LookVector

	--local currentNormal = 

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = {game.Workspace.walls}
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist


	local result = workspace:Raycast(rayOrigin, currentNormal.Unit * 4, raycastParams)


	if result then
		local surfaceNormal = result.Normal.Unit
		local resultantNormal = currentNormal - 2 * (currentNormal:Dot(surfaceNormal)) * surfaceNormal
		velo.VectorVelocity = resultantNormal.Unit * 20
	end



end

--bounce()

part.Touched:Connect(bounce)
--bounce())



--local Ball = {}

----Part = nil
----Speed = nil
----BouncesLeft = nil
------local initialNormal = nil
----currentNormal = nil

--Ball._index = Ball


--function Ball.new(part, bouncesLeft, speed, initialNormal)

--	local newBall = {}
--	setmetatable(newBall, Ball)

--	newBall.Part = part
--	newBall.BouncesLeft = bouncesLeft
--	newBall.Speed = speed

--	part.veloAttachment.Velo.VectorVelocity = initialNormal.Unit * speed

--	return newBall

--end

--function Ball:Bounce()

--	--print(initialNormal)

--	local rayOrigin = self.Part.Position

--	if(self.BouncesLeft <= 0) then
--		return
--	end

--	--local raycastParams = RaycastParams.new()
--	local raycastResult = workspace:Raycast(rayOrigin, self.currentNormal)

--	if(raycastResult) then

--		local surfaceNormal = raycastResult.Normal

--		local resultantNormal = self.currentNormal - 2 * (self.currentNormal * surfaceNormal) * surfaceNormal



--		self.Part.Velocity.VectorVelocity = resultantNormal.Unit * self.Speed

--		self.currentNormal = resultantNormal

--	end



--	self.BouncesLeft -= 1

--end


--function Ball:Activate()
--	self.Part.Touched:Connect(self:Bounce())
--end



--return Ball
