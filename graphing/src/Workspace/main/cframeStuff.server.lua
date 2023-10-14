

local part = script.Parent

local plus = Instance.new("Part")
plus.BrickColor = BrickColor.new("Bright green")
plus.Parent = game.Workspace
plus.Anchored = true
plus.Name = "plus"
plus.CFrame = part.CFrame + Vector3.new(2, 1, 4)

local times = Instance.new("Part")
times.BrickColor = BrickColor.new("Really red")
times.Parent = game.Workspace
times.Anchored = true
times.Name = "times"
times.CFrame = part.CFrame + Vector3.new(19, 6, 2)




local function move()
	plus.CFrame = part.CFrame + Vector3.new(2, 1, 4)
	times.CFrame = part.CFrame * CFrame.new(1, 1, 1)
end



part.Changed:Connect(move)