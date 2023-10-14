
local tweenPart = script.Parent

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

local tween = tweenService:Create(tweenPart, info, tweenGoals)

wait(2)

tween:Play()

