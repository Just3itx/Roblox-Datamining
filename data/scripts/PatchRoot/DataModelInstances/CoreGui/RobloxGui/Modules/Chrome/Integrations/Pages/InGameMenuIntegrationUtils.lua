-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local GameInviteAnalyticsManager = require(CorePackages.Workspace.Packages.GameInvite).GameInviteAnalyticsManager
local GameInviteModalManager = require(CorePackages.Workspace.Packages.GameInvite).GameInviteModalManager
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal

local module = {}

function module.createPageOpenSignal(str1: string)
    local bool1 = false
    local signal = Signal.new()
    local mappedSignal = MappedSignal.new(signal, function()
        return bool1
    end)

    task.defer(function()
        local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
        settingsHub.CurrentPageSignal:connect(function(name)
            local var1 = settingsHub.Instance[str1]
            bool1 = not (var1 == nil) and name == var1.Page.Name
            signal:fire()
        end)
    end)

    return mappedSignal
end

function module.toggleIGMPage(str1: string, bool1: boolean)
    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    local var1 = settingsHub.Instance[str1]
    if not settingsHub:GetVisibility() then
        settingsHub:SetVisibility(true, false, var1)

        return
    end

    if bool1 then
        settingsHub:SetVisibility(false)
        return
    end
    settingsHub:SwitchToPage(var1, true)
end

function module.toggleInviteFriendsPage()
    if GameInviteModalManager:isGameModalOpen() then
        GameInviteModalManager:closeModal()
        return
    end

    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    GameInviteAnalyticsManager:withButtonName(GameInviteAnalyticsManager.ButtonName.SettingsHub)
    settingsHub:InviteToGame()
end

return module
