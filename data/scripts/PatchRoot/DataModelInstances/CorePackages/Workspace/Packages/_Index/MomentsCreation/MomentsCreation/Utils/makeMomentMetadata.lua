-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local Constants = require(MomentsCreation.Constants)

local function makeMomentMetadata(arg1, description: string?, edits, num1: number?, commentsEnabled: boolean?)
    local tbl1 = {
        assetTotalDuration = 0,
        captureType = 0,
        description = 0,
        universeId = 0,
        placeId = 0,
        edits = 0,
        commentsEnabled = 0
    }

    if arg1.CaptureType == Enum.CaptureType.Screenshot then
        num1 = Constants.ScreenshotMusicDuration
    elseif num1 == nil or not (num1 > 0) then
        num1 = arg1.TimeLength
    end

    tbl1.assetTotalDuration = num1

    tbl1.captureType = arg1.CaptureType
    tbl1.description = description
    tbl1.universeId = arg1.SourceUniverseId
    tbl1.placeId = arg1.SourcePlaceId
    tbl1.edits = edits
    tbl1.commentsEnabled = commentsEnabled
    return tbl1
end

return makeMomentMetadata
