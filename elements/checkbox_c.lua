Checkbox = inherit(Element)

function Checkbox:constructor(text, pos, size, color, textColor)
	self:init(pos, size, color)

	self.text = text
	self.textColor = textColor
	self.isChecked = false
	self.textures = {
		selected = "assets/selected.png",
		clear = "assets/clear.png"
	}
end

function Checkbox:click()
	self.isChecked = not self.isChecked
end

function Checkbox:draw()
	dxDrawImage(self.pos, self.size.y, self.size.y, self.isChecked and self.textures.selected or self.textures.clear, 0,0,0, self.color)
	dxDrawText(self.text, self.pos.x + self.size.y + 2, self.pos.y, self.pos+self.size, self.textColor, self.textScale, self.textScale, self.font, "left", "center")
end