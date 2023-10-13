
local triangleClass = require(game:GetService("ServerScriptService").triangleObject)

local tweenService = game:GetService("TweenService")

local fogScreen = workspace:WaitForChild("FogScreen")

local size = 210
local res = 100
local freq = 1
local amp = 25

local ta = nil

local tb = nil


local function getHeight(x, z)
	local noiseHeight = math.noise(
		x / res * freq,
		z / res * freq
	)

	noiseHeight = math.clamp(noiseHeight, -0.5, 0.5) + 0.5
	return noiseHeight
end

local function triangulate(a, b, c)

	local ta
	local tb

	ta, tb = require(game:GetService("ServerScriptService").triangleCreation)(a.Position, b.Position, c.Position, workspace, ta, tb)
	print("Ran")
end

local increment = 30

local allCols = {}

local lower = 0
local upper = size

for x = 0, size, increment do
	local col = {}
	table.insert(allCols, col)
	for z = 0, size, increment do
		local part = Instance.new("Part")
		part.Shape = "Ball"
		part.Parent = fogScreen
		part.Anchored = true
		part.Size = Vector3.new(.1, .1, .1)

		local height = getHeight(x, z)

		part.Position = Vector3.new(x, height * amp, z)
		part.Color = Color3.new(height, height, height)
		
		table.insert(col, part)
		
		if(x > lower) then
			if(z == lower) then
				print(allCols[x/increment- lower + 1 - 1][z/increment - lower + 1 + 1])
				local triangle = triangleClass.new(col[z/increment - lower + 1], allCols[x/increment - lower + 1 - 1][z/increment - lower + 1], allCols[x/increment- lower + 1 - 1][z/increment - lower + 1 + 1], ta, tb)
			elseif(z == upper) then
				
				local triangle = triangleClass.new(col[z/increment - lower + 1], col[z/increment - lower + 1 - 1], allCols[x/increment - lower + 1 - 1][z/increment - lower + 1], ta, tb)

			else

				local triangle = triangleClass.new(col[z/increment - lower + 1], allCols[x/increment - lower + 1 - 1][z/increment - lower + 1], allCols[x/increment - lower + 1 - 1][z/increment - lower + 1 + 1], ta, tb)

				local triangle = triangleClass.new(col[z/increment - lower + 1], col[z/increment - lower + 1 - 1], allCols[x/increment - lower + 1 - 1][z/increment - lower + 1], ta, tb)


			end

			game:GetService("RunService").Heartbeat:Wait()

		end
		
	end


end


local pixels = fogScreen:GetChildren()

local speed = 20

local random = 0

local waitTime 

while true do

	random = random + 1

	for i = 1, #pixels do
		
		local tweenPart = pixels[i]
		
		local tweenY = getHeight(tweenPart.Position.X - random, tweenPart.Position.Z - random) * amp
		
		local heightDiff = math.abs(tweenY - tweenPart.Position.Y)
		
		local info = TweenInfo.new(
			heightDiff/speed, 
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.In,
			0,
			false,
			0
		)

		local tweenGoals = {
			Position = Vector3.new(tweenPart.Position.X, tweenY, tweenPart.Position.Z)
		}

		local tween = tweenService:Create(tweenPart, info, tweenGoals)

		tween:Play()
		waitTime = heightDiff/speed
	end
	wait(waitTime)
end
