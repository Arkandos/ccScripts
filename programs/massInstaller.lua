-- Made utilizing ccpt by PentagonLP https://github.com/PentagonLP/ccpt
-- All available local packages. Do not edit
local packageList = {
    apiInstaller = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/programs/installers/apiInstaller.lua"
}
-- Packages to install
local installList = {"apiInstaller"}


-- Install the ccpt package manager
shell.run("pastebin run syAUmLaF")

-- Add local packages to ccpt
for key, value in pairs(packageList) do
    shell.run("ccpt add "..key.." "..value)
    print("[Mass Installer] Successfully added "..key.." to local packages")
end

-- Update and upgrade ccpt packages
shell.run("ccpt update")
shell.run("ccpt upgrade")

-- Install
for key, value in pairs(installList) do
    print("[Mass Installer] Installing ".. value)
    shell.run("ccpt install "..value)
end