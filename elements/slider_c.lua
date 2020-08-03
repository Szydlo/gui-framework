Slider = inherit(Element)

function Slider:constructor(pos, size, color, max, amount)
	self:init(pos, size, color)
	self.max, self.amount = max, amount
	self.dotPos = Vector2(self.pos.x, self.pos.y-2)
end

function Slider:draw()
	local color = isMouseInPosition(self.dotPos, Vector2(10,10)) and tocolor(64,64,64) or tocolor(255,0,0)

	dxDrawRectangle(self.pos, self.size, self.color)
	dxDrawRectangle(self.dotPos, Vector2(10, 10), color)

	if isMouseInPosition(self.dotPos, Vector2(10,10)) and getKeyState("mouse1") then
		local realpos = getRealCursorPosition()
		--e nie chce mi się
	end
end

slid = new(Slider, Vector2(500, 500), Vector2(400, 7), tocolor(32,32,32), 255, 100)