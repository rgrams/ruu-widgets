
local base = (...):match("(.-)Splitter$")
local SplitterHandle = require(base .. "base.SplitterHandle")
local Splitter = SplitterHandle:extend()

function Splitter.set(self, ruu, axis, target1, target2, layers)
	assert(axis == "x" or axis == "y", "Splitter() - Invalid `axis`: '"..tostring(axis).."'. Must be 'x' or 'y'.")
	local minSize = 15
	local yAxis = axis == "y"
	local w, h = yAxis and 100 or 10, yAxis and 10 or 100
	local modeX, modeY = yAxis and "fill" or "none", yAxis and "none" or "fill"
	Splitter.super.set(
		self, 0, 0, 0, w, h, nil, nil, modeX, modeY,
		target1, target2, yAxis, minSize, layers
	)
	self.ruu = ruu
	self.ruu:makeButton(self, true, nil, "ResizeHandle")
end

return Splitter
