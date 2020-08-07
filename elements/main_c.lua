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
local sx,sy = guiGetScreenSize()
local baseX = 1920
local zoom = 1 
local minZoom = 2
if sx < baseX then zoom = math.min(minZoom, baseX/sx) end 
local fonts = {}

function Font(font, size)
	if not fonts.font then fonts.font = {} end
	fonts.font[size] = dxCreateFont("assets/fonts/"..font..".ttf", size)
	return fonts.font[size]
end

Element = {}

function Element:scale()
	self.pos = Vector2(self.pos.x/zoom, self.pos.y/zoom)
	self.size = Vector2(self.size.x/zoom, self.size.y/zoom)
end

function Element:init(pos, size)
	self.pos, self.size, self.pressed, self.font, self.textScale, self.isScalable = pos, size, false, "default", 1, config.scale

	if self.isScalable then self:scale() end

	elementsToDraw[self] = self
	elementsToDraw[self].canDraw = true
end

function Element:drawElement(drawe)
	elementsToDraw[self].canDraw = drawe
end

function Element:setPos(pos)
	self.pos = pos
	if self.isScalable then self:scale() end
end

function Element:setSize(size)
	self.size = size
	if self.isScalable then self:scale() end
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

-- @ TODO/FIXME  ANIMACJE / SLIDER / GOLDMASTER WERSJA