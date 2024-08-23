-- Module that simplifies file management

local version = 1.0

-- Read target file and return its value. If readAll is nil then default to false.
---@param file string
---@param readAll? boolean
---@return boolean or string 
local function read(file, readAll)
	if readAll ~= false and readAll ~= true then readAll = false end
	if fs.exists(file) == false then return false end

	-- Open file in read-only mode
	local fileH = fs.open(file, "r")
	local content
	if readAll then
		content = fileH.readAll()
	else
		content = fileH.readLine()
	end

	fileH.close()
	return content
end

--- Read target file and return it serialized.
---@param file string
---@param readAll? boolean
---@return unknown
local function readSerialize(file, readAll)
	return textutils.unserialise(read(file, readAll))
end

-- Returns all lines in target file arranged in a table
---@param file string
---@return boolean | table
local function readLines(file)
	if fs.exists(file) == false then return false end
	local output = {}

	for line in io.lines(file) do
		table.insert(output, #output + 1, line)
	end
	return output
end

-- Write input into file. Mode can be either "a" to append, or "w" to overwrite
---@param file string
---@param mode string
---@param input string
---@return boolean
local function write(file, mode, input)
	if mode ~= "a" and mode ~= "w" then mode = "w" end
	if fs.exists(file) == false then return false end

	-- Open file in chosen mode
	local fileH = fs.open(file, mode)
	fileH.write(input)
	fileH.close()

	return true
end

--- Write input into file serialized. Mode can be either "a" to append, or "w" to overwrite
---@param file string
---@param mode string
---@param input string
local function writeSerialize(file, mode, input)
	return write(file, mode, textutils.serialize(input))
end

return {version = version, read = read, readLines = readLines, readSerialize = readSerialize, write = write, writeSerialize = writeSerialize}