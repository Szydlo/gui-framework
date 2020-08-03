Button = inherit(Element)

function Button:constructor(text, pos, size, color, hoverColor, textColor)
	self:initl(text, pos, size, color, hoverColor, textColor)
end

function Button:draw()
	dxDrawRectangle(self.pos, self.size, self.actualColor)
	dxDrawText(self.text, self.pos, self.pos + self.size, self.textColor, 1.4, 1.4, "default", "center", "center")

	self.actualColor = isMouseInPosition(self.pos, self.size) and self.hoverColor or self.color
end

function Button:click()
	self:onClick()
end