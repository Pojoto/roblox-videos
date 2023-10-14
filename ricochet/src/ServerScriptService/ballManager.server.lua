

local remote = game.ReplicatedStorage.clicked


local ball = game.ServerStorage.ball

remote.OnServerEvent:Connect(function(player, pos)
	
	local humanoid = player.Character.Humanoid
	local playerPos = humanoid.RootPart.Position
	
	
	
	local clone = ball:Clone()

	clone.Parent = game.Workspace
	clone:SetNetworkOwner(nil)

		print("moving")
		local velocity = humanoid.RootPart.Velocity
		clone.Velo.VectorVelocity = velocity + Vector3.new(pos.X - playerPos.X, 0, pos.Z - playerPos.Z).Unit * 20

		print("stationary")

	clone.Position = playerPos
end)
