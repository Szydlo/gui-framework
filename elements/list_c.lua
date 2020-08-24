List = inherit(Element)

function List:constructor(pos, size, style, rowHeight)
	self:init(pos, size, style)

	self.rt = dxCreateRenderTarget(self.size, true)
	self.rowsHeight, self.schrollCache, self.hoveredRow, self.selectedRow = 0,0,-1,-1
	self.rowHeight, self.barSize = rowHeight, 10
	self.margines = 0
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
	if isMouseInPosition(self.pos, self.size) and self.rowsHeight > self.size.y then
		if key == "mouse_wheel_up" then
			self.schrollCache = math.max(self.schrollCache - self.rowHeight, 0)
		elseif key == "mouse_wheel_down" then
			self.schrollCache = math.min(self.schrollCache + self.rowHeight, self.rowsHeight - 500)
		end
	end
end

function List:draw()
	self.style:list(self.pos, self.size)
	dxSetRenderTarget(self.rt, true)

	for i,v in pairs(self.rows) do 
		local offset = (-self.rowHeight + (self.rowHeight + self.margines) * i) - self.margines
		local color

		if isMouseInPosition(Vector2(self.pos.x, self.pos.y + offset - self.schrollCache), Vector2(self.size.x-self.barSize, self.rowHeight)) then
			color = false 
			self.hoveredRow = i
		else 
			if self.hoveredRow == i then 
				self.hoveredRow = -1
			end
			color = i % 2
		end

		self.style:row(Vector2(0, offset - self.schrollCache), Vector2(self.size.x, self.rowHeight), color)
		dxDrawText(v, 0, offset - self.schrollCache, self.size.x, self.rowHeight + offset - self.schrollCache, self.textColor, self.textScale, self.textScale, self.font, "center", "center")
	end

	dxSetRenderTarget()
	dxDrawImage(self.pos, self.size.x - (self.rowsHeight > self.size.y and self.barSize or 0), self.size.y, self.rt, 0,0,0, tocolor(255,255,255), true)

	if self.rowsHeight > self.size.y then
		local ratio = self.size.y / self.rowsHeight
		local size = self.size.y * ratio
		local scrolly = ratio * self.schrollCache

		local pos, size = Vector2(self.pos.x + self.size.x - self.barSize, self.pos.y + scrolly), Vector2(self.barSize, size)
		self.style:bar(pos, size, isMouseInPosition(pos, size))

		local realpos = getRealCursorPosition()

		if isMouseInPosition(pos, size) and getKeyState("mouse1") then 
			isScrollActive = not isScrollActive and realpos.y - scrolly + 5 or isScrollActive 
		elseif not getKeyState("mouse1") then 
			isScrollActive = nil 
		end
								
		self.schrollCache = isScrollActive and math.min(math.max((realpos.y - isScrollActive ) / ratio, 0), self.rowsHeight - 500)	or self.schrollCache		
	end
end