Proggesbar = inherit(Element)

function Proggesbar:constructor(pos, size, bgcolor, color, max, amount)
	self:init(pos, size, color)
	self.bgcolor, self.max, self.amount = bgcolor, max, amount
end

function Proggesbar:draw()
	dxDrawRectangle(self.pos, self.size, self.bgcolor)
	dxDrawRectangle(self.pos, self.size.x * (self.amount / self.max), self.size.y, self.color)
end