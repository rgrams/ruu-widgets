
local ScrollList = gui.Mask:extend()
ScrollList.className = "ScrollList"

ScrollList.scrollSpeed = 5

function ScrollList.allocate(self, ...)
	ScrollList.super.allocate(self, ...)
	if self.updateChildrenBounds then  self:updateChildrenBounds()  end
	if self.scroll then  self:scroll(0, 0)  end
end

function ScrollList.allocateChildren(self, ...)
	ScrollList.super.allocateChildren(self, ...)
end

function ScrollList.init(self)
	ScrollList.super.init(self)
	self.ruu:makeScrollArea(self, true, ox, oy, self.scrollSpeed, nudgeDist)
end

function ScrollList.set(self, ruu, spacing)
	ScrollList.super.set(self, nil, 0, 0, 0, 100, 100, "C", "C", "fill")
	self.name = self.className
	self.contents = gui.Column(spacing, false, -1, 0, 0, 0, 100, 100, "N", "N", "fill", "shrinkwrap")
	self.children = { self.contents }
	self.ruu = ruu
end

return ScrollList
