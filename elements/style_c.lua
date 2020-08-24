styles = {}
Style = {}

function Style:constructor()
	self.textColor = tocolor(240,240,240)
	self.carretColor = tocolor(230,230,230)

	self.textures = {
		selected = "assets/selected.png",
		clear = "assets/clear.png"
	}
end
function Style:button(pos, size, hovered) 
	dxDrawRectangle(pos, size, hovered and tocolor(255,255,255) or tocolor(32,32,32))
end

function Style:input(pos, size)
	dxDrawRectangle(pos, size, tocolor(32,32,32))
end

function Style:list(pos, size)
	dxDrawRectangle(pos, size, tocolor(32,32,32, 140), true)
end

function Style:row(pos, size, color)
	if color then color = color == 0 and tocolor(32,32,32) or tocolor(64,64,64) else color = tocolor(0,0,0) end

	dxDrawRectangle(pos, size, color) 
end

function Style:checkbox(pos, size, hovered)
	dxDrawImage(pos, size.y, size.y, hovered and self.textures.selected or self.textures.clear, 0,0,0, tocolor(255,255,255))
end

function Style:combobox(pos, size)
	dxDrawRectangle(pos, size, tocolor(32,32,32))
end

function Style:bar(pos, size, hovered)
	dxDrawRectangle(pos, size, hovered and tocolor(0,0,0) or tocolor(32,32,32), true)
end

function Style:proggesbg(pos, size)
	dxDrawRectangle(pos, size, tocolor(32,32,32))
end

function Style:proggesfill(pos, size)
	dxDrawRectangle(pos, size, tocolor(64,64,64))
end

function Style:window(pos, size)
	dxDrawRectangle(pos, size, tocolor(32,32,32))
end

Login = inherit(Style)

function Login:window(pos, size)
	dxDrawImage(pos, size, "assets/background.jpg")
end

function Login:input(pos, size, hovered)
	dxDrawRectangle(pos, size, tocolor(32,32,32))
end

styles.normal = new(Style)
styles.login = new(Login)