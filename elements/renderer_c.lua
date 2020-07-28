elementsToDraw = {}

addEventHandler("onClientRender", root, function()
	for i,v in pairs(elementsToDraw) do
		v:draw()
	end
end)

addEventHandler("onClientClick", root, function(button, state)
	if button == "left" then
		if state == "down" then
			for i,v in pairs(elementsToDraw) do
				if isCursorShowing() then 
					if v.click and isMouseInPosition(v.pos, v.size) then
						v:click()
					elseif v.deClick then
						v:deClick()
					end
				end
			end
		elseif state == "up" then
			for i,v in pairs(elementsToDraw) do
				if isCursorShowing() then 
					if v.outClick then
						v:outClick()
					end
				end
			end
		end
	end
end)
