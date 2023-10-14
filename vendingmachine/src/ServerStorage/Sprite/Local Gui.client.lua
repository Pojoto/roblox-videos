local Tool = script.Parent;

enabled = true
function onButton1Down(mouse)
	if not enabled then
		return
	end

	enabled = true
	mouse.Icon = "rbxasset://textures\\GunCursor.png"

	--wait(.5)
	--mouse.Icon = "rbxasset://textures\\GunCursor.png"
	--enabled = true
	--mouse.Button1Up:connect(function() onButton1Up(mouse) end)

end


function onButton1Up(mouse)
enabled = false
Tool.Enabled = false
mouse.Icon = "rbxasset://textures\\GunCursor.png"
wait(3)
mouse.Icon = "rbxasset://textures\\GunCursor.png"
enabled = true
Tool.Enabled = true
end

function onEquippedLocal(mouse)

	if mouse == nil then
		print("Mouse not found")
		return 
	end

	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)	
	mouse.Button1Up:connect(function() onButton1Up(mouse)end)
end


Tool.Equipped:connect(onEquippedLocal)
