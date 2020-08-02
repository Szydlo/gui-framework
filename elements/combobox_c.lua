Combobox = inherit(Element)

function Combobox:constructor(pos, size, color)
	self:init(pos, size, color)
	self.basicHeight = 40
	self.selectedRow = ""
	self.rows = {} -- jeszcze nie wiem jakim sposobem to zrobić, moge po prostu użyć tutaj gridlisty i tyle
end

function Combobox:draw()
	local size = Vector2(self.size.x, self.basicHeight)
	local color = isMouseInPosition(self.pos, size) and tocolor(64,64,64) or self.color

	dxDrawRectangle(self.pos, size, color)
	dxDrawText("▼", self.pos.x, self.pos.y, self.pos.x + size.x - 5, self.pos.x + size.y, tocolor(255,255,255), 1.2, 1.2, "default", "right", "center")	
	dxDrawText(self.rows[self.selectedRow] or "", self.pos, self.pos + size, tocolor(255,255,255), 1.2, 1.2, "default", "center", "center")
end

combo = new(Combobox, Vector2(400, 400), Vector2(200, 300), tocolor(32,32,32))