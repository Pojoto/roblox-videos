
local button = script.Parent
local remote = game.ReplicatedStorage.organize

local function onButtonActivated()
	print("Button activated!")
	remote:FireServer()
	-- Perform expected button action(s) here

end

button.Activated:Connect(onButtonActivated)


