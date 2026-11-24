-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local Rodux = require(scriptParentParentParent.Rodux)

local CapturesRetrieved = require(scriptParentParent.Actions.CapturesRetrieved)
local CaptureType = require(scriptParentParent.Enums.CaptureType)
local CarouselClosed = require(scriptParentParent.Actions.CarouselClosed)
local CarouselIndexSelected = require(scriptParentParent.Actions.CarouselIndexSelected)
local CarouselOpened = require(scriptParentParent.Actions.CarouselOpened)
local DeleteWarningModalClosed = require(scriptParentParent.Actions.DeleteWarningModalClosed)
local DeleteWarningModalOpened = require(scriptParentParent.Actions.DeleteWarningModalOpened)
local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local function findNewSelectedCaptureIndex(captures, selectedCaptureIndex: number, selectedCapture)
    if not FFlagUseRbxstorageInGallery
        and captures[selectedCaptureIndex] ~= nil
        and captures[selectedCaptureIndex].filePath == selectedCapture.filePath
        and not FFlagEnableCapturesGalleryRetrievalCoreScript
    then
        return selectedCaptureIndex
    end

    return Cryo.List.findWhere(captures, function(arg1): boolean
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            return tostring(arg1.CaptureTime.UnixTimestampMillis) == tostring(selectedCapture.CaptureTime.UnixTimestampMillis)
        end

        if FFlagUseRbxstorageInGallery and arg1.type == CaptureType.Video and selectedCapture.type == CaptureType.Video then
            return arg1.thumbnailKey == selectedCapture.thumbnailKey
        end

        if FFlagUseRbxstorageInGallery and arg1.type == CaptureType.Screenshot and selectedCapture.type == CaptureType.Screenshot then
            return arg1.filePath == selectedCapture.filePath
        end

        if FFlagUseRbxstorageInGallery then
            return false
        end

        return arg1.filePath == selectedCapture.filePath
    end)
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CapturesRetrieved.name] = function(tbl2, arg1)
    if tbl2.IsOpen == false then
        return tbl2
    end

    if #arg1.captures == 0 then
        return Cryo.Dictionary.join(tbl2, { IsOpen = false, SelectedCaptureIndex = 0 })
    end

    if arg1.selectedCapture == nil then
        local capturesLen = #arg1.captures
        return Cryo.Dictionary.join(tbl2, { SelectedCaptureIndex = math.min(tbl2.SelectedCaptureIndex, capturesLen) })
    end

    assert(arg1.selectedCapture ~= nil, "CapturesRetrieved selectedCapture should not be nil")
    local selectedCapture = arg1.selectedCapture

    local selectedCaptureIndex = findNewSelectedCaptureIndex(arg1.captures, tbl2.SelectedCaptureIndex, selectedCapture)

    if selectedCaptureIndex == tbl2.SelectedCaptureIndex then
        return tbl2
    end

    if selectedCaptureIndex ~= nil then
        return Cryo.Dictionary.join(tbl2, { SelectedCaptureIndex = selectedCaptureIndex })
    end

    local capturesLen = #arg1.captures
    return Cryo.Dictionary.join(tbl2, { SelectedCaptureIndex = math.clamp(tbl2.SelectedCaptureIndex - 1, 1, capturesLen) })
end

tbl1[CarouselClosed.name] = function(tbl2, _)
    return Cryo.Dictionary.join(tbl2, { IsOpen = false, SelectedCaptureIndex = 0 })
end

tbl1[CarouselIndexSelected.name] = function(tbl2, tbl3)
    return Cryo.Dictionary.join(tbl2, { SelectedCaptureIndex = tbl3.index })
end

tbl1[CarouselOpened.name] = function(tbl2, tbl3)
    return Cryo.Dictionary.join(tbl2, { IsOpen = true, SelectedCaptureIndex = tbl3.index })
end

tbl1[DeleteWarningModalClosed.name] = function(tbl2, _)
    return Cryo.Dictionary.join(tbl2, { IsDeleteWarningModalOpen = false })
end

tbl1[DeleteWarningModalOpened.name] = function(tbl2, _)
    return Cryo.Dictionary.join(tbl2, { IsDeleteWarningModalOpen = true })
end

return createReducer({ IsOpen = false, IsDeleteWarningModalOpen = false, SelectedCaptureIndex = 0 }, tbl1)
