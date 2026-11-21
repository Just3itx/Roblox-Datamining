-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local IXPService = game:GetService("IXPService")
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)
local GamePlayButtonParent = GamePlayButton.Parent

local React = require(GamePlayButtonParent.React)
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GamePlayButtonParent.RoactServiceTags).RoactNetworking
local RoactUtils = require(GamePlayButtonParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local VoiceChat = require(GamePlayButtonParent.VoiceChat)

local OpenCentralOverlayForVerifiedEnableVoice = VoiceChat.AgeVerificationOverlay.OpenCentralOverlayForVerifiedEnableVoice
local ApiPostRecordUserSeenModal = VoiceChat.AgeVerificationOverlay.ApiPostRecordUserSeenModal
local SetShowAgeVerificationOverlay = VoiceChat.AgeVerificationOverlay.SetShowAgeVerificationOverlay
local useAppPolicy = require(GamePlayButtonParent.UniversalAppPolicy).useAppPolicy

local GetFStringVoiceUpsellLayer = require(GamePlayButtonParent.SharedFlags).GetFStringVoiceUpsellLayer
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppCloudClientPlayButtonOffer = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppCloudClientPlayButtonOffer

return function<T>(arg1: T, callback: T, callback2: T)
    local var1 = useRoactService(RoactNetworking)
    local var2 = useDispatch()
    local var3 = useAppPolicy(function(arg2)
        return {
            RequireExplicitVoiceConsent = arg2.RequireExplicitVoiceConsent(),
            showVoiceOptInOverlayEnabled = arg2.getShowVoiceUpsellV2()
        }
    end)

    local var4 = useSelector(function(arg2)
        return if arg2.ShowAgeVerificationOverlay[arg1] == nil then {} else arg2.ShowAgeVerificationOverlay[arg1]
    end)

    local isPlaceEnabledForVoice = var4.isPlaceEnabledForVoice
    local isUniverseEnabledForVoice = var4.isUniverseEnabledForVoice
    local showVoiceOptInOverlay = var4.showVoiceOptInOverlay
    local elegibleToSeeVoiceUpsell = var4.elegibleToSeeVoiceUpsell
    local isVoiceEnabled = var4.isVoiceEnabled

    return (React.useCallback(function(arg2, str1: string?)
        if isUniverseEnabledForVoice and elegibleToSeeVoiceUpsell then
            local fStringVoiceUpsellLayer = GetFStringVoiceUpsellLayer()
            if fStringVoiceUpsellLayer ~= "" then
                IXPService:LogUserLayerExposure(fStringVoiceUpsellLayer)
            end
        end
        if not (showVoiceOptInOverlay and var3.showVoiceOptInOverlayEnabled) then
            callback2(arg2, if FFlagLuaAppDemoModePlayButtonTelemetry then str1 else nil)

            return
        end

        var2(
            OpenCentralOverlayForVerifiedEnableVoice({
                launchGame = function()
                    if FFlagLuaAppCloudClientPlayButtonOffer then
                        callback(arg2, if FFlagLuaAppDemoModePlayButtonTelemetry then str1 else nil, { hasShownUpsell = true })
                        return
                    end

                    callback(arg2, if FFlagLuaAppDemoModePlayButtonTelemetry then str1 else nil)
                end,
                RequireExplicitVoiceConsent = var3.RequireExplicitVoiceConsent,
                postUserSeenModal = function()
                    return var2(ApiPostRecordUserSeenModal.Fetch(var1))
                end,
                setShowVoiceOptIn = function(tbl1)
                    var2(
                        SetShowAgeVerificationOverlay(
                            arg1,
                            isPlaceEnabledForVoice,
                            isUniverseEnabledForVoice,
                            tbl1.voiceEnabled,
                            tbl1.showVoiceOptInOverlay
                        )
                    )
                end
            })
        )
    end, {
        var1,
        arg1,
        isPlaceEnabledForVoice,
        isUniverseEnabledForVoice,
        showVoiceOptInOverlay,
        var3.showVoiceOptInOverlayEnabled,
        var3.RequireExplicitVoiceConsent,
        isVoiceEnabled,
        callback,
        callback2,
        elegibleToSeeVoiceUpsell
    }))
end
