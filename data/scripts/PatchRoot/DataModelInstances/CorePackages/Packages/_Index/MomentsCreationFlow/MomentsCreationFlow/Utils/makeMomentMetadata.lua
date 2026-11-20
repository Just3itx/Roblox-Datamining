-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)

local function makeMomentMetadata(arg1, description: string?, edits)
    return {
        assetTotalDuration = if arg1.CaptureType == Enum.CaptureType.Screenshot then MomentsCommon.Constants.ScreenshotMusicDuration else arg1.TimeLength,
        captureType = arg1.CaptureType,
        description = description,
        universeId = arg1.SourceUniverseId,
        placeId = arg1.SourcePlaceId,
        edits = edits
    }
end

return makeMomentMetadata
