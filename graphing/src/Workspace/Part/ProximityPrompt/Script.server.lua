local proximityPrompt = script.Parent
local seat = proximityPrompt.Parent.Seat

--seat:GetPropertyChangedSignal("Occupant"):Connect(function()
--	if seat.Occupant then
--		proximityPrompt.Enabled = false
--	else
--		proximityPrompt.Enabled = true
--	end
--end)

--proximityPrompt.Triggered:Connect(function(player)
--	seat:Sit(player.Character.Humanoid)
--end)