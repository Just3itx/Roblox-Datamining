-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function makePostFeedbackEventFields(tbl1)
    local publishedMoment = tbl1.publishedMoment
    local feedItemId = if publishedMoment == nil then nil else publishedMoment.recommendationMetadata.feedItemId
    local tbl2 = {
        creationSessionId = tbl1.creationSessionId,
        localId = tbl1.localId,
        captureType = if tbl1.captureType == nil then nil else tbl1.captureType.Name,
        momentId = if publishedMoment == nil then nil else publishedMoment.momentId,
        feedItemId = 0
    }
    if feedItemId == nil or feedItemId == "" then
        feedItemId = nil
    end

    tbl2.feedItemId = feedItemId
    return tbl2
end

return makePostFeedbackEventFields
