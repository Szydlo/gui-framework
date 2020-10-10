--start community
--https://wiki.multitheftauto.com/wiki/IsMouseInPosition
function isMouseInPosition(pos, size)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= pos.x and cx <= pos.x + size.x ) and ( cy >= pos.y and cy <= pos.y + size.y ) )
end

-- Modified version for DX Text
function isCursorOverText(pos, size)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)

	return ( (cX >= pos.x and cX <= pos.x+(size.x - pos.x)) and (cY >= pos.y and cY <= pos.y+(size.y - pos.y)) )
end

function getRealCursorPosition()
	local xy = Vector2(getCursorPosition())
	local wh = Vector2(guiGetScreenSize())

	return xy * wh
end 
--end community
local sx,sy = guiGetScreenSize()
local baseX = 1920
zoom = 1 
local minZoom = 2
if sx < baseX then zoom = math.min(minZoom, baseX/sx) end 
local fonts = {}

function Font(font, size, bold)
	if not fonts.font then fonts.font = {} end
	fonts.font[size] = dxCreateFont(config.fontPath..font..".ttf", size, bold or false)
	return fonts.font[size]
end

Element = {}

function Element:scale()
	--self.pos = Vector2(self.pos.x/zoom, self.pos.y/zoom)
	self.size = Vector2(self.size.x/zoom, self.size.y/zoom)
end

function Element:init(pos, size, style)
	self.pos, self.size, self.pressed, self.font, self.textScale, self.isScalable, self.style = pos, size, false, "default", 1, config.scale, style

	if self.isScalable then self:scale() end

	local id = #elementsToDraw+1
	elementsToDraw[id] = self
	elementsToDraw[id].canDraw = true
	self.identity = id
end

function Element:drawElement(drawe)
	elementsToDraw[self.identity].canDraw = drawe
end

function Element:moveToTop()
	if self.identity == #elementsToDraw - (self.elements and #self.elements or 0) then return end
	if self.parent then return elementsToDraw[self.parent]:moveToTop() end

	local up = #elementsToDraw
	local canDraw = elementsToDraw[self.identity].canDraw

	elementsToDraw[up].identity = self.identity
	elementsToDraw[self.identity].canDraw = elementsToDraw[up].canDraw
	elementsToDraw[self.identity] = elementsToDraw[up]

	elementsToDraw[up].canDraw = canDraw
	elementsToDraw[up] = self
	self.identity = up
end

function Element:setPos(pos)
	self.pos = pos
	if self.isScalable then self:scale() end
end

function Element:setSize(size)
	self.size = size
	if self.isScalable then self:scale() end
end

function Element:move(_from, _to, _easing, _time)
	animations[self] = {from = _from, to = _to, easing = _easing, time = _time, start = getTickCount()}

	if self.elements then
		for i,v in pairs(self.elements) do 
			v.from = v.pos
		end
	end
end

function Element:destroy()
	if self.elements then
		for i,v in pairs(self.elements) do
			v:destroy()
		end
	end

	elementsToDraw[self.identity] = nil
	self = nil
end

-- @ TODO/FIXME SLIDER / GOLDMASTER WERSJA