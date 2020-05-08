Window = inherit(Element)

function Window:constructor(pos, size, color)
	self:init(pos, size, color)
	self.movable =	true

	self.moveWindow = false
	self.lastPos = getRealCursorPosition()
	self.cursorPos = Vector2(0,0)
end

function Window:click()
	if self.movable then
		self.lastPos = getRealCursorPosition()
	end
end

function Window:draw()
	if getKeyState("mouse1") and isMouseInPosition(self.pos - self.cursorPos, self.size) then
		local realpos = getRealCursorPosition()
		self.cursorPos = self.lastPos - realpos
	end

	dxDrawRectangle(self.pos - self.cursorPos, self.size, self.color)
end

showCursor(true)