local selectedWindow = false
Window = inherit(Element)

function Window:constructor(pos, size, style)
	self:init(pos, size, style)
	self.movable =	true

	self.isMovable = false
	self.lastPos = getRealCursorPosition()
	self.cursorPos = Vector2(0,0)

	self.elements = {}

	self.cursormov = bind(Window.cursorMove, self)
	addEventHandler("onClientCursorMove", root, self.cursormov)
end

function Window:click()
	if self.movable then
		if not selectedWindow then selectedWindow = self.identity end

		self.lastPos = getRealCursorPosition()
		self.lastpos = self.pos

		for i,v in pairs(self.elements) do
			v.lastpos = v.pos
		end
	end
end

function Window:addChild(element)
	element:drawElement(false)
	element.parent = self.identity
	table.insert(self.elements, element)
	return element
end

function Window:cursorMove(_, _, x, y)
	if isMouseInPosition(self.pos, self.size) and getKeyState("mouse1") and self.isMovable and selectedWindow == self.identity then
		local delta = Vector2(x - self.lastPos.x, y - self.lastPos.y)
		self.pos = self.lastpos + delta

		for i,v in pairs(self.elements) do v.pos = v.lastpos + delta end
	elseif selectedWindow == self.identity then
		selectedWindow = false
	end
end

function Window:draw()
	self.style:window(self.pos, self.size)

	for i,v in pairs(self.elements) do v:draw() end
end