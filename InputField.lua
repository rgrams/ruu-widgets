
local theme = require "interface.theme.theme"

local InputField = gui.Slice:extend()

local pivotForTextAlign = { left = "W", center = "C", right = "E", justify = "W" }

function InputField.set(self, ruu, text, confirmFunc, editFunc, isPopup, scrollToRight)
	text = text or ""

	local name     = "InputField"
	local align    = "left"
	local resize   = "fit"
	local w        = 70
	local h        = 24
	local pivot    = pivotForTextAlign[align]
	local layer    = isPopup and "popupWidgets" or "widgets"
	local txtLayer = isPopup and "popupText"    or "text"
	local img      = theme.tex.InputField_Normal

	InputField.super.set(self, img, nil, {3}, 100, 0, 0, w, h, "C", "C", resize) -- , 1, 3)
	self.layer = layer
	self.name = name

	local textObj = mod(gui.Text(text, theme.fnt.default, 0, -1, 0, 1000, pivot, pivot, align, "none"),
		{ layer = txtLayer, name = "Text" }
	)
	local maskObj = mod(gui.Mask(nil, 0, 0, 0, 10, 10, "C", "C", "fill"),
		{ children = { textObj } }
	)
	self.children = { maskObj }

	ruu:makeInputField(self, textObj, maskObj, true, editFunc, confirmFunc, scrollToRight, themeType, theme)
end

return InputField
