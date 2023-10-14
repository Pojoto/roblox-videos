
local ball = script.Parent


local result = workspace:Raycast(ball.Position, ball.CFrame.LookVector)

if result then
	
end


local Ball = {}


Ball._index = Ball


function Ball.new(part, bouncesLeft, speed, initialNormal)

	local newBall = {}
	setmetatable(newBall, Ball)

	newBall.Part = part
	newBall.BouncesLeft = bouncesLeft
	newBall.Speed = speed

	part.veloAttachment.Velo.VectorVelocity = initialNormal.Unit * speed

	return newBall

end

function Ball:Bounce()

	--print(initialNormal)

	local rayOrigin = self.Part.Position

	if(self.BouncesLeft <= 0) then
		return
	end

	--local raycastParams = RaycastParams.new()
	local raycastResult = workspace:Raycast(rayOrigin, self.currentNormal)

	if(raycastResult) then

		local surfaceNormal = raycastResult.Normal

		local resultantNormal = self.currentNormal - 2 * (self.currentNormal * surfaceNormal) * surfaceNormal



		self.Part.Velocity.VectorVelocity = resultantNormal.Unit * self.Speed

		self.currentNormal = resultantNormal

	end



	self.BouncesLeft -= 1

end


function Ball:Activate()
	self.Part.Touched:Connect(self:Bounce())
end



return Ball
