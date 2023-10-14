local textBox = script.Parent
local remote = game.ReplicatedStorage.teamText

local function onFocusLost(enterPressed)
	--if enterPressed then
	if(textBox.text ~= "") then
		print("The player typed: " .. textBox.Text)
		-- Color the text box according to the typed color
		remote:FireServer(tonumber(textBox.Text))
		---local brickColor = BrickColor.new(textBox.Text)
		--textBox.BackgroundColor3 = brickColor.Color
	end

	--end
end

textBox.FocusLost:Connect(onFocusLost)