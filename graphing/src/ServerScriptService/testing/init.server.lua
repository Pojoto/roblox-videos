

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
local yVal = 0
--print(#points)

local function triangulate(a, b, c)
	
	local ta
	local tb

	ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
	print("Ran")
end

local function graph(x, z)
	--local y = (5*sqrtle((x^2 / 30) - (z / 11))) -- dont use
	--local y = (5*sqrt())
	local y = (x^2)/6 + (z^2)/5   -- paraboloid    --math.sqrt(z - x^2)
	--local y = math.sqrt(3) * math.sqrt(1 - (z^2/9) - (x^2/4)) --ellipsoid
	--local y = (1/3) * ((z^2 / 9) - (x^2 / 4)) -- hyperbolic paraboloid
	--local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 3) - 1) -- hyperboloid of one sheet
	--local y = 3 * math.sqrt((z^2 / 5) + (x^2 / 4)) --elliptic cone
	return y
end


local function graphh()
	local count = 0 --variable that is incremented through each point creation - variable that contains total number of points

	local lower = -10 
	local upper = 10

	local allCols = {} --this table will contain more tables - it serves to house all the column tables so we can jump across them

	for x = lower, upper do --this loop can be thought of as the rows of columns - every time x goes up, we move to the next column
		local col = {} --create a new column table to store the following points
		table.insert(allCols, col) --insert this column into the table of all the columns
		for z = lower, upper do --loop through the individual points in a column - every time z goes up we move to the next point in the column
			local o2 = o:Clone()
			local yVal = graph(x, z)
			o2.Position = Vector3.new(x, yVal, z)
			o2.Parent = game.Workspace


			table.insert(col, o2)


			count += 1
			o2.Name = "Part" .. tostring(count)

			if(x > lower) then --this ensures we start at the second column - we essentially skip the first column because the triangles are essentially creaetd backwards
				if(z == lower) then
					triangulate(col[z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1 + 1])


				elseif(z == upper) then
					triangulate(col[z - lower + 1], col[z - lower + 1 - 1], allCols[x - lower + 1 - 1][z - lower + 1])

				else
					triangulate(col[z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1 + 1])

					triangulate(col[z - lower + 1], col[z - lower + 1 - 1], allCols[x - lower + 1 - 1][z - lower + 1])



				end



			end


		end
		local index = 0
	end
end


local function paraboloid()

end


local count = 0 --variable that is incremented through each point creation - variable that contains total number of points

local lower = -10 
local upper = 10

local allCols = {} --this table will contain more tables - it serves to house all the column tables so we can jump across them

for x = lower, upper do --this loop can be thought of as the rows of columns - every time x goes up, we move to the next column
	local col = {} --create a new column table to store the following points
	table.insert(allCols, col) --insert this column into the table of all the columns
	for z = lower, upper do --loop through the individual points in a column - every time z goes up we move to the next point in the column
		local o2 = o:Clone()
		local yVal = graph(x, z)
		o2.Position = Vector3.new(x, yVal, z)
		o2.Parent = game.Workspace


			table.insert(col, o2)


		count += 1
		o2.Name = "Part" .. tostring(count)

		if(x > lower) then --this ensures we start at the second column - we essentially skip the first column because the triangles are essentially creaetd backwards
			if(z == lower) then
				triangulate(col[z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1 + 1])


			elseif(z == upper) then
				triangulate(col[z - lower + 1], col[z - lower + 1 - 1], allCols[x - lower + 1 - 1][z - lower + 1])

			else
				triangulate(col[z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1], allCols[x - lower + 1 - 1][z - lower + 1 + 1])

				triangulate(col[z - lower + 1], col[z - lower + 1 - 1], allCols[x - lower + 1 - 1][z - lower + 1])



			end



		end


	end
	local index = 0
	for z2 = upper, lower, -1 do
		--x - lower + 1
		--if(allCols[x - lower + 1][z2 + upper  + lower  - lower + 1] ) then
			
		--end
		local o2 = o:Clone()
		local yVal = graph(x, z2)
		o2.Position = Vector3.new(x, -yVal, z2)
		o2.Parent = game.Workspace

		--if(yVal ~= yVal) then
		--table.insert(points, nil)
		--else
		--table.insert(points, o2)
		--end
		--if(yVal == yVal) then
			table.insert(col, o2)
		--end
		index += 1
		count += 1
		
		o2.Name = "Part" .. tostring(count)
		--print(o2)
		--print(o2.Position)
		--print(tostring(x) .. tostring(z))
		if(x > lower) then
			--if(z2 == lower) then
			--	print(col[z2 + upper  + lower  - lower + 1], allCols[x - lower + 1 - 1][z2 + upper  + lower  - lower + 1], allCols[x - lower + 1 - 1][z2 + upper  + lower  - lower + 1 + 1])
			--	triangulate(col[z2 + upper  + lower  - lower + 1], allCols[x - lower + 1 - 1][z2 + upper  + lower  - lower + 1], allCols[x - lower + 1 - 1][z2 + upper  + lower  - lower + 1 + 1])
			--	--local a = col[z - lower + 1]
			--	--local b = allCols[x - lower + 1 - 1][z - lower + 1]
			--	--local c = allCols[x - lower + 1 - 1][z - lower + 1 + 1]
			--	--local ta
			--	--local tb
			--	print("WE DID IT!!!")
			--	--ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)

			--elseif(z2 == upper) then
			--	triangulate(col[z2 + upper  + lower  - lower + 1], col[z2 + upper  + lower  - lower + 1 - 1], allCols[x - lower + 1 - 1][z2 + upper  + lower  - lower + 1])
			--	--local a = col[z - lower + 1]
			--	--local b = col[z - lower + 1 - 1]
			--	--local c = allCols[x - lower + 1 - 1][z - lower + 1]

			--	--local ta
			--	--local tb

			--	--ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)

			--	--a = points[count]
			--	--b = 
			--else
				
			print(col[index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower) + 1])
				triangulate(col[index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower)], allCols[x - lower + 1 - 1][index + (upper  - lower) + 1])
				--local a = col[z - lower + 1]
				--local b = allCols[x - lower + 1 - 1][z - lower + 1]
				--local c = allCols[x - lower + 1 - 1][z - lower + 1 + 1]
				--local ta
				--local tb

				--ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
				triangulate(col[index + (upper  - lower)], col[index + (upper  - lower) - 1], allCols[x - lower + 1 - 1][index + (upper  - lower)])
				--local a = col[z - lower + 1]
				--local b = col[z - lower + 1 - 1]
				--local c = allCols[x - lower + 1 - 1][z - lower + 1]

				--local ta
				--local tb

				--ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)


			--end



		end

	end

end


o.Color = Color3.new(0, 0, 0)

print(#game.Workspace:GetChildren())

triangulate(game.Workspace.Part535, game.Workspace.Part534, game.Workspace.Part493)


for count = 1, #allCols[10] do
	print(allCols[10][count])
	print(allCols[9][count])
	print(allCols[10][count - 1])
	print("")
end

