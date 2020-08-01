Tab = {}
Tabpanel = inherit(Element)

function Tab:constructor(name)
	self.elements = {}
end

function Tab:addElement(element)
	table.insert(self.elements, element)
end

function Tabpanel:constructor(pos, size)
	self.tabs = {}
	self.selectedTab = ""
end

function Tabpanel:addTab(name)

end

function Tabpanel:click()

end

function Tabpanel:draw()
	for i,v in pairs(self.tabs) do 
		
		
		if i == self.selectedTab then
			for j, k in pairs(v.elements) do 
				k:draw()
			end 
		end
	end
end