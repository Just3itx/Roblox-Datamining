-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)
local GetFFlagLuaAppFetchPlayabilityKillSwitch = require(GamePlayButton.Flags.GetFFlagLuaAppFetchPlayabilityKillSwitch)
local FetchGamePlayButtonData = require(GamePlayButton.FetchGamePlayButtonData)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GamePlayButtonParent.RoactServiceTags).RoactNetworking
local AppEventIngestService = require(GamePlayButtonParent.RoactServiceTags).AppEventIngestService
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)
local FetchGamePlayabilityAndProductInfo = require(GamePlayButtonParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local OpenAgeVerificationModal = require(GamePlayButtonParent.VoiceChat).AgeVerificationOverlay.OpenAgeVerificationModal

local useContextualParentalControlsUpsell = require(GamePlayButton.PlayButtonLaunchChecks.useContextualParentalControlsUpsell)

local delayedAmpWizardCompletionCallbackOverride = require(GamePlayButton.PlayButtonLaunchChecks.delayedAmpWizardCompletionCallbackOverride)
local unlockPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.unlockPlayIntent
local OpenAmpWizardContainer = require(GamePlayButtonParent.AmpUpsell).OpenAmpWizardContainer

local FFlagLuaAppPlayButtonAmpAgeCheckFlow = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonAmpAgeCheckFlow

local FStringLuaAppPlayButtonAgeCheckAmpFeatureName = require(GamePlayButtonParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpFeatureName

local FStringLuaAppPlayButtonAgeCheckAmpNameSpace = require(GamePlayButtonParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpNameSpace
local FFlagLuaAppParentApprovedExperiences = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppParentApprovedExperiences
local FFlagLuaAppPlayButtonWizardCloseDelay = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonWizardCloseDelay
local FIntLuaAppPlayButtonWizardCloseDelayMs = require(GamePlayButtonParent.SharedFlags).FIntLuaAppPlayButtonWizardCloseDelayMs
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local var1 = if FFlagLuaAppPlayButtonAmpAgeCheckFlow then "gameJoinAgeCheckRequired" else nil

return function(str1: string?, universeId: string?, callback, pageName: string?)
    local var2 = useRoactService(RoactNetworking)
    local var3 = useRoactService(AppEventIngestService)

    local var4 = useDispatch()

    local var5 = React.useCallback(function(upsellName)
        unlockPlayIntent(var3, {
            universeId = universeId,
            upsellName = upsellName,
            playabilityStatus = str1 and str1.playabilityStatus or nil,
            pageName = pageName
        })
    end, {
        var3,
        universeId,
        str1,
        pageName
    })

    local var6 = nil
    local var7

    if FFlagLuaAppParentApprovedExperiences then
        var7, var6 = useContextualParentalControlsUpsell(universeId, callback, pageName)
    else
        var7 = useContextualParentalControlsUpsell(universeId, callback, pageName)
    end

    local var8 = if FFlagLuaAppPlayButtonAmpAgeCheckFlow then React.useCallback(function()
        var4(FetchGamePlayButtonData.Fetch(var2, universeId, true))
    end, { var4, var2, universeId }) else nil

    local useCallback = React.useCallback

    local function func1(arg1, str4: string?)
        if not str1 then
            callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)

            return
        end

        if str1.playabilityStatus ~= PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
            and str1.playabilityStatus ~= PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls
            and (not FFlagLuaAppPlayButtonAmpAgeCheckFlow
                or str1.playabilityStatus ~= PlayabilityStatusEnum.ContextualPlayabilityAgeCheckRequired)
            and (not FFlagLuaAppParentApprovedExperiences
                or str1.playabilityStatus ~= PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval)
            or GetFFlagLuaAppFetchPlayabilityKillSwitch()
        then
            callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)
            return
        end

        var4(FetchGamePlayabilityAndProductInfo.Fetch(var2, universeId)):andThen(function(arg2)
            if arg2 == PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
                or FFlagLuaAppPlayButtonAmpAgeCheckFlow and arg2 == PlayabilityStatusEnum.ContextualPlayabilityAgeCheckRequired
            then
                if FFlagLuaAppPlayButtonAmpAgeCheckFlow then
                    var4(
                        OpenAmpWizardContainer(
                            FStringLuaAppPlayButtonAgeCheckAmpFeatureName,
                            var8,
                            nil,
                            if pageName then `{var1}-{pageName}` else var1,
                            nil,
                            FStringLuaAppPlayButtonAgeCheckAmpNameSpace,
                            nil,
                            nil,
                            if FFlagLuaAppPlayButtonWizardCloseDelay then delayedAmpWizardCompletionCallbackOverride(var8, FIntLuaAppPlayButtonWizardCloseDelayMs) else nil
                        )
                    )
                else
                    var4(OpenAgeVerificationModal(universeId))
                end

                var5(if FFlagLuaAppPlayButtonAmpAgeCheckFlow then "AgeCheckRequired" else "AgeVerificationUnverifiedSeventeenPlusUser")
                return
            end

            if arg2 == PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls then
                var7()
            elseif FFlagLuaAppParentApprovedExperiences and arg2 == PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval then
                var6(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)
            else
                callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)

                var5("GameLaunch")
            end
        end):catch(function()
            callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)

            var5("GameLaunch")
        end)
    end

    local var9 = var7
    local var10 = if FFlagLuaAppParentApprovedExperiences then var6 else nil
    local var11 = if FFlagLuaAppPlayButtonAmpAgeCheckFlow then var8 else nil
    local var12 = if FFlagLuaAppPlayButtonAmpAgeCheckFlow then var4 else nil
    return (useCallback(func1, { var2, universeId, str1, callback, var5, var9, var10, var11, var12, pageName }))
end
