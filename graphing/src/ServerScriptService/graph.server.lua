

local origin = Vector3.new(0,0,0)
local o = Instance.new("Part")
o.Parent = game.Workspace
o.Size = Vector3.new(0.1,0.1,0.1)
o.Shape = "Ball"
o.Position = origin
o.Anchored = true
o.Color = Color3.new(1, 0, 0)
o.CanCollide = false
local points = {}
print(#points)

local function sqrtle(x)
	
	local temp = math.sqrt(x)
	
	if(temp == temp) then
		return temp
	end
	
	return -math.sqrt(x / -1)
	
end

local function graph(x, z)
	--local y = (5*sqrtle((x^2 / 30) - (z / 11)))
	--local y = (5*sqrt())
	--local y = (x^2)/6 + (z^2)/5--math.sqrt(z - x^2)
	--local y = 3 * sqrtle(1 - (z^2/25) - (x^2/14))
	local y = .5 * ((z^2 / 3) - (x^2 / 2))
	return y
end

local function triangle(a, b, c)
	
end


local count = 0

local lower = -10
local upper = 10

local cols = {}
local col = {}

for x = lower, upper do
	for z = lower, upper do
		local o2 = o:Clone()
		local yVal = graph(x, z)
		o2.Position = Vector3.new(x, yVal, z)
		o2.Parent = game.Workspace
	
		--if(yVal ~= yVal) then
			--table.insert(points, nil)
		--else
			table.insert(points, o2)
		--end

		count += 1
		o2.Name = "Part" .. tostring(count)
		print(o2)
		print(o2.Position)
		print(tostring(x) .. tostring(z))
		if(x > lower) then
			if(z == lower) then
				local a = points[count]
				local b = points[count - (upper - lower + 1)]
				local c = points[count - (upper - lower)]
				local ta
				local tb
		
				ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
				
			elseif(z == upper) then
				local a = points[count]
				local b = points[count - 1]
				local c = points[count - (upper - lower + 1)]

				local ta
				local tb

				ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
				
				--a = points[count]
				--b = 
			else
				
				local a = points[count]
				local b = points[count - (upper - lower + 1)]
				local c = points[count - (upper - lower)]
				local ta
				local tb

				ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
				
				local a = points[count]
				local b = points[count - 1]
				local c = points[count - (upper - lower + 1)]

				local ta
				local tb

				ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
				

			end
			
			

		end
		
		--if(yVal ~= yVal) then
		--	if(z - 1 % 2 == 0) then
		--		local a = points[count - 1]
		--		local b = points[count - (upper - lower + 1)]
		--		local cc = (z - 1) - (z)
		--		repeat 
					
					
		--		until 

		--		local ta
		--		local tb

		--		ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
		--	end
		--end
	end

end


o.Color = Color3.new(0, 0, 0)

print(#game.Workspace:GetChildren())

print(points[143].Position)

---13.863, -34.3055, 50.869
--9.374, 6.678