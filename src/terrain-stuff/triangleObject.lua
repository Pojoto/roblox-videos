
local triangleObject = {}


function triangleObject.new(p1, p2, p3, wa, wb)

	local ta = wa
	local tb = wb

	local point1 = p1
	local point2 = p2
	local point3 = p3


	local newTriangle = {}
	setmetatable(newTriangle, triangleObject)

	ta, tb = require(script.Parent.triangleCreation)(point1.Position, point2.Position, point3.Position, workspace, ta, tb)

	point1.Changed:Connect(function()
		ta, tb = require(script.Parent.triangleCreation)(point1.Position, point2.Position, point3.Position, workspace, ta, tb)

	end)
	point2.Changed:Connect(function()

		ta, tb = require(script.Parent.triangleCreation)(point1.Position, point2.Position, point3.Position, workspace, ta, tb)
	end)
	point3.Changed:Connect(function()
		ta, tb = require(script.Parent.triangleCreation)(point1.Position, point2.Position, point3.Position, workspace, ta, tb)
	end)

	return newTriangle
end




return triangleObject
