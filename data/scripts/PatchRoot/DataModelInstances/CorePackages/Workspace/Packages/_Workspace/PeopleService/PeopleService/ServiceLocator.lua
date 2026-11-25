-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local PeopleService = script:FindFirstAncestor("PeopleService")

local module = {}

local tbl1 = ({})

local GetFFlagPeoplePageEnablePersonSignalStore = require(PeopleService.Flags).GetFFlagPeoplePageEnablePersonSignalStore

local function loadService(arg1)
    local var1 = nil
    if arg1 == "PeopleUtility" then
        var1 = require(script.Parent.PeopleUtility)
    elseif arg1 == "PeopleListStore" then
        if GetFFlagPeoplePageEnablePersonSignalStore() then
            var1 = require(script.Parent.PeopleListStore)()
        else
            var1 = require(script.Parent.PeopleListStore)
        end
    elseif arg1 == "PeopleAnalyticsManager" then
        var1 = require(script.Parent.Analytics.PeopleAnalyticsManager)
    elseif arg1 == "PerUserVoiceVolumeSessionLifecycle" then
        var1 = require(script.Parent.Analytics.PerUserVoiceVolumeSessionLifecycle)
    elseif arg1 == "SettingsHubService" then
        var1 = require(script.Parent.Integration.SettingsHubService)
    elseif arg1 == "PeopleVoiceChatStore" then
        var1 = require(script.Parent.ButtonStores.PeopleVoiceChatStore)
    elseif arg1 == "PeopleBlockStatusStore" then
        var1 = require(script.Parent.ButtonStores.PeopleBlockStatusStore)
    elseif arg1 == "FriendStatusStore" then
        var1 = require(script.Parent.ButtonStores.FriendStatusStore)
    elseif arg1 == "PeopleReportAbuseMenu" then
        var1 = require(script.Parent.Integration.PeopleReportAbuseMenu)
    elseif arg1 == "PeopleBlockingModalManager" then
        var1 = require(script.Parent.Integration.PeopleBlockingModalManager)
    elseif arg1 == "Flags" then
        var1 = require(script.Parent.Flags)
    elseif arg1 == "Constants" then
        var1 = require(script.Parent.Constants)
    elseif arg1 == "FocusNavigationService" then
        var1 = require(script.Parent.FocusNavigationService)
    else
        error("Unknown service: " .. arg1)
    end

    tbl1[arg1] = var1
    return var1
end

function module.register(arg1, arg2)
    tbl1[arg1] = arg2
end

function module.get(arg1)
    if not tbl1[arg1] then
        loadService(arg1)
    end
    return tbl1[arg1]
end

function module.has(arg1): boolean
    return tbl1[arg1] ~= nil
end

function module.clear()
    tbl1 = {}
end

return module
