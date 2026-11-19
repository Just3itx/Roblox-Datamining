-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

function dismissRobloxMenuAndRun(callback)
    if FFlagEnableConsoleExpControls and UserInputService.GamepadEnabled then
        GuiService.SelectedCoreObject = nil
    end

    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    if not GuiService.MenuIsOpen then
        callback(false)

        return
    end

    local var1 = tick() + 3
    local connection = nil
    connection = GuiService.MenuClosed:Connect(function()
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if tick() < var1 then
            callback(true)
        end
    end)
    settingsHub:SetVisibility(false)
end
return {
    dismissRobloxMenuAndRun = dismissRobloxMenuAndRun
}
