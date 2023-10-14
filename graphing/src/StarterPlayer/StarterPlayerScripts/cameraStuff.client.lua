wait()
local cam = workspace:WaitForChild("Camera")
local cam2 = game.Workspace:WaitForChild("cam")----- gets your character's camera
local player = game.Players.LocalPlayer  ---- finds a player

local blur = game:GetService("Lighting").Blur

local manager = game:GetService("ReplicatedStorage").ExecManager

blur.Size = 20

local inputService = game:GetService("UserInputService")

local character = player.Character----- waiting until the character is found

cam.CameraType = Enum.CameraType.Scriptable ----- makes sure that the camera is changable

local angle = 0

local origin = Vector3.new(0,0,0)

local connection

local connection1

local introEnded = false

local pos1

local GuiManager = require(manager)


local function intro(dt)
	

	--if(inputService:IsKeyDown(Enum.KeyCode.E)) then
		--print("e pressed")
		--introEnded = true
	--end
	
	if(introEnded) then
		connection:Disconnect()
	end
	
	angle += (0.25) * dt 
	angle = angle % (2 * math.pi)
	
	local pos = Vector3.new(50 * math.cos(angle), 0, 50 * math.sin(angle))
	
	pos1 = pos

	cam.CFrame =  CFrame.lookAt(pos, origin)
end

connection = game:GetService("RunService").RenderStepped:Connect(intro)


local mouse = player:GetMouse()

local radius = 50



local zero = Vector3.new(0,0,0)

mouse.WheelForward:Connect(function()
	
	local new = zero:Lerp(cam.CFrame.Position, 0.9)
	
	radius = new.Magnitude
	
	cam.CFrame = CFrame.lookAt(new, zero)
	
	print("scrolled")
	
end)

mouse.WheelBackward:Connect(function()
	
	local new = zero:Lerp(cam.CFrame.Position, 1.1)

	radius = new.Magnitude

	cam.CFrame = CFrame.lookAt(new, zero)

	print("scrolled")
end)


game:GetService("RunService").RenderStepped:Connect(function()
	
	local theta
	
	if(introEnded) then
		if(cam.CFrame.Position.Z < 0 and cam.CFrame.Position.X < 0) then
			theta = math.atan(cam.CFrame.Position.Z/cam.CFrame.Position.X) + math.pi
		elseif(cam.CFrame.Position.Z > 0 and cam.CFrame.Position.X < 0) then
			theta = math.atan(cam.CFrame.Position.Z/cam.CFrame.Position.X) + math.pi
		else
			theta = math.atan(cam.CFrame.Position.Z/cam.CFrame.Position.X)
		end
		
		
		local step = math.pi / 180
		--local phi = math.atan(math.sqrt((cam.CFrame.Position.X)^2 + (cam.CFrame.Position.Z)^2)/cam.CFrame.Position.Y)
		local phi = math.acos(cam.CFrame.Position.Y / radius)
		
		local hRadius = math.sqrt(radius^2 - cam.CFrame.Position.Y^2)
	
		
		
		if inputService:IsKeyDown(Enum.KeyCode.A) then
			cam.CFrame = CFrame.lookAt(Vector3.new(hRadius * math.cos(theta + step), cam.CFrame.Position.Y, hRadius * math.sin(theta + step)), zero)
		elseif inputService:IsKeyDown(Enum.KeyCode.D) then
			cam.CFrame = CFrame.lookAt(Vector3.new(hRadius * math.cos(theta - step), cam.CFrame.Position.Y, hRadius * math.sin(theta - step)), zero)
		elseif inputService:IsKeyDown(Enum.KeyCode.W) then
			local startVector = Vector3.new(radius  * math.cos(theta) * math.sin(phi - step), radius * math.cos(phi - step), radius * math.sin(theta) * math.sin(phi - step))
	
			cam.CFrame = CFrame.lookAt(startVector, zero)--radius * math.cos(phi + step), 50), zero)
			--print(phi)
			--print(radius * math.cos(phi + step))
		elseif inputService:IsKeyDown(Enum.KeyCode.S) then
			local startVector = Vector3.new(radius  * math.cos(theta) * math.sin(phi + step), radius * math.cos(phi + step), radius * math.sin(theta) * math.sin(phi + step))
		
			cam.CFrame = CFrame.lookAt(startVector, zero)--radius * math.cos(phi + step), 50), zero)
		end
	end

end)

local function press()
	if(inputService:IsKeyDown(Enum.KeyCode.E)) then
		print("HII")
		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = CFrame.lookAt(pos1, origin)
		introEnded = true
		
		blur.Size = 0
		
		GuiManager.endIntro(player)
		
		connection1:Disconnect()
		
	end
	
	
end


connection1 = inputService.InputBegan:Connect(press)



--- workspace.Cam is the location of the camera brick, your camera will be facing the front surface of the brick

--local mouse = player:GetMouse()
--local remote = game.ReplicatedStorage.clickEvent


--local function click()
--	remote:FireServer(mouse.Hit.p)
--end

--mouse.Button1Down:Connect(click)

