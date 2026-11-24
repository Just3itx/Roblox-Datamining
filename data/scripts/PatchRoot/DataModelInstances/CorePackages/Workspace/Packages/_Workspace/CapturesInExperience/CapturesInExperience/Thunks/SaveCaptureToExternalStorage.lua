-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = require(scriptParentParent.Services.CaptureService)

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)

local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

return function(captureInfo)
    return function(arg2)
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            CaptureService:SaveCapturesToExternalStorageAsync({ captureInfo })
        elseif FFlagUseRbxstorageInGallery and captureInfo.type == CaptureType.Video then
            CaptureService:SaveVideoCaptureToExternalStorage(captureInfo.videoCapture)
        else
            CaptureService:SaveCaptureToExternalStorage(captureInfo.filePath)
        end

        arg2:dispatch(ToastTriggered(CapturesToastType.CaptureSavedToDevice, { captureInfo = captureInfo }))
    end
end
