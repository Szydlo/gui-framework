styles = {}
Style = {}

function Style:constructor()
	self.textColor = tocolor(240,240,240)
	self.carretColor = tocolor(255,0,0)
end
function Style:button(pos, size, hovered) 
	dxDrawRectangle(pos, size, tocolor(255,255,255))
end

function Style:input(pos, size)
	dxDrawRectangle(pos, size)
end

function Style:row(pos, size) 
end

function Style:window(pos, size)
	dxDrawRectangle(pos, size, tocolor(32,32,32))
end

Modern = inherit(Style)

function Modern:button(pos, size, hovered) 
	dxDrawRectangle(pos.x, pos.y + size.y - 5, size.x, 5, tocolor(255,255,255))
	if not temp then temp = 0 end

	if hovered then
		temp = size.x == temp and size.x or temp+20
		dxDrawRectangle(pos.x, pos.y + size.y - 5, temp, 5, tocolor(255,0,0))
	elseif not hovered and temp > 0 then
		temp = 0 == temp and 0 or temp-20
		dxDrawRectangle(pos.x, pos.y + size.y - 5, temp, 5, tocolor(255,0,0))
	end
end

Rounded = inherit(Style)

function Rounded:button(pos, size, hovered)

end

styles.normal = new(Style)
styles.modern = new(Modern)
styles.rounded = new(Rounded)