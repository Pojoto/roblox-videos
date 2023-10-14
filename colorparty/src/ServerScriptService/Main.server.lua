--add loop too
local teamTextRemote = game.ReplicatedStorage.teamText
local playerTextRemote = game.ReplicatedStorage.playerText
local startRemote = game.ReplicatedStorage.start
local playerNumber = 20;
local respawn = true;
local playerGroup = game.Workspace.Players
local teamNumber = 4
local organizeRemote = game.ReplicatedStorage.organize
local playerSize = 4;


local tweenPart

local tweenService = game:GetService("TweenService")

local info = TweenInfo.new(

	4, 
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	5,
	true,
	1
)

local tweenGoals = {

	Position = Vector3.new(100, .5, -100);
	--Material = Enum.Material.Neon;
	--Color3 = Color3.fromRGB(234,92,103)

}




local function distribute(main, arr)
	local length = #arr
	print(length)
	local random = math.random(1, #main)
	for count = 1, length do
		table.insert(main[random], arr[count])
		random = (random + 1) % 5
		if(random == 0) then
			random = 1
		end
	end
	
end

local function organize()
	
	local playerList = playerGroup:GetChildren()

	for count = 1, #playerList do
		tweenPart = playerList[count]

		local tween = tweenService:Create(tweenPart, info, tweenGoals)
		
		tweenGoals.Position = Vector3.new(tweenGoals.Position.X + 10, tweenGoals.Position.Y, tweenGoals.Position.Z)
		
		--tweenPart.CanCollide = false
		
		tween:Play()
	end
	


end


local function spawnPlayers()
	playerGroup:ClearAllChildren()
	for count = 1, playerNumber do
		local newPlayer = Instance.new("Part")
		newPlayer.Shape = "Ball"
		newPlayer.Size = Vector3.new(playerSize, playerSize, playerSize)
		newPlayer.Position = Vector3.new(math.random(-40, -20), math.random(15, 25), math.random(-110, -90))
		newPlayer.Parent = playerGroup
		
		--wait(1.0 / playerNumber)
	end
	
end

local function generate()
	
	if(respawn == true) then
		spawnPlayers()
	end
	
	local colors = {

		"Really red",
		"Dark green",
		"Dark blue",
		"New Yeller",
		"Teal",
		"Electric blue",
		"Hot pink",
		"Lily white",
		"CGA brown"

	}
	
	local players = game.Workspace.Players:GetChildren()
	local numPlayers = #players

	print(teamNumber)
	print(teamNumber + 5)
	local pLeft = table.create(teamNumber)
	local even = math.floor(numPlayers / teamNumber)

	for count = 1, teamNumber do
		pLeft[count] = even
	end

	local difference = numPlayers - even * teamNumber
	local rand = math.random(1, teamNumber)
	print(difference)
	if(difference ~= 0) then
		for count = 1, difference do
			pLeft[rand] += 1
			rand = (rand + 1) % (difference + 1)
			if(rand == 0) then
				rand = 1
			end
		end

	end
	
	
	for count = 1, numPlayers do
		local random = math.random(1, #players)
		local player = players[random]
		local teamRandom = math.random(1, #pLeft)

		player.BrickColor = BrickColor.new(colors[teamRandom])
		pLeft[teamRandom] -= 1
		table.remove(players, table.find(players, player))

		if(pLeft[teamRandom] == 0) then
			table.remove(pLeft, teamRandom)
			table.remove(colors, teamRandom)
		end
		--wait(1 / numPlayers)
		game:GetService("RunService").Heartbeat:Wait()
	end
	respawn = false
end



teamTextRemote.OnServerEvent:Connect(function(player, num)
	teamNumber = num
end)

playerTextRemote.OnServerEvent:Connect(function(player, num)
	if(num ~= playerNumber) then
		respawn = true
	else
		respawn = false
	end
	playerNumber = num
end)

organizeRemote.OnServerEvent:Connect(function()
	organize()
end)

startRemote.OnServerEvent:Connect(generate)



