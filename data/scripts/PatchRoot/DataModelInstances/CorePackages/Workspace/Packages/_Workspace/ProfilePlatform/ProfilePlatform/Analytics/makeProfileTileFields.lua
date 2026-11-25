-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)

local function buildTileFields(arg1, surfaceId: string, parentEntity: string, num1: number, interactionType: string?): {feedItemId: any, parentEntity: string, surface: string, surfaceId: string, tileIndex: string}?
    local recommendationMetadata = arg1.recommendationMetadata
    local feedItemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId

    if feedItemId == nil or feedItemId == "" then
        MomentsCommon.Analytics.reportMomentSkip(
            "tile",
            if feedItemId == nil then "nil" else "empty",
            { entry = "profile", parentEntity = parentEntity }
        )
        return nil
    end
    local tbl1 = {
        surface = "profile",
        parentEntity = parentEntity,
        surfaceId = surfaceId,
        feedItemId = feedItemId,
        tileIndex = tostring(num1)
    }
    if interactionType ~= nil then
        tbl1.interactionType = interactionType
    end
    return tbl1
end

return {
    makeProfileTileImpressionFields = function(arg1, surfaceId: string, parentEntity: string, num1: number)
        return (buildTileFields(arg1, surfaceId, parentEntity, num1, nil))
    end,
    makeProfileTileInteractionFields = function(arg1, surfaceId: string, parentEntity: string, num1: number)
        return (buildTileFields(arg1, surfaceId, parentEntity, num1, "open"))
    end,
    INTERACTION_OPEN = "open"
}
