elementsToDraw = {}
animations = {}

addEventHandler("onClientRender", root, function()
	for i,v in pairs(elementsToDraw) do
		if v.draw and v.canDraw then
			v:draw()
		end
	end

	local now = getTickCount()
	for element,v in pairs(animations) do
		local easing = getEasingValue((now - v.start) / v.time, v.easing)
		local pos = v.to - v.from
		element.pos = v.from + Vector2(pos.x*easing, pos.y*easing)

		if element.elements then
			for i,v in pairs(element.elements) do 
				v.pos = v.from + Vector2(pos.x*easing, pos.y*easing)
			end
		end

		if now >= v.start + v.time then
			animations[element] = nil
		end
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

addEventHandler("onClientKey", root, function(button, press)
	for i,v in pairs(elementsToDraw) do
		if v.key then
			v:key(button, press)
		end
	end
end)