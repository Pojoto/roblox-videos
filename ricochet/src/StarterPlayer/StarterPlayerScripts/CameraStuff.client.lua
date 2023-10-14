local cam = workspace:WaitForChild("Camera")

local remote = game.ReplicatedStorage.clicked
--local cam2 = game.Workspace:WaitForChild("cam")----- gets your character's camera
local player = game.Players.LocalPlayer  ---- finds a player

local character = player.CharacterAdded:Wait()----- waiting until the character is found

local mouse = player:GetMouse()

cam.CameraType = "Scriptable" ----- makes sure that the camera is changable

local angle = 0

local origin = Vector3.new(0,0,0)


mouse.Button1Down:Connect(function()
	remote:FireServer(mouse.hit.p)
end)
