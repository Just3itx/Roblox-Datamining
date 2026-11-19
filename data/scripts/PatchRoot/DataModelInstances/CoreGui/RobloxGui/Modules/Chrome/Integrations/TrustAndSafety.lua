-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal
local FFlagStandardizeSafetyIcon = SharedFlags.FFlagStandardizeSafetyIcon

local bool1 = false
local signal = Signal.new()
local mappedSignal = MappedSignal.new(signal, function()
    return bool1
end)

task.defer(function()
    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    settingsHub.CurrentPageSignal:connect(function(name)
        bool1 = name == settingsHub.Instance.ReportAbusePage.Page.Name
        signal:fire()
    end)
end)

return Service:register({
    initialAvailability = Service.AvailabilitySignal.Available,
    id = "trust_and_safety",
    label = "CoreScripts.InGameMenu.QuickActions.Report",
    sideSheetPlacement = SideSheetPlacement.AboveFold,
    activated = function(_)
        local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
        if not settingsHub:GetVisibility() then
            settingsHub:SetVisibility(true, false, settingsHub.Instance.ReportAbusePage)

            return
        end

        if bool1 then
            settingsHub:SetVisibility(false)
            return
        end
        settingsHub:SwitchToPage(settingsHub.Instance.ReportAbusePage, true)
    end,
    isActivated = mappedSignal,
    components = {
        Icon = function(_)
            if FFlagStandardizeSafetyIcon then
                return CommonIcon("Flag", nil, mappedSignal)
            end
            return CommonIcon("icons/menu/safety_off", "icons/menu/safety_on", mappedSignal)
        end
    }
})
