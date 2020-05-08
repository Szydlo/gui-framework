Input = inherit(Element)

function Input:constructor(placeholder, pos, size, color, hoverColor, textColor, carretColor)
	self:initl("", pos, size, color, hoverColor, textColor)
	self.placeholder, self.carretColor = placeholder, carretColor
	self.carretVisible = false

	self.ekey = bind(Input.key, self)
	self.echaracter = bind(Input.character, self)
end

function Input:draw()
	dxDrawRectangle(self.pos, self.size, self.actualColor)
	dxDrawText(self.text, self.pos, self.pos + self.size, self.textColor)

	if self.carretVisible then
		dxDrawRectangle(Vector2(self.pos.x, self.pos.y+1.5), Vector2(2, self.size.y-3), self.carretColor)
	end

	self.actualColor = isMouseInPosition(self.pos, self.size) and self.hoverColor or self.color
end

function Input:click()
	self.carretVisible = not self.carretVisible

	_G[not self.carretVisible and "removeEventHandler" or "addEventHandler"]("onClientKey", root, self.ekey)
	_G[not self.carretVisible and "removeEventHandler" or "addEventHandler"]("onClientCharacter", root, self.echaracter)
end

function Input:outClick()
	if self.carretVisible then
		self.carretVisible = false
		removeEventHandler("onClientKey", root, self.ekey)
		removeEventHandler("onClientCharacter", root, self.echaracter)
	end
end

function Input:key(button, press)
end

function Input:character(character)
	self.text = self.text..character
end

inp = new(Input, "xddd", Vector2(300, 50), Vector2(300, 50), tocolor(32,32,32), tocolor(55,55,55), tocolor(255,255,255), tocolor(255,0,0))