-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local GetFFlagMomentsStickerButton = require(MomentsCreationParent.MomentsCommon).Flags.GetFFlagMomentsStickerButton

local function makeRegistrationInfo(arg1, arg2, customTags)
    local edits = arg2.edits
    local attributes = {}
    local assetTotalDuration

    if edits and edits.trim then
        table.insert(attributes, { AssetId = 0, Description = "PrimaryAsset", TrimStartTime = edits.trim.startTime })

        assetTotalDuration = edits.trim.endTime - edits.trim.startTime
    else
        table.insert(attributes, { AssetId = 0, Description = "PrimaryAsset", TrimStartTime = 0 })

        assetTotalDuration = arg2.assetTotalDuration
    end

    if edits and edits.music then
        table.insert(
            attributes,
            {
                AssetId = edits.music.assetId,
                Description = "Music",
                TrimStartTime = edits.music.startTime
            }
        )
    end
    if GetFFlagMomentsStickerButton() and edits and edits.stickerOverlays then
        for _, stickerOverlay in edits.stickerOverlays do
            if not stickerOverlay.stickerURI then
                continue
            end

            table.insert(attributes, { AssetId = 0, Description = "Sticker", Text = stickerOverlay.stickerURI })
        end
    end

    return {
        attributes = attributes,
        contentType = if arg1.CaptureType == Enum.CaptureType.Screenshot then Enum.RecommendationItemContentType.Static else Enum.RecommendationItemContentType.Dynamic,
        customTags = customTags or {},
        duration = assetTotalDuration
    }
end

return makeRegistrationInfo
