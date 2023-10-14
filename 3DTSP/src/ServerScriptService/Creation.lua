local Creation = {}

function Creation.makePoint(bounds)

	local point = Instance.new("Part")
	point.Shape = "Ball"
	point.Size = Vector3.new(2, 2, 2)
	local randX = math.random(0, bounds.X)
	local randY = math.random(0, bounds.Y)
	local randZ = math.random(0, bounds.Z)
	point.Position = Vector3.new(randX, randY, randZ)
	point.Anchored = true

	return point

end


function Creation.makePath(point1, point2, color)

	local cf = CFrame.new(point1.Position, point2.Position)

	local distance = (point1.Position - point2.Position).Magnitude

	local path = Instance.new("Part")
	path.CFrame = cf
	path.Size = Vector3.new(.1, .1, 1)
	color = color or Color3.new(0, 0, 0)
	path.Color = color
	path:Resize(Enum.NormalId.Front, distance)
	path.Anchored = true

	return path

end

return Creation
