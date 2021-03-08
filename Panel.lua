
local theme = require "theme.theme"

local Panel = gui.Slice:extend()
Panel.className = "Panel"

function Panel.set(self, ruu, w, h, layers)
	Panel.super.set(self,
		theme.tex.Panel, nil, {2}, 0, 0, 0, w, h, pivot, anchor, modeX, modeY
	)
	self.color[1], self.color[2], self.color[3] = 0.75, 0.75, 0.75
	self.name = self.className
	self.layer = layers and layers.panel or "panel"
	self.ruu = ruu
	self.ruu:makePanel(self, true)
end

return Panel
