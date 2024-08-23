-- Made utilizing ccpt by PentagonLP https://github.com/PentagonLP/ccpt
-- All available local packages. Do not edit
local packageList = {
    apiloader = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/apiloader.ccpt",
    addon = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/addon.ccpt",
    clear = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/clear.ccpt",
    clock = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/clock.ccpt",
    file = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/file.ccpt",
    monitor = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/monitor.ccpt",
    text = "https://raw.githubusercontent.com/Arkandos/ccScripts/main/packages/text.ccpt"
}
-- Packages to install
local installList = {"apiloader", "clear", "clock", "file", "monitor", "text"}


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
    print("[Mass Installer] Installing ".. key)
    shell.run("ccpt install "..key)
end