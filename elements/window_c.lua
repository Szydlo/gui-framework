Window = inherit(Element)

function Window:constructor(pos, size, color, elements)
	self:init(pos, size, color)
	self.movable =	true

	self.moveWindow = false
	self.lastPos = getRealCursorPosition()
	self.cursorPos = Vector2(0,0)

	self.cursormov = bind(Window.cursorMove, self)
	addEventHandler("onClientCursorMove", root, self.cursormov)

	if elements then
		for i,v in pairs(elements) do
			v:drawElement(false)
		end
	end 
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

		for i,v in pairs(elements) do
			v.pos = v.pos + delta
		end
	end
end

function Window:draw()
	dxDrawRectangle(self.pos, self.size, self.color)

	if elements then
		for i,v in pairs(elements) do
			elements:draw()
		end
	end
end