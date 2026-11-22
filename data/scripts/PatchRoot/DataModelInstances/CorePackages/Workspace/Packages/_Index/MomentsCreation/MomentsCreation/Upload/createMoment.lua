-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local normalizeMomentMetadata = require(MomentsCreation.Utils.normalizeMomentMetadata)
local GetFFlagMomentsUseUploadPostAsync = MomentsCommon.Flags.GetFFlagMomentsUseUploadPostAsync
local GetFFlagMomentsUseMomentsServiceForUpload = MomentsCommon.Flags.GetFFlagMomentsUseMomentsServiceForUpload
local makePostMetadata = require(MomentsCreation.Utils.makePostMetadata)
local FFlagMomentsCreationSessionId = require(MomentsCreation.Flags.FFlagMomentsCreationSessionId)

local game2 = game

local engineFeature = game:GetEngineFeature("CaptureServiceUploadUniverseIdOverride")

game:DefineFastString("MomentsUploadUniverseId", "8357232245")

local function injectUniverseIdOverride(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local gameId = game2.GameId
    if gameId ~= nil and gameId > 0 then
        return arg1
    end
    local var1 = table.clone(arg1)
    var1.universeIdOverride = tonumber(game:GetFastString("MomentsUploadUniverseId"))
    return var1
end

local function createMoment(capture: Capture, arg1, feedRegistrationInfo, str1: string?, arg2): boolean
    local var1 = if engineFeature then injectUniverseIdOverride(arg1) else arg1
    local momentMetadata = normalizeMomentMetadata(var1)
    local success, result

    if GetFFlagMomentsUseUploadPostAsync() then
        local postMetadata = makePostMetadata(
            arg1,
            if GetFFlagMomentsUseMomentsServiceForUpload() then capture else nil,
            if FFlagMomentsCreationSessionId then str1 else nil
        )

        success, result = pcall(function()
            if GetFFlagMomentsUseMomentsServiceForUpload() then
                (arg2 or game:GetService("MomentsService")):CreatePostAsync(postMetadata)
                return
            end
            CaptureService:UploadPostAsync(capture, postMetadata)
        end)
    else
        success, result = pcall(function()
            CaptureService:UploadCaptureAndPostMoment(capture, momentMetadata, feedRegistrationInfo)
        end)
    end

    if success then
        local captureDescriptorFields = makeCreationEventFields.makeCaptureDescriptorFields(capture)
        for value, value2 in makeCreationEventFields.makeCreationBaseFields(str1) do
            captureDescriptorFields[value] = value2
        end
        fireAnalyticsEvent(EventNames.EditingFlowMomentPublished, captureDescriptorFields)
        return true
    end

    local tbl1 = {
        captureType = makeCreationEventFields.enumName(capture.CaptureType),
        localId = tostring(capture.LocalId),
        error = tostring(result),
        status = "GenericFailure"
    }

    for value, value2 in makeCreationEventFields.makeCreationBaseFields(str1) do
        tbl1[value] = value2
    end
    fireAnalyticsEvent(EventNames.UploadCaptureFailed, tbl1)
    return false
end

return createMoment
