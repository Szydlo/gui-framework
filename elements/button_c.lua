Button = inherit(Element)

function Button:constructor(text, pos, size, style)
	self.style = style
	self:initl(text, pos, size, _, _, _)
end

function Button:draw()
	self.style:button(self.pos, self.size, isMouseInPosition(self.pos, self.size))
	dxDrawText(self.text, self.pos, self.pos + self.size, self.style.textColor, self.textScale, self.textScale, self.font, "center", "center")
end

function Button:click()
	self:onClick()
end

butt = new(Button, "ZALOGUJ SIĘ", Vector2(500, 500), Vector2(300, 50), styles.modern)
butt.font = Font("cocogothic", 25)

showCursor(true)