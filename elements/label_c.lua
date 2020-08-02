Label = inherit(Element)

function Label:constructor(text, pos, size, color)
	self.text = text
	self:init(pos, size, color)
end

function Label:draw()
	dxDrawText(self.text, self.pos, self.size, self.color)
end