List = inherit(Element)

-- @ TODO/FIXME DODAĆ PRZESUWANIE SCROLLA KURSORSEM / POZMIENIAĆ WSZYSTKO NA ZMIENNE / PRZEROBIĆ ROWY NA OSOBNĄ KLASE

function List:constructor(pos, size, color, hoverColor, textColor)
	self:initl("", pos, size, color, hoverColor, textColor)

	self.rt = dxCreateRenderTarget(self.size, true)
	self.rowsHeight = 0
	self.rows = {}
	self.schrollCache = 0
	self.hoveredRow = 0
end

function List:addRow(text)
	table.insert(self.rows, text)
	self.rowsHeight = #self.rows * 55
end

function List:clear()
	self.rows = {}
end

function List:click()
	outputChatBox(self.hoveredRow)
end

function List:key(key, press)
	if key == "mouse_wheel_up" then
		self.schrollCache = math.max(self.schrollCache - 55, 0)
	elseif key == "mouse_wheel_down" then
		self.schrollCache = math.min(self.schrollCache + 55, self.rowsHeight - 500)
	end
end

function List:draw()
	dxDrawRectangle(self.pos, self.size, self.color)
	dxSetRenderTarget(self.rt, true)

	for i,v in pairs(self.rows) do 
		local color
		if isMouseInPosition(Vector2(self.pos.x, self.pos.y + -55 + (55 * i) - self.schrollCache), Vector2(self.size.x, 55)) then
			color = 255 
			self.hoveredRow = i
		else 
			color = i % 2 == 0 and 32 or 64
		end

		dxDrawRectangle(0, -55 + (55 * i) - self.schrollCache, self.size.x, 55, tocolor(color, 0, 0))
		dxDrawText(v, 0, -55 + (55 * i) - self.schrollCache, self.size.x, 55 + -55 + (55 * i) - self.schrollCache, self.textColor, 1.5, 1.5, "default", "center", "center")
	end

	dxSetRenderTarget()
	dxDrawImage(self.pos, self.size.x - 15, self.size.y, self.rt)

	if self.rowsHeight > self.size.y then
		local ratio = self.size.y / self.rowsHeight
		local size = self.size.y * ratio
		local scrolly = ratio * self.schrollCache

		dxDrawRectangle(self.pos.x + self.size.x - 15, self.pos.y + scrolly, 15, size, tocolor(0,64,0))
	end
end

list = new(List, Vector2(500, 500), Vector2(300, 500), tocolor(32,32,32), tocolor(64,64,64), tocolor(255,255,255))
list:addRow("halo"..1)
list:addRow("halo"..2)
list:addRow("halo"..3)
list:addRow("halo"..4)
list:addRow("halo"..5)
list:addRow("halo"..6)
list:addRow("halo"..7)
list:addRow("halo"..8)
list:addRow("halo"..9)
list:addRow("halo"..10)
list:addRow("halo"..11)
list:addRow("halo"..12)
list:addRow("halo"..13)
list:addRow("halo"..14)
list:addRow("halo"..15)
list:addRow("halo"..16)