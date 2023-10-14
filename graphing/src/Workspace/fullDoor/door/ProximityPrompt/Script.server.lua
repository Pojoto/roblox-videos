local proximityPrompt = script.Parent
local door = proximityPrompt.Parent
local hinge = proximityPrompt.Parent.Parent.hinge
print(hinge.Name)
local offset = door.Position - hinge.Position


local function prompted()
	game:GetService("RunService").Heartbeat:connect(function(dt)
		hinge.CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(1)*dt*60, 0)
		door.CFrame = hinge.CFrame * CFrame.new(offset)
		--print(hinge.CFrame)
		print(dt)
	end)
	--hinge.CFrame = hinge.CFrame * CFrame.Angles(0, math.pi/4, 0)
	print("hi")
end

local function run()

end

proximityPrompt.Triggered:Connect(prompted)
proximityPrompt.PromptButtonHoldBegan:Connect(run)
	