-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local SocialStopwatch = require(scriptParentParentParent.SocialStopwatch)

local CapturesPolicy = require(scriptParentParent.App.CapturesPolicy)
local CheckMomentsEligibility = require(scriptParentParent.Thunks.CheckMomentsEligibility)
local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local Constants = require(scriptParentParent.Constants)
local EventNames = require(scriptParentParent.Analytics.EventNames)
local RetrieveCaptures = require(scriptParentParent.Thunks.RetrieveCaptures)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)
local TriggerSourceType = require(scriptParentParent.Enums.TriggerSourceType)
local _Types = require(scriptParentParent.Types)

local fetchCapturesFromGallery = require(scriptParentParent.Utils.fetchCapturesFromGallery)
local GetLatestCaptureStore = require(scriptParentParent.Stores.GetLatestCaptureStore)
local findMatchingCapture = require(scriptParentParent.Utils.findMatchingCapture)
local getCaptureObject = require(scriptParentParent.Utils.getCaptureObject)
local pendingCaptureToastAction = require(scriptParentParent.Utils.pendingCaptureToastAction)
local waitForFlashOverlay = require(scriptParentParent.Utils.waitForFlashOverlay)

local SharedFlags = require(scriptParentParentParent.SharedFlags)
local FFlagBuildExperienceInGameCaptureToChat = SharedFlags.FFlagBuildExperienceInGameCaptureToChat
local FFlagMomentsCreationFeatureGate = SharedFlags.FFlagMomentsCreationFeatureGate
local GetMomentsCapabilities = require(scriptParentParentParent.MomentsCommon).Stores.GetMomentsCapabilities

local FFlagCapturesControlsGalleryButton = require(scriptParentParent.Flags.FFlagCapturesControlsGalleryButton)

local FIntCapturesControlsGalleryThumbnailSeconds = require(scriptParentParent.Flags.FIntCapturesControlsGalleryThumbnailSeconds)
local FFlagCreateMomentsToast = require(scriptParentParent.Flags.FFlagCreateMomentsToast)
local FFlagMomentsCaptureEndIxpEnabled = require(scriptParentParent.Flags.FFlagMomentsCaptureEndIxpEnabled)

local FFlagCapturesInExpMomentsEligibilityRetry = require(scriptParentParent.Flags.FFlagCapturesInExpMomentsEligibilityRetry)

local FIntMomentsInExperienceMinCaptureSeconds = require(scriptParentParent.Flags.FIntMomentsInExperienceMinCaptureSeconds)

local CaptureType = require(scriptParentParent.Enums.CaptureType)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local engineFeature = game:GetEngineFeature("CaptureServiceEnableXExperiencePostingApis")

local function triggerDefaultToast(arg1, bool1: boolean, captureInfo, bool2: boolean, callback: (...any) -> (...any))
    if bool1 then
        arg1:dispatch(ToastTriggered(CapturesToastType.CaptureTaken, { captureInfo = captureInfo }))
    else
        arg1:dispatch(ToastTriggered(CapturesToastType.ViewCapture))
    end

    if bool2 then
        callback(EventNames.CapturesVideoShareToastViewed)
    end

    callback(EventNames.CapturesShareToastViewed)
end

local function makeCaptureSavedHandler(arg1, _, callback: (...any) -> (...any))
    local function captureSavedHandler(captureInfo, arg2)
        local bool1 = if FFlagEnableCapturesGalleryRetrievalCoreScript then captureInfo.CaptureType == Enum.CaptureType.Video else captureInfo.type == CaptureType.Video

        if arg2 == TriggerSourceType.UserSave and not bool1 then
            local var1 = SocialStopwatch.Stopwatch.stop(SocialStopwatch.Events.CaptureTaken)
            callback(EventNames.CapturesEntrypointLatency, { statValue = if var1 then var1.timeElapsed else nil })
        end

        arg1:dispatch(RetrieveCaptures())
        waitForFlashOverlay(arg1)

        if FFlagCapturesControlsGalleryButton
            and arg2 == TriggerSourceType.UserSave
            and not arg1:getState()[Constants.RoduxKey].IsMenuOpen
        then
            local latestCaptureStore = GetLatestCaptureStore(false)
            local captureObject = getCaptureObject(captureInfo)
            local filePath = if typeof(captureInfo) == "table" then captureInfo.filePath else nil
            latestCaptureStore.setLatestCapture(captureObject, filePath)

            task.delay(FIntCapturesControlsGalleryThumbnailSeconds, function()
                if latestCaptureStore.getLatestCapture(false) == captureObject then
                    latestCaptureStore.clearLatestCapture()
                end
            end)
        end

        if FFlagBuildExperienceInGameCaptureToChat and arg2 == TriggerSourceType.UserSave then
            local toastAction = pendingCaptureToastAction.consume()
            local captureObject = if toastAction then getCaptureObject(captureInfo) else nil

            if captureObject ~= nil then
                arg1:dispatch(
                    ToastTriggered(CapturesToastType.CaptureTakenWithAction, { captureInfo = captureObject, toastAction = toastAction })
                )
                return
            end
        end

        if arg2 == TriggerSourceType.PromptedShare then
            return
        end

        local var1 = CapturesPolicy.PolicyImplementation.read()
        local var2 = if var1 then CapturesPolicy.Mapper(var1).enableShareCaptureCTA() else false
        local captureObject = getCaptureObject(captureInfo)

        local bool2 = false
        local gameId = if FFlagCreateMomentsToast then game.GameId else nil
        local var3 = not FFlagMomentsCreationFeatureGate or GetMomentsCapabilities(false).getCanCreateMoments(false)

        if FFlagCreateMomentsToast and engineFeature and var3 then
            local bool3 = not (captureObject == nil) and captureObject.CaptureType == Enum.CaptureType.Video
            local timeLength = if bool3 then captureObject.TimeLength else nil

            if captureObject == nil then
                bool2 = false
            else
                bool2 = not bool3

                if not bool2 then
                    if type(timeLength) == "number" then
                        bool2 = FIntMomentsInExperienceMinCaptureSeconds <= timeLength
                    else
                        bool2 = false
                    end
                end
            end
        end
        if FFlagMomentsCaptureEndIxpEnabled and FFlagCapturesInExpMomentsEligibilityRetry and not FFlagCreateMomentsToast then
            arg1:dispatch((CheckMomentsEligibility(game.GameId)))
        end

        if not bool2 or gameId == nil then
            triggerDefaultToast(arg1, var2, captureInfo, bool1, callback)
            return
        end

        if FFlagCapturesInExpMomentsEligibilityRetry then
            arg1:dispatch((CheckMomentsEligibility(gameId)))
        end

        if arg1:getState()[Constants.RoduxKey].MomentsEligibility.byUniverseId[gameId] ~= true then
            triggerDefaultToast(arg1, var2, captureInfo, bool1, callback)
            return
        end

        if FFlagCreateMomentsToast and captureObject then
            local var4 = fetchCapturesFromGallery()
            captureObject = findMatchingCapture(var4, captureObject) or captureObject
        end

        arg1:dispatch(ToastTriggered(CapturesToastType.CaptureTakenWithMomentsCTA, { captureInfo = captureObject }))

        callback(EventNames.CapturesCreateMomentToastViewed)
    end

    return captureSavedHandler
end

return makeCaptureSavedHandler
