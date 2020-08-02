List = inherit(Element)

function List:constructor(pos, size, color, hoverColor, textColor, rowHeight)
	self:initl("", pos, size, color, hoverColor, textColor)

	self.rt = dxCreateRenderTarget(self.size, true)
	self.rowsHeight, self.schrollCache, self.hoveredRow, self.selectedRow = 0,0,-1,-1
	self.rowHeight, self.barSize = rowHeight, 10
	self.rows = {}
end

function List:addRow(text)
	table.insert(self.rows, text)
	self.rowsHeight = #self.rows * self.rowHeight
end

function List:clear()
	self.rows = {}
	self.hoveredRow, self.selectedRow = -1, -1
end

function List:click()
	self.selectedRow = self.hoveredRow ~= -1 and self.rows[self.hoveredRow] or -1

	if self.selectedRow ~= -1 then
		self:onSelect(self.selectedRow)
	end
end

function List:key(key, press)
	if isMouseInPosition(self.pos, self.size) then
		if key == "mouse_wheel_up" then
			self.schrollCache = math.max(self.schrollCache - self.rowHeight, 0)
		elseif key == "mouse_wheel_down" then
			self.schrollCache = math.min(self.schrollCache + self.rowHeight, self.rowsHeight - 500)
		end
	end
end

function List:draw()
	dxDrawRectangle(self.pos, self.size, self.color)
	dxSetRenderTarget(self.rt, true)

	for i,v in pairs(self.rows) do 
		local offset = -self.rowHeight + (self.rowHeight * i)
		local color

		if isMouseInPosition(Vector2(self.pos.x, self.pos.y + offset - self.schrollCache), Vector2(self.size.x-self.barSize, self.rowHeight)) then
			color = 255 
			self.hoveredRow = i
		else 
			if self.hoveredRow == i then 
				self.hoveredRow = -1
			end
			color = i % 2 == 0 and 32 or 64
		end

		dxDrawRectangle(0, offset - self.schrollCache, self.size.x, self.rowHeight, tocolor(color, 0, 0))
		dxDrawText(v, 0, offset - self.schrollCache, self.size.x, self.rowHeight + offset - self.schrollCache, self.textColor, 1.5, 1.5, "default", "center", "center")
	end

	dxSetRenderTarget()
	dxDrawImage(self.pos, self.size.x - self.barSize, self.size.y, self.rt)

	if self.rowsHeight > self.size.y then
		local ratio = self.size.y / self.rowsHeight
		local size = self.size.y * ratio
		local scrolly = ratio * self.schrollCache

		local pos, size = Vector2(self.pos.x + self.size.x - self.barSize, self.pos.y + scrolly), Vector2(self.barSize, size)
		dxDrawRectangle(pos, size, tocolor(0,64,0))

		local realpos = getRealCursorPosition()

		if isMouseInPosition(pos, size) and getKeyState("mouse1") then 
			isScrollActive = not isScrollActive and realpos.y - scrolly + 5 or isScrollActive 
		elseif not getKeyState("mouse1") then 
			isScrollActive = nil 
		end
								
		self.schrollCache = isScrollActive and math.min(math.max((realpos.y - isScrollActive ) / ratio, 0), self.rowsHeight - 500)	or self.schrollCache		
	end
end