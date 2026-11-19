-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Chrome = script:FindFirstAncestor("Chrome")
local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal

local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local FFlagRespawnChromeShortcutTelemetry = require(Chrome.Flags.FFlagRespawnChromeShortcutTelemetry)

local bool1 = false
local signal = Signal.new()
local mappedSignal = MappedSignal.new(signal, function()
    return bool1
end)

task.defer(function()
    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    settingsHub.CurrentPageSignal:connect(function(name)
        bool1 = name == settingsHub.Instance.ResetCharacterPage.Page.Name
        signal:fire()
    end)
end)

return {
    respawnPageOpenSignal = mappedSignal,
    respawnPage = function(tbl1)
        local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
        local resetCharacterPage = settingsHub.Instance.ResetCharacterPage
        local function switchToRespawnPage() -- Luacid: Inlined by compiler; 2 call sites recovered
            local tbl2 = {
                used_shortcut = if tbl1 then tbl1.usedShortcut else nil
            }
            settingsHub.Instance:SwitchToPage(resetCharacterPage, true, nil, nil, nil, tbl2)
        end

        if settingsHub:GetVisibility() then
            if bool1 then
                settingsHub:SetVisibility(false)
            elseif FFlagRespawnChromeShortcutTelemetry then
                switchToRespawnPage()
            else
                settingsHub.Instance:SwitchToPage(resetCharacterPage, true)
            end
        elseif FFlagRespawnChromeShortcutTelemetry then
            settingsHub:SetVisibility(true)
            switchToRespawnPage()
        else
            settingsHub:SetVisibility(true, false, resetCharacterPage)
        end
    end
}
