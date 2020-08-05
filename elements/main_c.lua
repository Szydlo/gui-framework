--start community
--https://wiki.multitheftauto.com/wiki/IsMouseInPosition
function isMouseInPosition (pos, size)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= pos.x and cx <= pos.x + size.x ) and ( cy >= pos.y and cy <= pos.y + size.y ) )
end

-- Modified version for DX Text
function isCursorOverText(posX, posY, sizeX, sizeY)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)

	return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end

function getRealCursorPosition()
	local xy = Vector2(getCursorPosition())
	local wh = Vector2(guiGetScreenSize())

	return xy * wh
end 
--end community
local fonts = {}

function Font(font, size)
	if not fonts.font then fonts.font = {} end
	fonts.font[size] = dxCreateFont("assets/fonts/"..font..".ttf", size)
	return fonts.font[size]
end

Element = {}

function Element:init(pos, size)
	self.pos, self.size, self.pressed, self.font, self.textScale = pos, size, false, "default", 1

	elementsToDraw[self] = self
	elementsToDraw[self].canDraw = true
end

function Element:drawElement(drawe)
	elementsToDraw[self].canDraw = drawe
end

function Element:initl(text, pos, size)
	self:init(pos, size, color)
	self.text = text
end

function Element:destroy()
	if self.elements then
		for i,v in pairs(self.elements) do
			v:destroy()
		end
	end

	elementsToDraw[self] = nil
	self = nil
end

-- @ TODO/FIXME SKALOWANIE / ANIMACJE / SLIDER / GOLDMASTER WERSJA