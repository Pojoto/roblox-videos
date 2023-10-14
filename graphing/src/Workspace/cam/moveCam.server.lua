

local camBlock = script.Parent

local count = 0

local angle = 0

local origin = Vector3.new(0,0,0)

game:GetService("RunService").Heartbeat:Connect(function(dt)
	
	angle += (0.25) * dt
	print(angle)
	angle = angle % (2 * math.pi)
	
	local pos = Vector3.new(50 * math.cos(angle), 20, 50 * math.sin(angle))
	
	camBlock.CFrame = CFrame.lookAt(pos, origin)

end)

