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

Element = {}

function Element:init(pos, size, color)
	self.pos, self.size, self.color = pos, size, color

	elementsToDraw[self] = self
end

function Element:initl(text, pos, size, color, hoverColor, textColor)
	self:init(pos, size, color)
	self.text, self.hoverColor, self.textColor, self.actualColor = text, hoverColor, textColor, color
end

function Element:destroy()
	elementsToDraw[self] = nil
	self = nil
end