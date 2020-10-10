Checkbox = inherit(Element)

function Checkbox:constructor(text, pos, size, style)
	self:init(pos, size, style)

	self.margines = 10
	self.text = text
	self.textColor = textColor
	self.isChecked = false

	self.font = self.style.checkboxFont
end

function Checkbox:click()
	self.isChecked = not self.isChecked
end

function Checkbox:deClick()
	if isMouseInPosition(self.pos, Vector2(dxGetTextWidth(self.text, self.textScale, self.font), self.size.y)) then
		self.isChecked = not self.isChecked
	end
end

function Checkbox:draw()
	self.style:checkbox(self.pos, self.size, self.isChecked)
	dxDrawText(self.text, self.pos.x + self.size.y + self.margines, self.pos.y, self.pos+self.size, self.textColor, self.textScale, self.textScale, self.font, "left", "center")
end