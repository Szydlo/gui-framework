Window = inherit(Element)

-- @ TODO/FIXME NAPRAWIĆ PRZESUWANIE

function Window:constructor(pos, size, color)
	self:init(pos, size, color)
	self.movable =	true

	self.moveWindow = false
	self.lastPos = getRealCursorPosition()
	self.cursorPos = Vector2(0,0)

	self.cursormov = bind(Window.cursorMove, self)
	addEventHandler("onClientCursorMove", root, self.cursormov)
end

function Window:click()
	if self.movable then
		self.lastPos = getRealCursorPosition()
		self.lastpos = self.pos
	end
end

function Window:cursorMove(_, _, x, y)
	if isMouseInPosition(self.pos, self.size) and getKeyState("mouse1") then
		local delta = Vector2(x - self.lastPos.x, y - self.lastPos.y)
		self.pos = self.lastpos + delta
	end
end

function Window:draw()
	dxDrawRectangle(self.pos, self.size, self.color)
end

wn = new(Window, Vector2(0, 0), Vector2(300, 300), tocolor(32,32,32))

showCursor(true)