-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local FetchGamePlayButtonData = require(GamePlayButton.FetchGamePlayButtonData)
local PlaytestUnlockUpsell = require(GamePlayButton.PlaytestUnlockUpsell)
local PlayButtonStates = require(GamePlayButton.PlayButtonStates)
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)

local delayedAmpWizardCompletionCallbackOverride = require(GamePlayButton.PlayButtonLaunchChecks.delayedAmpWizardCompletionCallbackOverride)

local GamePlayButtonParent = GamePlayButton.Parent
local useUpdatePlaytestSettingsUpsell = require(GamePlayButtonParent.BuildExperiencePlaytestLaunch.useUpdatePlaytestSettingsUpsell)
local useTrustedFriendsPlaytestUpsell = require(GamePlayButtonParent.BuildExperiencePlaytestLaunch.useTrustedFriendsPlaytestUpsell)
local React = require(GamePlayButtonParent.React)
local RoactUtils = require(GamePlayButtonParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useStore = RoactUtils.Hooks.RoactRodux.useStore
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GamePlayButtonParent.RoactServiceTags).RoactNetworking
local AppEventIngestService = require(GamePlayButtonParent.RoactServiceTags).AppEventIngestService
local ApiFetchPlayabilityStatus = require(GamePlayButtonParent.PlayabilityRodux).PlayabilityStatus.ApiFetchPlayabilityStatus
local OpenAmpWizardContainer = require(GamePlayButtonParent.AmpUpsell).OpenAmpWizardContainer
local unlockPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.unlockPlayIntent
local invalidPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.invalidPlayIntent

local FStringLuaAppPlayButtonAgeCheckAmpFeatureName = require(GamePlayButtonParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpFeatureName

local FStringLuaAppPlayButtonAgeCheckAmpNameSpace = require(GamePlayButtonParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpNameSpace
local FFlagLuaAppPlayButtonWizardCloseDelay = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonWizardCloseDelay
local FIntLuaAppPlayButtonWizardCloseDelayMs = require(GamePlayButtonParent.SharedFlags).FIntLuaAppPlayButtonWizardCloseDelayMs
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability

local Type = PlaytestUnlockUpsell.Type

return function(arg1, universeId: string, callback, str2: string, pageName: string?, str4: string?)
    local var1 = useRoactService(RoactNetworking)
    local var2 = useRoactService(AppEventIngestService)
    local var3 = useDispatch()
    local var4 = useStore()
    local var5 = useUpdatePlaytestSettingsUpsell()

    local var6 = React.useCallback(function()
        var3(FetchGamePlayButtonData.Fetch(var1, universeId, true))
    end, { var3, var1, universeId })

    local var7 = useTrustedFriendsPlaytestUpsell(str4, if FFlagLuaAppPlaytestTrustedFriendsRefetchPlayability then var6 else nil)

    local var8 = React.useCallback(function(upsellName: string, playabilityStatus: string?)
        unlockPlayIntent(
            var2,
            {
                universeId = universeId,
                upsellName = upsellName,
                playabilityStatus = playabilityStatus,
                pageName = pageName
            }
        )
    end, { var2, universeId, pageName })

    local var9 = React.useCallback(function(playabilityStatus: string?)
        invalidPlayIntent(str2, {
            universeId = universeId,
            playButtonState = PlayButtonStates.Playtest,
            playabilityStatus = playabilityStatus or "None"
        })
    end, { str2, universeId })

    local var10 = React.useCallback(function(str5: string?)
        var3(
            OpenAmpWizardContainer(
                FStringLuaAppPlayButtonAgeCheckAmpFeatureName,
                var6,
                nil,
                if pageName then `gameJoinAgeCheckRequired-{pageName}` else "gameJoinAgeCheckRequired",
                nil,
                FStringLuaAppPlayButtonAgeCheckAmpNameSpace,
                nil,
                nil,
                if FFlagLuaAppPlayButtonWizardCloseDelay then delayedAmpWizardCompletionCallbackOverride(var6, FIntLuaAppPlayButtonWizardCloseDelayMs) else nil
            )
        )

        var8("AgeCheckRequired", str5)
    end, {
        var3,
        var6,
        pageName,
        var8
    })

    return (React.useCallback(function(arg2, str5: string?)
        local function launchPrivatePlaytest() -- Luacid: Inlined by compiler; 1 call site recovered
            callback(arg2, if FFlagLuaAppDemoModePlayButtonTelemetry then str5 else nil)
        end

        local function handlePrivatePlaytestInfo(privatePlaytestInfo)
            if privatePlaytestInfo == nil then
                var9(nil)
                return
            end

            if privatePlaytestInfo.isPlayable then
                launchPrivatePlaytest()
                return
            end

            local playabilityStatus = privatePlaytestInfo.playabilityStatus
            local type = PlaytestUnlockUpsell.getType(playabilityStatus)
            if type == Type.AgeVerification then
                var10(playabilityStatus)
            elseif type == Type.UpdatePlaytestSettings then
                var5()
                var8("UpdatePlaytestSettings", playabilityStatus)
            elseif type == Type.TrustedFriends then
                var7()
                var8("TrustedFriendRequired", playabilityStatus)
            else
                var9(playabilityStatus)
            end
        end

        var3(ApiFetchPlayabilityStatus.Fetch(var1, { universeId })):andThen(function()
            local var11 = var4:getState().PlayabilityStatus[universeId]
            handlePrivatePlaytestInfo(var11 and var11.privatePlaytestInfo or nil)
        end):catch(function()
            handlePrivatePlaytestInfo(arg1 and arg1.privatePlaytestInfo or nil)
        end)
    end, {
        var3,
        var1,
        universeId,
        var4,
        callback,
        arg1,
        var10,
        var5,
        var7,
        var8,
        var9
    }))
end
