-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function makeJoinImpressionFields(arg1, str1: string): {feedItemId: any, feedSessionId: any, source: string, surface: string}?
    local recommendationMetadata = arg1.recommendationMetadata
    local feedItemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId

    if feedItemId == nil or feedItemId == "" then
        MomentsCommon.Analytics.reportMomentSkip(
            "join_impression",
            if feedItemId == nil then "nil" else "empty",
            { entry = str1 }
        )
        return nil
    end

    local tbl1 = {
        feedItemId = feedItemId,
        feedSessionId = recommendationMetadata.tracingId or "",
        source = str1,
        surface = "feed_cta"
    }

    local universeId = arg1.metadata.universeId
    if universeId ~= nil and universeId > 0 then
        tbl1.destinationUniverseId = tostring(universeId)
    end

    return tbl1
end

return makeJoinImpressionFields
