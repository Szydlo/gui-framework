Label = inherit(Element)

function Label:constructor(text, pos, size, color)
	self.text = text
	self.color = color
	self:init(pos, size, styles.normal)
end

function Label:draw()
	dxDrawText(self.text, self.pos, self.size, self.color, self.textScale, self.textScale, self.font, self.alignl, self.alignt)
end