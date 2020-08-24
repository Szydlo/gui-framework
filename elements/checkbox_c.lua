Checkbox = inherit(Element)

function Checkbox:constructor(text, pos, size, style)
	self:init(pos, size, style)

	self.text = text
	self.textColor = textColor
	self.isChecked = false
end

function Checkbox:click()
	self.isChecked = not self.isChecked
end

function Checkbox:draw()
	self.style:checkbox(self.pos, self.size, self.isChecked)
	dxDrawText(self.text, self.pos.x + self.size.y + 2, self.pos.y, self.pos+self.size, self.textColor, self.textScale, self.textScale, self.font, "left", "center")
end