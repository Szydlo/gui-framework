elementsToDraw = {}

addEventHandler("onClientRender", root, function()
	for i,v in pairs(elementsToDraw) do
		v:draw()
	end
end)

addEventHandler("onClientClick", root, function(button, state)
	if button == "left" and state == "down" then
		for i,v in pairs(elementsToDraw) do
			if isCursorShowing() and 
				if v.click and isMouseInPosition(v.pos, v.size) then
					v:click()
				elseif v.outClick then
					v:outClick()
				end
			end
		end
	end
end)