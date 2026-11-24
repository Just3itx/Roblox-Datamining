-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)
local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local FFlagCapturesInExpUseMomentsCreation = require(scriptParentParent.Flags.FFlagCapturesInExpUseMomentsCreation)
local FFlagCapturesInExpMomentFailedToast = require(scriptParentParent.Flags.FFlagCapturesInExpMomentFailedToast)

if FFlagCapturesInExpUseMomentsCreation then
    local momentsCreation = require(scriptParentParentParent.MomentsCreation)
    local _momentsTypes = require(scriptParentParentParent.MomentsTypes)
    local publishMomentWithTags = momentsCreation.publishMomentWithTags

    return function(arg1, arg2, arg3, str1: string?, num1: number?, bool1: boolean?)
        return function(arg4)
            if publishMomentWithTags(arg1, arg2, arg3, str1, num1, bool1, FFlagCapturesInExpMomentFailedToast and function()
                arg4:dispatch(ToastTriggered(CapturesToastType.MomentFailed))
            end or nil) then
                arg4:dispatch(ToastTriggered(CapturesToastType.MomentProcessing))
            end
        end
    end
end

local _MomentsCreationFlow = require(scriptParentParentParent.MomentsCreationFlow)
local MomentsCreation = require(scriptParentParentParent.MomentsCreation)
local MomentsCommon = require(scriptParentParentParent.MomentsCommon)
local _MomentsTypes = require(scriptParentParentParent.MomentsTypes)
local normalizeMomentMetadata = require(scriptParentParent.Utils.normalizeMomentMetadata)

local GetFFlagMomentsUseUploadPostAsync = MomentsCommon.Flags.GetFFlagMomentsUseUploadPostAsync
local GetFFlagMomentsUseMomentsServiceForUpload = MomentsCommon.Flags.GetFFlagMomentsUseMomentsServiceForUpload
local makePostMetadata = MomentsCreation.makePostMetadata

return function(capture: Capture, arg1, feedRegistrationInfo, arg2)
    return function(arg3)
        local momentMetadata = normalizeMomentMetadata(arg1)

        if GetFFlagMomentsUseUploadPostAsync() then
            local postMetadata = makePostMetadata(arg1, if GetFFlagMomentsUseMomentsServiceForUpload() then capture else nil)
            pcall(function()
                if GetFFlagMomentsUseMomentsServiceForUpload() then
                    (arg2 or game:GetService("MomentsService")):CreatePostAsync(postMetadata)
                    return
                end
                CaptureService:UploadPostAsync(capture, postMetadata)
            end)
        else
            pcall(function()
                CaptureService:UploadCaptureAndPostMoment(capture, momentMetadata, feedRegistrationInfo)
            end)
        end
        arg3:dispatch(ToastTriggered(CapturesToastType.MomentProcessing))
    end
end
