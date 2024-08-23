-- Module to interact with peripherals

local version = 0.1
local dependencies = {"text"}
local apiloader = require("apiloader")
local text = require(apiloader.getApiDir()..".text")

--- Prints all available peripherals
local function list()
    local peripheralList = peripheral.getNames()
    text.list(peripheralList)
end

local function listMethods(name)
    local peripheralList = peripheral.getMethods(name)
    textutils.pagedTabulate(peripheralList)
end

--- Find all peripherals of a certain type, and optionally execute a filter function on them. See peripheral.find for more info
---@param peripheralName string
---@param filter function
---@param arguments table
---@return boolean | table
local function mount(peripheralName, filter, arguments)
    local deviceList = peripheral.find(peripheralName, filter(table.unpack(arguments)))
    if deviceList == nil then return false end
    return deviceList
end


return {version = version, list = list, listMethods = listMethods, mount = mount }