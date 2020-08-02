Proggesbar = inherit(Element)

function Proggesbar:constructor(pos, size, bgcolor, color, max, amount)
	self:init(pos, size, color)
	self.bgcolor, self.max, self.amount = bgcolor, max, amount
end

function Proggesbar:draw()
	dxDrawRectangle(self.pos, self.size, self.bgcolor)
	dxDrawRectangle(self.pos, self.size.x * (self.amount / self.max), self.size.y, self.color)
end

--progg = new(Proggesbar, Vector2(500, 500), Vector2(500, 50), tocolor(32,32,32), tocolor(255,0,0), 255, 122)