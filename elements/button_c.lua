Button = inherit(Element)

function Button:constructor(text, pos, size, style)
	self:init(pos, size, style)
	self.text = text

	self.font = self.style.buttonFont
end

function Button:draw()
	self.style:button(self.pos, self.size, isMouseInPosition(self.pos, self.size))
	dxDrawText(self.text, self.pos, self.pos + self.size, self.style.textColor, self.textScale, self.textScale, self.font, "center", "center")
end

function Button:click()
	self:onClick()
end