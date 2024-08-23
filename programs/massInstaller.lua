-- Made utilizing ccpt by PentagonLP https://github.com/PentagonLP/ccpt
-- All available local packages. Do not edit
local packageList = {apiloader = "url"}
-- Packages to install
local installList = {"apiloader"}


-- Install the ccpt package manager
shell.run("pastebin run syAUmLaF")

-- Add local packages to ccpt
for key, value in pairs(packageList) do
    shell.run("ccpt add k v")
    print("Successfully added "..key.." to local packages")
end

-- Update and upgrade ccpt packages
shell.run("ccpt update")
shell.run("ccpt upgrade")

-- Install
for key, value in pairs(installList) do
    shell.run("ccpt install k")
end