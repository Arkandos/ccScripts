-- Module for easier time manipulation


local version = 0.1

-- Returns time in either ingame, utc, or local format
---@param format osdateparam
---@return unknown
local function time(format)
	return textutils.formatTime(os.time(format), true)
end

-- Returns the current local date in a userfriendly string.
---@param format string
---@return string|osdate
local function date(format)
	return os.date("%A %d %B %Y")
end

return {version = version, time = time, date = date}