

local drink = script.Parent
local clickDetector = drink.ClickDetector
local storedSprite = game:GetService("ServerStorage").Sprite

clickDetector.MouseClick:Connect(function(player)
	
	
	storedSprite.Parent = player.Backpack
	drink.Parent = player.Backpack
	
	
end)