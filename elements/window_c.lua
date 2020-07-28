Window = inherit(Element)

-- @ TODO/FIXME NAPRAWIĆ PRZESUWANIE

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

--wn = new(Window, Vector2(0, 0), Vector2(300, 300), tocolor(32,32,32))

showCursor(true)

--[[
Window = inherit(Element)
--KURWA NIE DZIALA PRZESUWANIE
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
		self.pressed = true
	end
end

function Window:outClick()
	if self.movable then
		self.pressed = false
	end
end

function Window:draw()
	outputChatBox(self.pos.x)

if getKeyState("mouse1") and isMouseInPosition(self.pos - self.cursorPos, self.size) then

	if self.pressed then
		local realpos = getRealCursorPosition()
		self.cursorPos = self.lastPos - realpos
	end

	dxDrawRectangle(self.pos - self.cursorPos, self.size, self.color)
end

wn = new(Window, Vector2(0, 0), Vector2(300, 300), tocolor(32,32,32))

showCursor(true)

]]