
local tweenService = game:GetService("TweenService")

local remote = game.ReplicatedStorage.menuRemote

local camera = game.Workspace.Camera

local frame = script.Parent
local left = frame.leftArrow
local right = frame.rightArrow
local buy = frame.buy
local name = frame.itemName



frame.Visible = false
local count = 0


local cams = {
	game.Workspace.cams.Coke,
	game.Workspace.cams.Sprite,
	game.Workspace.cams["Grape Soda"]
}



local initalInfo = TweenInfo.new(
	2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local interInfo = TweenInfo.new(
	.5,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)


remote.OnClientEvent:Connect(function()
	count = 1


	camera.CameraType = Enum.CameraType.Scriptable
	--cf1 = camera.CFrame

	local tween = tweenService:Create(camera, initalInfo, {CFrame = cams[count].CFrame})

	tween:Play()

	wait(2)
	
	
	
	frame.Visible = true
	
	name.Text = cams[count].Name

	--camera.CameraType = Enum.CameraType.Custom
end)


right.MouseButton1Click:Connect(function()
	
	count += 1
	
	local tween = tweenService:Create(camera, interInfo, {CFrame = cams[count].CFrame})
	
	tween:Play()
	
	name.Text = cams[count].Name
	
end)


left.MouseButton1Click:Connect(function()
	
	count -= 1
	
	local tween = tweenService:Create(camera, interInfo, {CFrame = cams[count].CFrame})
	
	tween:Play()
	
	name.Text = cams[count].Name
	
end)

buy.MouseButton1Click:Connect(function()
	
	remote:FireServer(count)
	print("HI")
	wait(4)
	camera.CameraType = Enum.CameraType.Custom
	
	frame.Visible = false
	
end)


