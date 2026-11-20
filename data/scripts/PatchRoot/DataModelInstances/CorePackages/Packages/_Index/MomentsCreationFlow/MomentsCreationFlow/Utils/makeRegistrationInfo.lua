-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)

local AttributeType = MomentsCommon.Enums.AttributeType
local getTagsForMoment = MomentsCommon.Utils.getTagsForMoment

local function makeRegistrationInfo(arg1, arg2)
    local edits = arg2.edits
    local attributes = {}
    local assetTotalDuration

    if edits and edits.trim then
        table.insert(
            attributes,
            {
                AssetId = 0,
                Description = AttributeType.PrimaryAsset,
                TrimStartTime = edits.trim.startTime
            }
        )
        assetTotalDuration = edits.trim.endTime - edits.trim.startTime
    else
        table.insert(attributes, { AssetId = 0, Description = AttributeType.PrimaryAsset, TrimStartTime = 0 })

        assetTotalDuration = arg2.assetTotalDuration
    end

    if edits and edits.music then
        table.insert(
            attributes,
            {
                AssetId = edits.music.assetId,
                Description = AttributeType.Music,
                TrimStartTime = edits.music.startTime
            }
        )
    end
    return {
        attributes = attributes,
        contentType = if arg1.CaptureType == Enum.CaptureType.Screenshot then Enum.RecommendationItemContentType.Static else Enum.RecommendationItemContentType.Dynamic,
        customTags = getTagsForMoment(arg2),
        duration = assetTotalDuration
    }
end

return makeRegistrationInfo
