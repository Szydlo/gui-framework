Combobox = inherit(Element)

function Combobox:constructor(pos, size, color)
	self:init(pos, size, color)
	self.basicHeight = 40
	self.selectedRow = ""

	self.rowVisible = false

	self.list = new(List, Vector2(self.pos.x, self.pos.y + self.basicHeight), Vector2(self.size.x, self.size.y - self.basicHeight), self.color, tocolor(64,64,64), tocolor(255,255,255), 40)
	self.list:drawElement(false)
end

function Combobox:addRow(value)
	self.list:addRow(value)
end

function Combobox:click()
	if isMouseInPosition(self.pos, Vector2(self.size.x, self.basicHeight)) then
		self.rowVisible = not self.rowVisible
		self.list:drawElement(self.rowVisible)
	end

	self.list.onSelect = function()
		self.list:drawElement(false)
		self.rowVisible = false
		self.selectedRow = self.list.selectedRow
	end
end

function Combobox:deClick()
	self.list:drawElement(false)
	self.rowVisible = false
end

function Combobox:clear()
	self.list:clear()
	self.selectedRow = ""
end

function Combobox:draw()
	local size = Vector2(self.size.x, self.basicHeight)
	local color = isMouseInPosition(self.pos, size) and tocolor(64,64,64) or self.color

	dxDrawRectangle(self.pos, size, color)
	dxDrawText("▼", self.pos, self.pos.x-5 + size.x, self.pos.y + size.y, tocolor(255,255,255), 1.2, 1.2, "default", "right", "center")	
	dxDrawText(self.selectedRow, self.pos, self.pos + size, tocolor(255,255,255), 1.2, 1.2, "default", "center", "center")
end