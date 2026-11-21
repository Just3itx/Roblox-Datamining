-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(GamePlayButtonParent.RoactServiceTags).AppEventIngestService
local unlockPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.unlockPlayIntent
local OpenPlayButtonUpsellDialog = require(GamePlayButtonParent.DiscoveryRouting).OpenPlayButtonUpsellDialog
local CloseCentralOverlay = require(GamePlayButtonParent.CentralOverlay).Thunks.CloseCentralOverlay
local flaggedMutedError = require(GamePlayButtonParent.Loggers).flaggedMutedError
local DiscoveryTypes = require(GamePlayButtonParent.DiscoveryTypes)
local PlayableUxTreatmentEnum = DiscoveryTypes.PlayableUxTreatmentEnum
local PlayabilityStatusEnum = DiscoveryTypes.PlayabilityStatusEnum
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)

local FFlagLuaAppDemoModePlayButtonTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppCloudClientPlayButtonOffer = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppCloudClientPlayButtonOffer

local function asReconfirmLaunchModalData(data) -- Luacid: Inlined by compiler; 1 call site recovered
    if not data then
        return nil
    end

    return if type(data.titleText) == "string"
        and type(data.bodyText) == "string"
        and type(data.primaryActionText) == "string"
        and type(data.secondaryActionText) == "string" then data else nil
end

return function(str1: string?, universeId: string?, callback: string?, pageName: string?)
    local var1 = useRoactService(AppEventIngestService)
    local var2 = useDispatch()

    local var3 = React.useCallback(function(upsellName)
        unlockPlayIntent(var1, {
            universeId = universeId,
            upsellName = upsellName,
            playabilityStatus = str1 and str1.playabilityStatus or nil,
            pageName = pageName
        })
    end, {
        var1,
        universeId,
        str1,
        pageName
    })

    return React.useCallback(function(arg1, str4: string?, arg2)
        if not str1
            or not str1.playableUxTreatment
            or not str1.playableUxTreatment.treatment
            or str1.playabilityStatus ~= PlayabilityStatusEnum.Playable
        then
            if FFlagLuaAppCloudClientPlayButtonOffer and arg2 ~= nil then
                callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil, arg2)
                return
            end

            callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)
            return
        end

        if str1.playableUxTreatment.treatment ~= PlayableUxTreatmentEnum.ReconfirmLaunchModal then
            flaggedMutedError(
                "PlayableUxTreatmentUnsupported",
                `playableUxTreatment treatment {str1.playableUxTreatment.treatment} is unsupported for universeId {universeId}`
            )
            if FFlagLuaAppCloudClientPlayButtonOffer and arg2 ~= nil then
                callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil, arg2)
            else
                callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)
            end

            var3("GameLaunch")
            return
        end

        local var4 = asReconfirmLaunchModalData(str1.playableUxTreatment.data)

        if not var4 then
            flaggedMutedError(
                "PlayableUxTreatmentMissingData",
                `playableUxTreatment data is missing for treatment {PlayableUxTreatmentEnum.ReconfirmLaunchModal} on universeId {universeId}`
            )
            if FFlagLuaAppCloudClientPlayButtonOffer and arg2 ~= nil then
                callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil, arg2)
            else
                callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)
            end

            var3("GameLaunch")
            return
        end
        var2(
            OpenPlayButtonUpsellDialog(
                var4.titleText,
                var4.bodyText,
                var4.primaryActionText,
                var4.secondaryActionText,
                function()
                    var2(CloseCentralOverlay())
                    if FFlagLuaAppCloudClientPlayButtonOffer then
                        callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil, { hasShownUpsell = true })
                        return
                    end

                    callback(arg1, if FFlagLuaAppDemoModePlayButtonTelemetry then str4 else nil)
                end,
                function()
                    var2(CloseCentralOverlay())
                end,
                function()
                    var2(CloseCentralOverlay())
                end
            )
        )

        var3("ReconfirmLaunchModal")
    end, {
        str1,
        universeId,
        callback,
        var3,
        var2
    })
end
