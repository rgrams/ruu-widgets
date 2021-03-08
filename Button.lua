
local Button = gui.Slice:extend()

local w, h = 170, 50
local labelAlign = "center"

function Button.set(self, ruu, text, fn, layers)
	local theme = ruu.theme
	Button.super.set(self, theme.tex.Button_Normal, nil, {5, 6})
	self:size(w, h)
	self:mode("fill", "none")
	local label = gui.Text(text, theme.fnt.default, 0, -1, 0, w, "C", "C", labelAlign, "fill")
	self.label = label
	self.children = { label }
	self.name = "Button"
	self.layer = layers and layers.widgets or "widgets"
	label.layer = layers and layers.text or "text"

	self.ruu = ruu
	self.ruu:makeButton(self, true, fn)
end

return Button
