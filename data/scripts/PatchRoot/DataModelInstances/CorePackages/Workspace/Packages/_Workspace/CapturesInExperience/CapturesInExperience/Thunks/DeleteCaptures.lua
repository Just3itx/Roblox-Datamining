-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = game:GetService("CaptureService")

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local RetrieveCaptures = require(scriptParentParent.Thunks.RetrieveCaptures)

local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

return function(tbl1)
    local pathArr = {}
    for _, value in ipairs(tbl1) do
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            table.insert(pathArr, value)
        elseif FFlagUseRbxstorageInGallery and value.type == CaptureType.Video then
            table.insert(pathArr, value.videoCapture)
        elseif value.type == CaptureType.Screenshot then
            table.insert(pathArr, value.filePath)
        end
    end

    return function(arg1)
        CaptureService:DeleteCapturesAsync(pathArr)
        arg1:dispatch(RetrieveCaptures())
    end
end
