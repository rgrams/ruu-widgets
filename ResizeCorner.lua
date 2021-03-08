
local base = (...):match("(.-)ResizeCorner$")
local ResizeHandle = require(base .. "base.ResizeHandle")
local ResizeCorner = ResizeHandle:extend()

local size = 15
local VEC = { SE = {1, 1}, SW = {-1, 1}, NE = {1, -1}, NW = {-1, -1} }

function ResizeCorner.set(self, ruu, dir, target, minSize, layers)
	ResizeCorner.super.set(
		self, 0, 0, 0, size, size, dir, dir, "none", "none",
		target, VEC[dir], minSize or 50, layers
	)
	local handleSprite = self.children[1]
	local angle = (dir == "SE" or dir == "NW") and math.pi/4 or -math.pi/4
	handleSprite.angle = angle
	self.ruu = ruu
	self.ruu:makeButton(self, true, nil, "ResizeHandle")
end

return ResizeCorner
