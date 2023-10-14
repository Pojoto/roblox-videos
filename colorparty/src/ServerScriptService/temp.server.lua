local function ctf2()


	local players = game.Workspace.Players:GetChildren()
	local numPlayers = #players
	local teams = table.create(teamNumber, {})
	local t = 1
	for count = 1, numPlayers do
		local random = math.random(1, #players)
		local player = players[random]
		table.insert(teams[t], player)
		table.remove(players, table.find(players, player))
		t = (t + 1) % teamNumber
		if(t == 0) then
			t += 1
		end
		if(count == math.floor(numPlayers / teamNumber) * teamNumber) then
			distribute(teams, players)
			count = numPlayers
		end
	end
	--local red = {}
	--local green = {}
	--local blue = {}
	--local yellow = {}
	--local teams = {red, green, blue, yellow}

	for count = 1, #players do--index, value in ipairs(players) do
		local x = math.random(1, teamNumber)
		local random = math.random(1, #players)
		local player = players[random]
		if(#teams[1] < math.floor(numPlayers / teamNumber)) then
			--local player = players[random]
			table.insert(red, player)
			table.remove(players, table.find(players, player))
		elseif(#teams[2] < math.floor(numPlayers / teamNumber)) then
			--local player = players[random]
			table.insert(green, player)
			table.remove(players, table.find(players, player))	
		elseif(#teams[3] < math.floor(numPlayers / teamNumber)) then
			--local player = players[random]
			table.insert(blue, player)
			table.remove(players, table.find(players, player))				

		elseif(#teams[4] < math.floor(numPlayers / teamNumber)) then
			--local player = players[random]
			table.insert(yellow, player)
			table.remove(players, table.find(players, player))			
		else
			while(#players > 0) do
				table.insert(teams[x], player)
				table.remove(players, table.find(players, player))
				x = ((x + 1) % 5)
				if(x == 0) then
					x += 1
				end
			end
		end
	end


	local num = game.Workspace.Players:GetChildren()
	for index, value in ipairs(teams) do
		if(value == red) then
			color = "Really red"
		elseif(value == green) then
			color = "Dark green"
		elseif(value == blue) then
			color = "Dark blue"
		elseif(value == yellow) then
			color = "New Yeller"
		end
		for count = 1, #value do
			value[count].BrickColor = BrickColor.new(color)
			wait(2 / #num)
		end
	end

end

ctf2()







local function ctf()

	local players = game.Workspace.Players:GetChildren()
	local numPlayers = #players
	local red = {}
	local green = {}
	local blue = {}
	local yellow = {}
	local teams = {red, green, blue, yellow}

	for count = 1, #players do--index, value in ipairs(players) do
		local x = math.random(1, 4)
		local random = math.random(1, #players)
		local player = players[random]
		if(#teams[1] < math.floor(numPlayers / 4)) then
			--local player = players[random]
			table.insert(red, player)
			table.remove(players, table.find(players, player))
		elseif(#teams[2] < math.floor(numPlayers / 4)) then
			--local player = players[random]
			table.insert(green, player)
			table.remove(players, table.find(players, player))	
		elseif(#teams[3] < math.floor(numPlayers / 4)) then
			--local player = players[random]
			table.insert(blue, player)
			table.remove(players, table.find(players, player))				

		elseif(#teams[4] < math.floor(numPlayers / 4)) then
			--local player = players[random]
			table.insert(yellow, player)
			table.remove(players, table.find(players, player))			
		else
			while(#players > 0) do
				table.insert(teams[x], player)
				table.remove(players, table.find(players, player))
				x = ((x + 1) % 5)
				if(x == 0) then
					x += 1
				end
			end
		end
	end


	local num = game.Workspace.Players:GetChildren()
	for index, value in ipairs(teams) do
		if(value == red) then
			color = "Really red"
		elseif(value == green) then
			color = "Dark green"
		elseif(value == blue) then
			color = "Dark blue"
		elseif(value == yellow) then
			color = "New Yeller"
		end
		for count = 1, #value do
			value[count].BrickColor = BrickColor.new(color)
			wait(2 / #num)
		end
	end

end

--ctf()

local function ctf()
	local userInputtedNumTeams = 0
	local players = game.Workspace.Players:GetChildren()
	local numPlayers = #players


	local teams = table.create(userInputNum, {})

	local t = 1
	for count = 1, numPlayers do
		local random = math.random(1, #players)
		local player = players[random]
		table.insert(teams[t], player)
		print(teams[t])
		print(t)
		table.remove(players, table.find(players, player))
		t = (t + 1) % 5
		if(t == 0) then
			t += 1
		end
		if(count == math.floor(numPlayers / 4) * 4) then
			distribute(teams, players)
			print("wwwi")
			print(numPlayers)
			print(count)
			count = numPlayers
		end
	end
	print(teams)
	print(teams[1])
	print(teams[2])
	print(teams[3])
	print(teams[4])
	local num = game.Workspace.Players:GetChildren()
	for index, value in ipairs(teams) do

		for count = 1, #value do
			value[count].BrickColor = BrickColor.new(colors[index])
			wait(2 / #num)
		end
	end

end

ctf()





		table.insert(teams[t], player)
		print(teams[t])
		print(t)
		table.remove(players, table.find(players, player))
		t = (t + 1) % 5
		if(t == 0) then
			t += 1
		end
		if(count == math.floor(numPlayers / 4) * 4) then
			distribute(teams, players)
			print("wwwi")
			print(numPlayers)
			print(count)
			count = numPlayers
		end
	end
	print(teams)
	print(teams[1])
	print(teams[2])
	print(teams[3])
	print(teams[4])
	local num = game.Workspace.Players:GetChildren()
	for index, value in ipairs(teams) do

		for count = 1, #value do
			value[count].BrickColor = BrickColor.new(colors[index])
			wait(2 / #num)
		end
	end

end