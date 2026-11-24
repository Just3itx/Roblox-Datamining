-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = require(scriptParentParent.Services.CaptureService)

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)

local _Types = require(scriptParentParent.Types)

local FFlagCapturesVideoBulkManagerStopGap = require(scriptParentParent.Flags.FFlagCapturesVideoBulkManagerStopGap)
local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local FFlagCapturesInExpMomentsToastDownloadButton = require(scriptParentParent.Flags.FFlagCapturesInExpMomentsToastDownloadButton)

return function(tbl1)
    local tbl2 = {}
    for _, value in ipairs(tbl1) do
        if FFlagCapturesInExpMomentsToastDownloadButton
            and not FFlagEnableCapturesGalleryRetrievalCoreScript
            and typeof(value) ~= "table"
        then
            table.insert(tbl2, value)
        elseif FFlagEnableCapturesGalleryRetrievalCoreScript then
            if FFlagCapturesVideoBulkManagerStopGap then
                table.insert(tbl2, (CaptureService:PreCaptureShared(value)))
            else
                table.insert(tbl2, value)
            end
        elseif FFlagUseRbxstorageInGallery and value.type == CaptureType.Video then
            table.insert(tbl2, (CaptureService:PreVideoCaptureShared(value.videoCapture)))
        elseif value.type == CaptureType.Screenshot then
            table.insert(tbl2, value.filePath)
        end
    end

    return function(arg1)
        CaptureService:SaveCapturesToExternalStorageAsync(tbl2)
        arg1:dispatch(ToastTriggered(CapturesToastType.CaptureSavedToDevice, { captureInfo = tbl1[1] }))
    end
end
