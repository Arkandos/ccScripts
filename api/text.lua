-- Module to simplify text interactions on both terminals and monitors

local version = 1.0
local math = require("math")
local textMethods = -- Supported string output methods for this module
	{
		print = function(arg1) print(arg1) end,
		write = function(arg1) write(arg1) end,
		slowPrint = function(arg1, arg2) textutils.slowPrint(arg1, arg2) end,
		slowWrite = function(arg1, arg2) textutils.slowWrite(arg1, arg2) end,
		pagedPrint = function(arg1, arg2) textutils.pagedPrint(arg1, arg2) end,
		tabulate = function(arg1) textutils.tabulate(arg1) end,
		pagedTabulate = function(arg1) textutils.pagedTabulate(arg1) end
	}



--- Outputs a string using the function specified as method. Arguments given in a table are executed in order.
---@param method string
---@param arguments? table
---@param input string
---@param textColour? number
---@param bgColour? number
---@return boolean
local function centerString(method, arguments, input, textColour, bgColour)
	local x, y = term.getCursorPos()
	local stringSize = #input
	local termWidth, termHeight = term.getSize()
	stringSize = math.floor(stringSize / 2)
	x = math.floor(termWidth / 2) - stringSize
	term.setCursorPos(x, y)
	
	local arg1, arg2
	if arguments ~= nil and type(arguments) == "table" then
		arg1, arg2 = table.unpack(arguments)
	end
	textMethods[method](arg1, arg2)

	return true
end

--- Prints a table, line by line
---@param t table
local function printTable(t)
	for key, value in pairs(t) do
		print(key..":"..value)
	end
end


--[[
function centerMonitor(input, dir) -- Center a string on a monitor
	local monitor = peripheral.wrap(dir)
	local x, y = term.getCursorPos()
	local sSize = #input
	sSize = sSize / 2
	x = 25 - sSize
	term.setCursorPos(x, y)
	monitor.write(input)
end
]]--


return {version = version, center = centerString}