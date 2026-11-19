-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local LocalPlayer = Players.LocalPlayer

local scriptParentParent = script.Parent.Parent

local Actions = scriptParentParent.Actions

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local MaybeSendEmoteFailureAnalyticsFromPlayer = require(CoreGui.RobloxGui.Modules.EmotesMenu.Utility.MaybeSendEmoteFailureAnalyticsFromPlayer)

local HideMenu = require(Actions.HideMenu)
local HideError = require(Actions.HideError)
local ShowError = require(Actions.ShowError)

local var1 = Analytics.new():withEventStream(EventStream.new(RbxAnalyticsService))

local function handlePlayFailure(arg1, arg2, arg3, emoteId: number)
    if arg2 then
        var1:onEmoteFailed(arg3, emoteId, arg2)

        local locale = arg1:getState().locale
        local var2 = Constants.LocalizationKeys.ErrorMessages[arg2]
        local var3 = RobloxTranslator:FormatByKeyForLocale(var2, locale)

        arg1:dispatch(ShowError(var3))
        delay(Constants.ErrorDisplayTimeSeconds, function()
            arg1:dispatch(HideError())
        end)
    end

    arg1:dispatch(HideMenu())
end

local function PlayEmote(_, arg1, emoteId: number, _, _)
    return function(arg2)
        local player = LocalPlayer
        if MaybeSendEmoteFailureAnalyticsFromPlayer(player, function(arg3)
            handlePlayFailure(arg2, arg3, arg1, emoteId)
        end) then
            return
        end

        arg2:dispatch(HideMenu())

        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local success, result, _result2 = pcall(function()
            return humanoid:PlayEmoteAndGetAnimTrackById(emoteId)
        end)
        if success and result then
            var1:onEmotePlayed(arg1, emoteId)
            return
        end
        handlePlayFailure(arg2, Constants.ErrorTypes.TemporarilyUnavailable, arg1, emoteId)
    end
end

return PlayEmote
