--- Arkandos apiloader 3

local _version = 3.0

local apiDir = "api"
local filelist = {}
local loud = false  -- If true display all information as it is loaded

-- Local functions
local function qprint(input)
    if loud then print (input) end    
end

-- Global functions
local function getApiDir()
    return apiDir
end

-- Return version of api, if available
---@param _api string
---@return string
local function getVersion(_api)
    if _api.version == nil then return ""
    else
        return _api.version
    end
end

-- Check if all dependencies of an api are available
-- Returns bool if dependencies are available; list of dependencies with load status
---@param _api string
---@return boolean, table
local function checkDependecy(_api)
    if _api.dependencies == nil then return true, {} end

    local d = _api.dependencies
    local requiredDependencies = {}
    local dependenciesAvailable = true

    -- Add all dependencies to a list and set them as unloaded (false) 
    for i=1, #d do
        requiredDependencies[d[i]] = false
    end

    -- Check the list of apis currently being loaded. If those correspond to the dependency, mark it as available.
    -- Then check the list of already loaded modules.
    for k, v in pairs(requiredDependencies) do
        if filelist[k] ~= nil then
            requiredDependencies[k] = true
        else
            if package.loaded[k] then
                requiredDependencies[k] = true
            else
                dependenciesAvailable = false
            end
        end
    end

    return dependenciesAvailable, requiredDependencies
end

-- Load all api's in apiDir. If printToConsole is true, then output the information to the console.
local function load(printToConsole)
    local startTime = os.clock()
    local loaded = 0

    if printToConsole ~= nil then loud = printToConsole end

    qprint("APILoader v.".. _version)
    
    local filelist = fs.list(apiDir)
    if filelist == nil then -- If no files can be loaded in the chosen directory, end the program.
        print("No APIs found in /"..apiDir.."/")
        return
    end
    for key, value in pairs(filelist) do -- Require cannot load files with a fileextension 
        filelist[key] = string.gsub(filelist[key], ".lua", "")
    end

    qprint("Loading "..#filelist.." files")

    for i=1, #filelist do   -- Sequentially load all files in apiDir
        
        local d, dList = checkDependecy(filelist[i]) -- Check that all required dependencies are available
        if d then
            require(apiDir..".".. filelist[i])
            qprint("Loaded "..filelist[i].." v."..getVersion(filelist[i]))
            loaded = loaded + 1
        else
            -- If dependencies are not available, combine an error message
            local s = "Failed to load "..filelist[i].." v."..getVersion(filelist[i])..": missing dependencies "
            for key, value in pairs(dList) do
                if value == false then
                    s = s .. key .. ", "
                end
            end
            print(s) -- Print error message
        end
        

    end

    qprint("Loaded "..loaded.."/"..#filelist.." APIs in "..(os.clock() - startTime).." seconds")

end

-- Return all functions that should be accessible outside this file
return { load = load }