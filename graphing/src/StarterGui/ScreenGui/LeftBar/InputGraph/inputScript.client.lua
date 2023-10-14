local textBox = script.Parent
local remote = game.ReplicatedStorage.playerText

local player = game.Players.LocalPlayer

local manager = game:GetService("ReplicatedStorage").ExecManager
local GuiManager = require(manager)

local text2


local Xoperators = "(          -+         /*         ^        )"


local operators = "(          -+         /*         ^         qioacte            )"
local trig = "qioacte"
local letters = "abcdefghijklmnopqrstuvwz"
local numbers = "1234567890xy"

local k = 1
local z = 1

local s = "*"

local dictionary = {

	s = 5


}

local function tprint(tab)

	for count = 1, #tab, 1 do
		print("[" .. count .. "]: " .. tab[count])
	end

end

local function search(s, char)

	for i = 1, #s, 1 do
		if(string.sub(s, i, i) == char) then
			return i
		end
	end
	return nil

end


local function correction(char)
	if(char == "(" or char == ")") then
		return "%" .. char
	end
	return char
end



local function loop(text)

	local numStack = {}
	local opStack = {}




	local i = 1

	while(i <= #text) do--for i = 1, #text, 1 do --loops through the string by char

		local tchar = ""

		--print(text)

		print("i start: " .. i)

		local char = string.sub(text, i, i) --variable of the current char
		print(char)




		if(search(numbers, char)) then --check if current char is number, if it is we wanna loop through next cahracteres to see how long the number is
			print("is a number")
			local chunk = char --variable to store final chunk of the whole number


			local j = i + 1 --index of next char

			while(search(numbers, string.sub(text, j, j))) do --checking if the next char is still a number, if it is keep looping (++ index) until we reach end of entire number

				local curr = string.sub(text, j, j)

				chunk = chunk .. curr --add the current number to the chunk. if there are more numbers in the entire integer, then the chunk will keep increasing

				j = j + 1 --increment to next char
			end

			i = i + #chunk - 1 --move the greater loop index past all the numbers we just checked through. 

			table.insert(numStack, chunk)
			--reached end of entire number

		elseif(char == "(" or char == ")") then
			if(char == ")") then --if char is ), then we loop through all the past operators in opStack and add them to numStack

				local count = 0
				local index = #opStack

				while(not(opStack[index] == "(")) do

					table.insert(numStack, opStack[index])
					table.remove(opStack, index)


					count = count + 1
					index = index - 1
				end

				if(count == 0) then
					print("empty")
					table.remove(opStack, #opStack)
				else
					table.remove(opStack, #opStack) --remove the last element, should be the left parentehses (
				end



			else
				table.insert(opStack, char)

				--if(#opStack == 0) then
				--	table.insert(opStack, char)
				--else
				--	if(string.find(operators, opStack[#opStack]) < string.find(operators, char)) then -- if there is another operator in the stack already, check if the new operator has priority or not (ooo), if it doesnt then pop out the last operator and place the new one in. otherwies place new one in normally

				--		table.insert(opStack, char) --since the new operator has prioritiy, we add it to opStack noramlly.

				--	else --the operators must be equal in order or the new one is less - now we must switch
				--		table.insert(numStack, opStack[#opStack]) --insert last operator into the numStack
				--		table.remove(opStack, #opStack) --then pop this operator out of the opstack
				--		table.insert(opStack, char) --now insert the current operator into the opstack
				--	end
				--end
			end
		elseif(search(letters, string.lower(char))) then--string.match(operators, char)) then --since the curerent cahr is not a number, lets check if its an operator
			local chunk = char --variable to store final chunk of the whole number


			local j = i + 1 --index of next char

			print(letters)
			print(string.lower(string.sub(text, j, j)))
			--print(string.find(letters, string.sub(text, j, j)))

			while(search(letters, string.lower(string.sub(text, j, j)))) do--string.find(letters, correction(string.lower(string.sub(text, j, j))))) do --checking if the next char is still a letter, if it is keep looping (++ index) until we reach end of entire number

				local curr = string.sub(text, j, j)

				print("curr: " .. curr)

				chunk = chunk .. curr --add the current number to the chunk. if there are more numbers in the entire integer, then the chunk will keep increasing

				j = j + 1 --increment to next char
			end

			i = i + #chunk - 1 --move the greater loop index past all the numbers we just checked through. 
			print("i: " .. i)
			print(chunk)

			if(chunk == "sqrt") then
				chunk = "q"
			elseif(chunk == "sin") then
				print("I FOUND SINNNNNNNNNNNNNNNNNNNNNNNNN")
				chunk = "i"
			elseif(chunk == "cos") then
				print("I FOUND COSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
				chunk = "o"
			elseif(chunk == "tan") then
				chunk = "a"
			elseif(chunk == "csc") then
				chunk = "c"
			elseif(chunk == "cot") then
				chunk = "t"
			elseif(chunk == "sec") then
				chunk = "e"
			else

				print("invalid operation")

			end





			table.insert(opStack, chunk)





		elseif(search(operators, char)) then --string.find(letters, string.lower(char))) then --since the current cahr is not an operator or number, we'll check if its a letter (it should be)
			print("is an operator")
			if(#opStack == 0) then
				table.insert(opStack, char)
				print(search(operators, opStack[#opStack]))--string.find(operators, correction(opStack[#opStack])))

				print(search(operators, char))--string.find(operators, char))
			else

				--if(string.find(trig, opStack[#opStack])) then

				--end



				--if(string.find(trig, opStack[#opStack]) or string.find(trig, char)) then--check if one of the comparing operators is a trig function because OOP behaves differently with those involved

				--print(string.find(operators, opStack[#opStack]))--correction(opStack[#opStack])))

				print(string.find(operators, char))


				if((search(operators, opStack[#opStack]) < search(operators, char)) and math.abs(search(operators, opStack[#opStack]) - search(operators, char)) > 6) then--string.find(operators, correction(opStack[#opStack])) < string.find(operators, char)) then -- if there is another operator in the stack already, check if the new operator has priority or not (ooo), if it doesnt then pop out the last operator and place the new one in. otherwies place new one in normally

					table.insert(opStack, char) --since the new operator has prioritiy, we add it to opStack noramlly.

				else --the operators must be equal in order or the new one is less - now we must switch
					table.insert(numStack, opStack[#opStack]) --insert last operator into the numStack
					table.remove(opStack, #opStack) --then pop this operator out of the opstack
					table.insert(opStack, char) --now insert the current operator into the opstack
				end
			end
		else --char is not an operator, number, or letter
			print("invalid char")
		end


		tprint(numStack)
		tprint(opStack)
		i = i + 1
	end


	local index = #opStack

	while(not (#opStack == 0))  do --keep looping if the opStack is not empty

		table.insert(numStack, opStack[#opStack])
		table.remove(opStack)--, #opStack)

	end



	tprint(numStack)
	tprint(opStack)

	table.remove(opStack)

	tprint(opStack)

	return numStack

end


local function calculate(stack1)

	local stack = stack1

	local count = 1

	while(count <= #stack) do

		local item = stack[count]

		if(not search(numbers, item)) then
			if(item == "i") then
				local result = math.sin(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "o") then
				local result = math.cos(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "a") then
				local result = math.tan(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "c") then
				local result = 1 / math.sin(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "e") then
				local result = 1 / math.cos(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "t") then
				local result = 1 / math.tan(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "q") then
				local result = math.sqrt(stack[count - 1])
				stack[count - 1] = result
				table.remove(stack, count)
				count = count - 1
			elseif(item == "-") then
				local result = tonumber(stack[count - 2]) - tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "+") then
				local result = tonumber(stack[count - 2]) + tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "/") then
				local result = tonumber(stack[count - 2]) / tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "*") then
				local result = tonumber(stack[count - 2]) * tonumber(stack[count - 1])
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			elseif(item == "^") then
				tprint(stack)
				print(stack[count - 2])
				print(stack[count - 1])
				print(count)
				local result = stack[count - 2]^stack[count - 1]
				print(result)
				stack[count - 2] = result
				table.remove(stack, count)
				table.remove(stack, count - 1)
				count = count - 2
			end
			print(stack)

			--elseif() then

		end

		count = count + 1
	end
	tprint(stack)
end




local function onFocusLost(enterPressed)
	--if enterPressed then
	if(textBox.text ~= "") then
		print("The player typed: " .. textBox.Text)
		-- Color the text box according to the typed color
		--remote:FireServer(textBox.Text)
		
		text2 = tostring(textBox.Text)
		local baseStack = loop(text2)

		print(baseStack)
		tprint(baseStack)

		GuiManager.graph(player, "input", true, baseStack)
		
		---local brickColor = BrickColor.new(textBox.Text)
		--textBox.BackgroundColor3 = brickColor.Color
	end
	--end
end

textBox.FocusLost:Connect(onFocusLost)