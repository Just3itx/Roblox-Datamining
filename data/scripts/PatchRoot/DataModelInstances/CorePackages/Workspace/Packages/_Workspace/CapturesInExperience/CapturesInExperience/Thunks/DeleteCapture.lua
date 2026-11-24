-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = game:GetService("CaptureService")

local RetrieveCaptures = require(scriptParentParent.Thunks.RetrieveCaptures)

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)
local FFlagCapturesVideoDeleteAsync = require(scriptParentParent.Flags.FFlagCapturesVideoDeleteAsync)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

return function(arg1)
    return function(arg2)
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            CaptureService:DeleteCapturesAsync({ arg1 })
        elseif FFlagUseRbxstorageInGallery and arg1.type == CaptureType.Video then
            if FFlagCapturesVideoDeleteAsync then
                CaptureService:DeleteVideoCaptureAsync(arg1.videoCapture)
            else
                CaptureService:DeleteVideoCapture(arg1.videoCapture)
            end
        else
            CaptureService:DeleteCapture(arg1.filePath)
        end
        arg2:dispatch(RetrieveCaptures())
    end
end
