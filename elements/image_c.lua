Image = inherit(Element)

function Image:constructor(image, pos, size, color)
	self.image = image
	self:init(pos, size, color)
end

function Image:draw()
	dxDrawImage(self.pos, self.size, self.image, 0,0,0, self.color)
end