
local max = math.max

local function sumChildDimensions(self)
	if not self.children or self.children.maxn == 0 then
		return 0, 0
	end

	local isColumn, isRow = self:is(gui.Column), self:is(gui.Row)
	if isRow then  isColumn = false  end

	local childCount, sumW, sumH = 0, 0, 0
	for i=1,self.children.maxn do
		local child = self.children[i]
		if child then
			childCount = childCount + 1
			local req = child:request()

			if isRow then  sumW = sumW + req.w
			else  sumW = max(sumW, req.w)  end

			if isColumn then  sumH = sumH + req.h
			else  sumH = max(sumH, req.h)  end
		end
	end

	if self.spacing then
		local spacingSpace = self.spacing * (childCount - 1)
		if isRow then
			sumW = sumW + spacingSpace
		elseif isColumn then
			sumH = sumH + spacingSpace
		end
	end

	return sumW, sumH
end

local function shrinkwrap(self, w, h, designW, designH, scale)
	local sumW, sumH = sumChildDimensions(self)
	return sumW/self._request.w, sumH/self._request.h
end

gui.Node._scaleFuncs.shrinkwrap = shrinkwrap
