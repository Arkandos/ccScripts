--[[
    Arkandos API Installer
    Author: Arkandos
]]--

local version = 0.1
local dirList = {"api"}
local fileList = { 
    apiloader = {path = "api/apiloader.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/programs/apiloader.lua"},
    addon = {path = "api/addon.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/api/addon.lua"},
    clear = {path = "api/clear.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/api/clear.lua"},
    clock = {path = "api/clock.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/api/clock.lua"},
    file = {path = "api/file.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/api/file.lua"},
    monitor = {path = "api/monitor.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/api/monitor.lua"},
    text = {path = "api/text.lua", url = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/api/text.lua"}
}


local args = {...}

local function iPrint(msg)
    print("[APIInstaller] "..msg)
end

local function errorMessage(msg)
    iPrint("[ERROR] "..msg)
end



-- Read / Write

local function writeFile(path, content)
    local fileH = fs.open(path, "w")
    fileH.write(content)
    fileH.close()
end

-- HTTP

--- Gets result of url, throwing an error and returning false if unreachable
---@param url string
---@return table|boolean 
local function httpFetch(url)
    if not http.checkURL(url) then
        errorMessage(url.." blocked in config. Unable to fetch data")
        return false
    end

    local result = http.get(url)
    if result == nil then
        errorMessage("Unable to reach '"..url.."'")
        return false
    else
        return result
    end
end

local function httpDownload(path, url)
    local result = httpFetch(url)
    if result == false then 
        return false
    end

    writeFile(path, result.readAll())
    return true
end

-- Install / update / remove
local function packageInstall()
    for key, value in pairs(dirList) do
        if fs.exists(value) == false then fs.makeDir(value) end
    end

    for key, value in pairs(fileList) do
        iPrint("Installing "..key.." at "..value["path"])
        httpDownload(value["path"], value["url"])
    end
end

-- For now, just reinstalls all packages. 
local function packageUpdate()
    packageInstall()
end

local function packageRemove()
    -- Delete installed files
    for key, value in pairs(fileList) do
        iPrint("Removing "..key.." at "..value["path"])
        fs.delete(value["path"])
    end

    -- Cleanup empty folders
    for key, value in pairs(dirList) do
        if fs.exists(value) == true then 
            if fs.list(value)[1] == nil then
                fs.delete(value)
            end
        end
    end
end

-- Main
local function main()
    local funcList = { install = packageInstall, update = packageUpdate, remove = packageRemove}
    funcList[args[1]]()
end

main()