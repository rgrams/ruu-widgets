
local theme = require "theme.theme"

local ResizeHandle = gui.Slice:extend()

function ResizeHandle.drag(self, dx, dy, isLocal)
	if dx and dy then
		local wx, wy = self._to_world.x + dx, self._to_world.y + dy
		dx, dy = self:toLocal(wx, wy)
		if not self.target then
			return
		end
		local target = self.target
		if target:is(gui.Node) then
			if self.dirX ~= 0 then
				local width = math.max(self.minSize, self.target.w + dx * self.dirX)
				self.target:size(width)
				self.target.parent:allocateChild(self.target)
			end
			if self.dirY ~= 0 then
				local height = math.max(self.minSize, self.target.h + dy * self.dirY)
				self.target:size(nil, height)
				self.target.parent:allocateChild(self.target)
			end
			target.parent:allocateChildren()
		end
	end
end

function ResizeHandle.init(self)
	ResizeHandle.super.init(self)
	if type(self.target) == "string" then
		self.target = scene:get(self.target)
	end
end

local HOVER_CURSORS = { -- [y][x]
	[-1] = { [-1] = "sizenwse", [0] = "sizens", [1] = "sizenesw" },
	[0]  = { [-1] = "sizewe",   [0] = "arrow",  [1] = "sizewe" },
	[1]  = { [-1] = "sizenesw", [0] = "sizens", [1] = "sizenwse" }
}

function ResizeHandle.set(self, x, y, angle, w, h, pivot, anchor, modeX, modeY, target, dir, minSize, layers)
	ResizeHandle.super.set(self, theme.tex.ResizeHandle_Normal, nil, {2}, x, y, angle, w, h, pivot, anchor, modeX, modeY)
	local handle = gui.Sprite(theme.tex.ResizeHandleHandle, 0, 0, 0, 1, 2)
	self.children = { handle }
	self.name = "ResizeHandle"
	self.layer = layers and layers.panelBG or "panel backgrounds"
	self.isDraggable = true
	self.target = scene:get(target) or target
	self.minSize = math.max(1, minSize or 20)
	if not dir then
		self.dirX, self.dirY = 1, 0
	elseif type(dir) == "table" then
		self.dirX, self.dirY = dir[1], dir[2]
	else
		self.dirX, self.dirY = dir, 0
	end
	self.hoverCursor = HOVER_CURSORS[self.dirY][self.dirX]
end

return ResizeHandle
