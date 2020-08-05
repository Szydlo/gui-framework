styles = {}
Style = {}

function Style:constructor()
	self.textColor = tocolor(240,240,240)
	self.carretColor = tocolor(255,0,0)
end
function Style:button(pos, size, hovered) 
	dxDrawRectangle(pos, size, hovered and tocolor(64,64,64) or tocolor(32,32,32))
end

function Style:input(pos, size)
	dxDrawRectangle(pos, size)
end

function Style:row(pos, size) 
end


Modern = inherit(Style)

function Modern:button(pos, size, hovered) 
	dxDrawRectangle(pos.x, pos.y + size.y - 5, size.x, 5, hovered and tocolor(255,255,255) or tocolor(255,0,0))
end

Rounded = inherit(Style)

function Rounded:button(pos, size, hovered)

end

styles.normal = new(Style)
styles.modern = new(Modern)
styles.rounded = new(Rounded)