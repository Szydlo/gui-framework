Proggesbar = inherit(Element)

function Proggesbar:constructor(pos, size, style, max, amount)
	self:init(pos, size, style)
	self.bgcolor, self.max, self.amount = bgcolor, max, amount
end

function Proggesbar:draw()
	self.style:proggesbg(self.pos, self.size)
	self.style:proggesfill(self.pos, self.size.x * (self.amount / self.max), self.size.y)
end