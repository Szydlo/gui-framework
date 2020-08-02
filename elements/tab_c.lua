Tab = {}
Tabpanel = inherit(Element)

function Tab:constructor(name)
	self.name = name
	self.elements = {}
end

function Tab:addElement(element)
	element:drawElement(false)
	table.insert(self.elements, element)
end

function Tabpanel:constructor(pos, size, color, hoverColor)
	self:init(pos, size, color)
	self.tabs = {}
	self.selectedTab = ""
	self.tabHeight = 40
end

function Tabpanel:addTab(name)
	local tab = new(Tab, name)
	self.tabs[#self.tabs+1] = tab
	return tab
end

function Tabpanel:setSelectedTab(tab)
	for i,v in pairs(self.tabs) do
		if v == tab then self.selectedTab = v.name end
	end
end

function Tabpanel:click()
	for i,v in pairs(self.tabs) do
		if isMouseInPosition(Vector2(self.pos.x + (i * 150) - 150, self.pos.y), Vector2(150, self.tabHeight)) then
			self.selectedTab = v.name
		end 
	end
end

function Tabpanel:draw()
	dxDrawRectangle(self.pos.x, self.pos.y + self.tabHeight, self.size.x, self.size.y, self.color)

	for i,v in pairs(self.tabs) do 
		local pos = Vector2(self.pos.x + (i * 150) - 150, self.pos.y)
		local color = isMouseInPosition(pos, Vector2(150, self.tabHeight)) and tocolor(64,64,64) or self.color

		dxDrawRectangle(pos, 150, self.tabHeight, color)
		dxDrawText(v.name, pos, pos + Vector2(150, self.tabHeight), tocolor(255,255,255), 1.3, 1.3, "default", "center", "center")

		if v.name == self.selectedTab then
			for j, k in pairs(v.elements) do 
				k:draw()
			end 
		end
	end
end

--[[
tab = new(Tabpanel, Vector2(300, 300), Vector2(600, 400), tocolor(32,32,32), tocolor(64,64,64))
aaa = tab:addTab("new tab")
	aaa:addElement(new(Input, "xddd", Vector2(300, 50), Vector2(50, 50), tocolor(32,32,32), tocolor(55,55,55), tocolor(255,255,255), tocolor(255,0,0), 128, 5))
bbb = tab:addTab("new tab2")

tab:setSelectedTab(aaa)]]