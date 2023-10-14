local proximityPrompt = script.Parent
local menu = proximityPrompt.Parent

local remote = game.ReplicatedStorage.menuRemote

local cokes = {game.Workspace.coke1, game.Workspace.coke2, game.Workspace.coke3}

local sprites = {game.Workspace.sprite1, game.Workspace.sprite2, game.Workspace.sprite3}

local grapes = {game.Workspace.grape1, game.Workspace.grape2, game.Workspace.grape3}

local items = {
	cokes,
	sprites,
	grapes
		
		
		
}


local increment = 0.01


local function prompted(player)
	remote:FireClient(player)
end

local function run()
	
end

proximityPrompt.Triggered:Connect(prompted)
proximityPrompt.PromptButtonHoldBegan:Connect(run)

remote.OnServerEvent:Connect(function(player, count)
	print("hi")
	local item = items[count]
	
	local newPos = item[3].Position
	
	local newItem = item[3]:Clone()
	
	for i = 1, 1/increment do
		item[1].Position = Vector3.new(item[1].Position.X - increment, item[1].Position.Y, item[1].Position.Z)
		item[2].Position = Vector3.new(item[2].Position.X - increment, item[2].Position.Y, item[2].Position.Z)
		item[3].Position = Vector3.new(item[3].Position.X - increment, item[3].Position.Y, item[3].Position.Z)
		wait(increment)
	end
	
	newItem.Parent = game.Workspace
	
end)
