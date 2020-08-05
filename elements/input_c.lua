Input = inherit(Element)

function Input:constructor(placeholder, pos, size, style, maxLines, maxCharacters)
	self:initl("", pos, size, color, hoverColor, textColor)
	self.placeholder = placeholder
	self.carretVisible = false

	self.style = style

	self.tableText = {}
	self.tableText[1] = placeholder

	self.carretPosition = 0
	self.carretLine = 1
	self.backspaceTick = 0

	self.maxCharacters, self.maxLines = maxCharacters or 128, maxLines or 1

	_, self.carretSize = dxGetTextSize("|", 0, self.textScale, self.textScale, self.font)

	self.ekey = bind(Input.keye, self)
	self.echaracter = bind(Input.character, self)
end

function Input:calculateMaxCharacters()
	local maxc = 0
	for i,v in pairs(self.tableText) do maxc = maxc + #v end
	return maxc
end

function Input:addText(text)
	local temp = self.tableText[self.carretLine]..text
	if self:calculateMaxCharacters() == self.maxCharacters then return end

	if dxGetTextWidth(temp, self.textScale, self.font) >= self.size.x then
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
		if #self.tableText[self.carretLine] == 0 then
			self.tableText[self.carretLine] = nil
		elseif #self.tableText > 1 and self.carretLine > 1 then
			outputChatBox("Xd")
			self.tableText[self.carretLine-1] = utf8.sub(self.tableText[self.carretLine-1], 1, -2)
			self.tableText[self.carretLine-1] = self.tableText[self.carretLine-1]..utf8.sub(self.tableText[self.carretLine], 1, 1)
			self.tableText[self.carretLine] = utf8.sub(self.tableText[self.carretLine], 2)
		end

		self.carretLine = self.carretLine - 1
		self.carretPosition = #self.tableText[self.carretLine]

		local temp = self.tableText 
		self.tableText = {}

		local j = 0
		for i,v in pairs(temp) do
			j = j+1
			self.tableText[j] = v
		end
	else
		self.tableText[self.carretLine] = utf8.sub(self.tableText[self.carretLine], 1, math.max(0, self.carretPosition-1))..utf8.sub(self.tableText[self.carretLine], self.carretPosition+1)
        self.carretPosition = math.max(0, self.carretPosition-1)
	end
end

function Input:newLine()
	if #self.tableText == self.maxLines then return end

	local temp = ""

	if self.carretPosition < #self.tableText[self.carretLine] then
		temp = utf8.sub(self.tableText[self.carretLine], self.carretPosition+1, #self.tableText[self.carretLine])
		self.tableText[self.carretLine] = utf8.sub(self.tableText[self.carretLine], 1, self.carretPosition)  
	end

	table.insert(self.tableText, self.carretLine+1, temp)
	self.carretLine = self.carretLine + 1
	self.carretPosition = 0
end

function Input:draw()
	self.style:input(self.pos, self.size)

	for i,v in pairs(self.tableText) do
		dxDrawText(v, Vector2(self.pos.x, self.pos.y + (self.carretSize * i)-self.carretSize), self.pos + self.size, self.textColor, self.textScale, self.textScale, self.font)
	end

	if self.carretVisible then
    	local textWidth = dxGetTextWidth(utf8.sub(self.tableText[self.carretLine], 1, self.carretPosition), 2)
		dxDrawRectangle(Vector2(self.pos.x+textWidth, self.pos.y+1.5  + (self.carretSize * self.carretLine)-self.carretSize), Vector2(0.8, self.carretSize), self.style.carretColor)

		if getKeyState("backspace") then
			local now = getTickCount()

			if now > self.backspaceTick then
				self:removeCharacter()
				self.backspaceTick = now+150
			end
		end
	end

	self.actualColor = isMouseInPosition(self.pos, self.size) and self.hoverColor or self.color
end

function Input:click()
	if not self.carretVisible then
		addEventHandler("onClientKey", root, self.ekey)
		addEventHandler("onClientCharacter", root, self.echaracter)
		self.carretVisible = true

		if self.tableText[1] == self.placeholder then
			self.tableText[1] = ""
		end
	end

	local string = ""
	for i,v in pairs(self.tableText) do string = string..v.."\n" end

	local realpos = getRealCursorPosition()
	local x, y = dxGetTextSize(string, 0, self.textScale, self.textScale, self.font)

	for i=0, math.floor(self.size.y/self.carretSize) do
		if (i*self.carretSize) > (realpos.y - self.pos.y) then
			if self.tableText[i] then
				self.carretLine = i 

				for i=0, #self.tableText[i] do 
					local textw = dxGetTextWidth(utf8.sub(self.tableText[self.carretLine], 1, i), self.textScale, self.font)
				
					if (realpos.x - self.pos.x) < textw then
						self.carretPosition = i
						return
					end
				end
				return 
			end

			self.carretLine = #self.tableText
			self.carretPosition = #self.tableText[self.carretLine]
		end
	end
end

function Input:deClick()
	if self.carretVisible then
		self.carretVisible = false
		removeEventHandler("onClientKey", root, self.ekey)
		removeEventHandler("onClientCharacter", root, self.echaracter)

		if self.tableText[1] == "" and #self.tableText < 2 then
			self.tableText[1] = self.placeholder
		end
	end
end

function Input:keye(button, press)
	if press then
		if button == "enter" then
			self:newLine()
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