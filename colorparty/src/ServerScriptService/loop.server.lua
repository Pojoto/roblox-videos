
local map

local lobby

local intermissionTime = 5

local gameModes = {}
-- 4 player ctf; game where you need to steal stuff from the middle or other groups; paintball color infection;
--splatoon type game; microbattles; color parkour where stepping on a platform changes it to your color and you
--can only go on your color?
local function intermission()
	
	wait(intermissionTime)
end

local function ctf()
	
	local players = game:GetService("Players"):GetPlayers()
	local numPlayers = #players
	local red = {}
	local green = {}
	local blue = {}
	local yellow = {}
	local teams = {red, green, blue, yellow}
	
	for count = 1, #players do--index, value in ipairs(players) do
		local x = 1
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
				x += 1
			end
		end
	end
	
end


--make it so that players can dedicate themselves to one color, and then theyll automatically be put into queue for that 
--color everytime it is in the gamemode. they can switch color dedication, or not have one at all and manually have to 
--choose everytime. or dont even choose and get randomly assigned. there will be awards for players who reach a certain 
--number of wins with a specific color. the more of those awards you get the cooler you can appear and also maybe an 
--easier way of leveling up, sort of like prestige?
local function intialize()
	--choose gamemode
	--choose map? most likely make it random
	--assign color teams
	--spawn players
	--
end


while true do
	if(#game:GetService("Players"):GetPlayers() >= 4) then
		intermission()
		intialize()
		
	end
	wait()
end