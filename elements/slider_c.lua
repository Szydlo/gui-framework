Slider = inherit(Element)

function Slider:constructor(pos, size, style, max, amount)
	self:init(pos, size, style)
	self.max, self.amount = max, amount
	self.dotPos = Vector2(self.pos.x+1, self.pos.y-2)
end

function Slider:draw()
	local color = isMouseInPosition(self.dotPos, Vector2(10,10)) and tocolor(64,64,64) or tocolor(255,0,0)

	dxDrawRectangle(self.pos, self.size, self.color)
	dxDrawRectangle(self.dotPos, Vector2(10, 10), color)

	local realpos = getRealCursorPosition()

	if isMouseInPosition(self.dotPos, Vector2(10,10)) and getKeyState("mouse1") then
		
	end
end