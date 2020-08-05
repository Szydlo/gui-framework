Window = inherit(Element)

function Window:constructor(pos, size, color)
	self:init(pos, size, color)
	self.movable =	true

	self.moveWindow = false
	self.lastPos = getRealCursorPosition()
	self.cursorPos = Vector2(0,0)

	self.elements = {}

	self.cursormov = bind(Window.cursorMove, self)
	addEventHandler("onClientCursorMove", root, self.cursormov)
end

function Window:click()
	if self.movable then
		self.lastPos = getRealCursorPosition()
		self.lastpos = self.pos

		for i,v in pairs(self.elements) do
			v.lastpos = v.pos
		end
	end
end

function Window:addChild(element)
	element:drawElement(false)
	table.insert(self.elements, element)
	return element
end

function Window:cursorMove(_, _, x, y)
	if isMouseInPosition(self.pos, self.size) and getKeyState("mouse1") then
		local delta = Vector2(x - self.lastPos.x, y - self.lastPos.y)
		self.pos = self.lastpos + delta

		for i,v in pairs(self.elements) do v.pos = v.lastpos + delta end
	end
end

function Window:draw()
	dxDrawRectangle(self.pos, self.size, self.color)

	for i,v in pairs(self.elements) do v:draw() end
end