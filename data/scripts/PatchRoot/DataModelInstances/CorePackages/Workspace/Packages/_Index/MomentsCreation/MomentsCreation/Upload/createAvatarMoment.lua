-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local Promise = require(MomentsCreationParent.Promise)

local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local createAvatarMomentLook = require(MomentsCreation.Requests.createAvatarMomentLook)
local makePostMetadata = require(MomentsCreation.Utils.makePostMetadata)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function fireAvatarMomentFailure(str1: string, str2: string, str3: string?)
    local tbl1 = {
        status = "GenericFailure",
        error = `{str1}: {str2}`
    }
    for value, value2 in makeCreationEventFields.makeCreationBaseFields(str3) do
        tbl1[value] = value2
    end
    fireAnalyticsEvent(EventNames.UploadCaptureFailed, tbl1)
end

local function postAvatarMoment(arg1, outfitId: number, edits, description: string, str1: string?, commentsEnabled: boolean?, arg2): boolean
    local postMetadata = makePostMetadata({ description = description, edits = edits, commentsEnabled = commentsEnabled }, nil, str1)

    postMetadata.media = {{
        avatar = {
            outfitId = outfitId,
            cameraData = arg1.AvatarPost.cameraData
        }
    }}

    local success, result = pcall(function()
        (arg2 or game:GetService("MomentsService")):CreatePostAsync(postMetadata)
    end)
    if not success then
        warn(`[MomentsCreation] Avatar Moment post failed: {tostring(result)}`)
        fireAvatarMomentFailure("AvatarPostFailed", tostring(result), str1)
        return false
    end

    local creationBaseFields = makeCreationEventFields.makeCreationBaseFields(str1)
    creationBaseFields.captureType = "avatar"
    fireAnalyticsEvent(EventNames.EditingFlowMomentPublished, creationBaseFields)
    return true
end

local function createAvatarMoment(arg1, edits, description: string, str1: string?, commentsEnabled: boolean?, arg2)
    local success, result = pcall(arg1.AvatarPost.getLookRequest)
    if not success then
        warn(`[MomentsCreation] Failed to build Avatar Look request: {tostring(result)}`)
        local tbl1 = {
            status = "GenericFailure",
            error = `AvatarPostLookCreationFailed: {tostring(result)}`
        }

        for value, value2 in makeCreationEventFields.makeCreationBaseFields(str1) do
            tbl1[value] = value2
        end
        fireAnalyticsEvent(EventNames.UploadCaptureFailed, tbl1)

        return Promise.resolve(false)
    end

    return createAvatarMomentLook(result):andThen(function(arg3)
        if arg3.statusCode < 200 or arg3.statusCode >= 300 then
            warn(`[MomentsCreation] Avatar Look creation failed with HTTP {arg3.statusCode}`)
            fireAvatarMomentFailure("AvatarPostLookCreationFailed", `HTTP {arg3.statusCode}`, str1)
            return false
        end
        if arg3.outfitId ~= nil and not (arg3.outfitId <= 0) then
            return (postAvatarMoment(arg1, arg3.outfitId, edits, description, str1, commentsEnabled, arg2))
        end

        warn("[MomentsCreation] Avatar Look response is missing a positive outfitId")
        local tbl1 = {
            status = "GenericFailure",
            error = "AvatarPostLookCreationFailed: MissingPositiveOutfitId"
        }

        for value, value2 in makeCreationEventFields.makeCreationBaseFields(str1) do
            tbl1[value] = value2
        end

        fireAnalyticsEvent(EventNames.UploadCaptureFailed, tbl1)

        return false
    end):catch(function(arg3): boolean
        warn(`[MomentsCreation] Avatar Look request failed: {tostring(arg3)}`)
        local str2 = tostring(arg3)
        local var1 = str1
        local tbl1 = {
            status = "GenericFailure",
            error = `AvatarPostLookCreationFailed: {str2}`
        }
        for value, value2 in makeCreationEventFields.makeCreationBaseFields(var1) do
            tbl1[value] = value2
        end
        fireAnalyticsEvent(EventNames.UploadCaptureFailed, tbl1)

        return false
    end)
end

return createAvatarMoment
