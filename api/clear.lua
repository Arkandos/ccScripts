-- Module that simplifies the resetting of the terminal or monitor

local version = 1.0

---@param resetColour boolean
---@param monitor? table
local function resetColour(resetColour, monitor)
	if resetColour then
		if monitor == nil then
			term.setTextColour(colours.white)
			term.setBackgroundColour(colours.black)
		else
			monitor.setTextColour(colours.white)
			monitor.setBackgroundColour(colours.black)
		end
	end
end

-- Clears the entire terminal and resets the cursor position
-- If reset is true, then also resets colours to black/white
---@param reset boolean
---@param monitor? table
local function all(reset, monitor)
	resetColour(reset, monitor)
	if monitor == nil then
		term.clear()
		term.setCursorPos(1, 1)
	else
		monitor.clear()
		monitor.setCursorPos(1, 1)
	end
end

-- Clears the line
---@param reset boolean
---@param monitor? table
local function line(reset, monitor)
	resetColour(reset, monitor)
	if monitor == nil then
		term.clearLine()
	else
		monitor.clearLine()
	end
	
end

return { version = version, all = all, line = line }