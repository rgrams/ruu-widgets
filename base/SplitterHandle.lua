
-- Probably only works with two greedy Row/Column children with "fill" mode.

local theme = require "interface.theme.theme"

local SplitterHandle = gui.Slice:extend()

function SplitterHandle.drag(self, dx, dy, isLocal)
	if dx and dy then
		local wx, wy = self._to_world.x + dx, self._to_world.y + dy
		dx, dy = self:toLocal(wx, wy)
		if not self.target1 then
			return
		end
		local target1 = self.target1
		local target2 = self.target2
		if self.useYAxis then
			local h1, h2 = target1.h + dy, target2.h - dy
			if h1 < self.minSize then
				dy = -(target1.h - self.minSize) -- Shrinking left target, dy is negative.
				h1, h2 = self.minSize, target2.h + dy
			elseif h2 < self.minSize then
				dy = target2.h - self.minSize
				h1, h2 = target1.h - dy, self.minSize
			end
			target1:size(nil, target1.h + dy)
			target2:size(nil, target2.h - dy)
		else
			local w1, w2 = target1.w + dx, target2.w - dx
			if w1 < self.minSize then
				dx = -(target1.w - self.minSize) -- Shrinking left target, dx is negative.
				w1, w2 = self.minSize, target2.w + dx
			elseif w2 < self.minSize then
				dx = target2.w - self.minSize
				w1, w2 = target1.w - dx, self.minSize
			end
			target1:size(target1.w + dx, nil)
			target2:size(target2.w - dx, nil)
		end
		target1.parent:allocateChildren()
	end
end

function SplitterHandle.init(self)
	SplitterHandle.super.init(self)
	if type(self.target1) == "string" then
		self.target1 = scene:get(self.target1)
	end
	if type(self.target2) == "string" then
		self.target2 = scene:get(self.target2)
	end
end

function SplitterHandle.set(self, x, y, angle, w, h, pivot, anchor, modeX, modeY, target1, target2, yAxis, minSize, layers)
	SplitterHandle.super.set(self, theme.tex.ResizeHandle_Normal, nil, {2}, x, y, angle, w, h, pivot, anchor, modeX, modeY)
	self.name = "SplitterHandle"
	self.layer = layers and layers.panelBG or "panel backgrounds"
	self.isDraggable = true
	self.target1 = scene:get(target1) or target1
	self.target2 = scene:get(target2) or target2
	self.useYAxis = yAxis
	self.minSize = math.max(1, minSize or 20)
	self.hoverCursor = self.useYAxis and "sizens" or "sizewe"

	local handleAngle = self.useYAxis and math.pi/2 or 0
	local handle = gui.Sprite(theme.tex.ResizeHandleHandle, 0, 0, handleAngle, 1, 2)
	self.children = { handle }
end

return SplitterHandle
