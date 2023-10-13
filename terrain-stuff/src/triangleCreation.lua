local Triangle do
	local v3 = Vector3.new
	local cf = CFrame.new
	local abs = math.abs
	local cross = v3().Cross
	local dot = v3().Dot
	local clone = game.Clone
	
	local point1, point2, point3

	local ref = Instance.new('WedgePart') do
		ref.BrickColor    = BrickColor.new("Deep blue") --Color3.fromRGB(200, 200, 200)
		ref.Material      = Enum.Material.SmoothPlastic
		ref.Reflectance   = 0
		ref.Transparency  = 0
		ref.Name          = ''
		ref.Anchored      = true
		ref.CanCollide    = false
		ref.CFrame        = cf()
		ref.Size          = v3(0.25, 0.25, 0.25)
		ref.BottomSurface = Enum.SurfaceType.Smooth
		ref.TopSurface    = Enum.SurfaceType.Smooth
	end

	local function fromAxes(p, x, y, z)
		return cf(
			p.x, p.y, p.z,
			x.x, y.x, z.x,
			x.y, y.y, z.y,
			x.z, y.z, z.z
		)
	end

	function Triangle(a, b, c, parent, wb, wc)
		local ab, ac, bc = b - a, c - a, c - b
		local abl, acl, bcl = ab.magnitude, ac.magnitude, bc.magnitude
		if abl > bcl and abl > acl then
			c, a = a, c
		elseif acl > bcl and acl > abl then
			a, b = b, a
		end
		ab, ac, bc = b - a, c - a, c - b
		local out = cross(ac, ab).unit
		wb = wb or clone(ref)
		wc = wc or clone(ref)
		local biDir = cross(bc, out).unit
		local biLen = abs(dot(ab, biDir))
		local norm = bc.magnitude
		wb.Size = v3(0, abs(dot(ab, bc))/norm, biLen)
		wc.Size = v3(0, biLen, abs(dot(ac, bc))/norm)
		bc = -bc.unit
		wb.CFrame = fromAxes((a + b)/2, -out, bc, -biDir)
		wc.CFrame = fromAxes((a + c)/2, -out, biDir, bc)
		wb.Parent = parent
		--wb.Color = Color3.new()
		wc.Parent = parent
		return wb, wc
	end
end

return Triangle