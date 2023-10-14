local a = workspace.A
local b = workspace.B
local c = workspace.C

local ta
local tb

local function update()
	ta, tb = require(script.Triangle)(a.Position, b.Position, c.Position, workspace, ta, tb)
end

a.Changed:Connect(update)
b.Changed:Connect(update)
c.Changed:Connect(update)

update()