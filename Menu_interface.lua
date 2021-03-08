
-- An interface intended to be implemented by menu objects.

-- Creates a Ruu instance, focus-maps widgets in a vertical list, acquires input
-- and passes it to Ruu, and handles the menu being enabled and disabled.

local Ruu = require "ruu.ruu"
local theme = require "theme.theme"

local Class = require "philtre.modules.base-class"
local MenuInterface = Class:extend()

function MenuInterface.makeRuu(self)
	self.ruu = Ruu(Input.get, theme)
end

-- Make a list of widgets, focus-map them, etc.
-- Needs to be called on or after init to get the menuSwitcher object.
function MenuInterface.mapWidgets(self, widgetIndices)
	local menuSwitcher = self.parent -- The object that has the menuSwitcher_script on it.
	self.widgetList = {}
	local focusMap = {}
	for _i,childIdx in ipairs(widgetIndices) do
		local child = self.children[childIdx]
		if _i == 1 then  self.focusedWgt = child  end
		child.menuSwitcher = menuSwitcher
		table.insert(self.widgetList, child)
		table.insert(focusMap, {child})
	end
	if self.focusedWgt then  self.ruu:setFocus(self.focusedWgt, true)  end
	self.ruu:mapNeighbors(focusMap)
	Input.enable(self)
end

function MenuInterface.input(self, ...)
	return self.ruu:inputWrapper(hoverActions, ...)
end

function MenuInterface.setEnabled(self, enabled)
	self:setVisible(enabled)
	if not self.rememberLastFocus then  self.focusedWgt = nil  end
	for i,wgt in ipairs(self.widgetList) do
		if not enabled and wgt.isFocused then -- Disabling, remember focused button.
			self.focusedWgt = wgt
		elseif enabled and (not self.focusedWgt or wgt == self.focusedWgt) then -- Enabling, re-focus last focused button (or 1st button by default).
			self.ruu:setFocus(wgt)
			self.focusedWgt = wgt
		end
		self.ruu:setWidgetEnabled(wgt, enabled)
	end
	if enabled then
		Input.enable(self)
	else
		Input.disable(self)
	end
end

return MenuInterface
