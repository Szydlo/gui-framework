Input = inherit(Element)

-- @ TODO/FIXME USUWANIE BACKSPACE Z ZNAKAMI / KOPIOWANIE TEKSTU / WYKRYWANIE POZYCJI MYSZKI I WSTAWIANIE TAM CARRET / ZROBIĆ USUWANIE NA TICKI
-- @ TODO/FIXME DODAĆ MAXCHARACTERS / ZMIENIĆ EVENTY NA AUTENTYCZNY KEY

function Input:constructor(placeholder, pos, size, color, hoverColor, textColor, carretColor, maxLines, maxCharacters)
	self:initl("", pos, size, color, hoverColor, textColor)
	self.placeholder, self.carretColor = placeholder, carretColor
	self.carretVisible = false

	self.tableText = {}
	self.tableText[1] = ""

	self.carretPosition = 0
	self.carretLine = 1
	self.textSize = 2

	self.maxCharacters, self.maxLines = maxCharacters or 128, maxLines or 1

	_, self.carretSize = dxGetTextSize("|", 0, self.textSize, self.textSize, "defualt")

	self.ekey = bind(Input.key, self)
	self.echaracter = bind(Input.character, self)
end

function Input:addText(text)
	local temp = self.tableText[self.carretLine]..text

	if dxGetTextWidth(temp, self.textSize, "defualt") >= self.size.x then
		self:newLine()
		self.tableText[self.carretLine] = self.tableText[self.carretLine]..text
	else
		self.tableText[self.carretLine] = self.tableText[self.carretLine]..text
	end

	self.carretPosition = self.carretPosition + 1
end

function Input:removeCharacter()
	if self.carretPosition == 0 and self.carretLine == 1 then return end

	if self.carretPosition == 0 then
		self.carretLine = self.carretLine - 1
		self.carretPosition = #self.tableText[self.carretLine]
	else
		self.tableText[self.carretLine] = utf8.sub(self.tableText[self.carretLine], 1, math.max(0, self.carretPosition-1))..utf8.sub(self.tableText[self.carretLine], self.carretPosition+1)
        self.carretPosition = math.max(0, self.carretPosition-1)
	end
end

function Input:newLine()
	if #self.tableText == self.maxLines then return end

	self.carretLine = self.carretLine + 1
	self.tableText[self.carretLine] = ""
	self.carretPosition = 0
end

function Input:draw()
	dxDrawRectangle(self.pos, self.size, self.actualColor)

	for i,v in pairs(self.tableText) do
		dxDrawText(v, Vector2(self.pos.x, self.pos.y + (self.carretSize * i)-self.carretSize), self.pos + self.size, self.textColor, self.textSize, self.textSize)
	end

	if self.carretVisible then
    	local textWidth = dxGetTextWidth(utf8.sub(self.tableText[self.carretLine], 1, self.carretPosition), 2)
		dxDrawRectangle(Vector2(self.pos.x+textWidth, self.pos.y+1.5  + (self.carretSize * self.carretLine)-self.carretSize), Vector2(0.8, self.carretSize), self.carretColor)
	end

	self.actualColor = isMouseInPosition(self.pos, self.size) and self.hoverColor or self.color
end

function Input:click()
	self.carretVisible = not self.carretVisible

	_G[not self.carretVisible and "removeEventHandler" or "addEventHandler"]("onClientKey", root, self.ekey)
	_G[not self.carretVisible and "removeEventHandler" or "addEventHandler"]("onClientCharacter", root, self.echaracter)
end

function Input:deClick()
	if self.carretVisible then
		self.carretVisible = false
		removeEventHandler("onClientKey", root, self.ekey)
		removeEventHandler("onClientCharacter", root, self.echaracter)
	end
end

function Input:key(button, press)
	if press then
		if button == "enter" then
			self:newLine()
		elseif button == "backspace" then
			self:removeCharacter()
		elseif button == "arrow_l" then
			if self.carretPosition == 0 and self.carretLine > 1 then
				self.carretLine = self.carretLine - 1
				self.carretPosition = #self.tableText[self.carretLine]
				return
			end

			self.carretPosition = math.max(0, self.carretPosition - 1)
		elseif button == "arrow_r" then
			if self.carretPosition == #self.tableText[self.carretLine] and self.tableText[self.carretLine+1] then
				self.carretPosition = 0
				self.carretLine = self.carretLine + 1
			end

			self.carretPosition = math.min(self.carretPosition + 1, #self.tableText[self.carretLine])
		elseif button == "arrow_u" then
			if self.carretLine == 1 then return end

			self.carretLine = self.carretLine-1
		elseif button == "arrow_d" then
			if self.carretLine == #self.tableText then return end

			self.carretLine = self.carretLine+1
		end
	end
end

function Input:character(character)
	self:addText(character)
end

--inp = new(Input, "xddd", Vector2(300, 50), Vector2(300, 500), tocolor(32,32,32), tocolor(55,55,55), tocolor(255,255,255), tocolor(255,0,0), 128, 5)
