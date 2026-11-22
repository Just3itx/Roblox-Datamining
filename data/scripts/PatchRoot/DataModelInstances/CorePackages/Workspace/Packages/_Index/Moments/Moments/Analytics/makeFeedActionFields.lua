-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)

local function makeFeedActionFields(momentId: string, feedItemId: string?, feedSessionId: string?, action: string?)
    if feedItemId ~= nil and feedItemId ~= "" then
        return {
            momentId = momentId,
            feedItemId = feedItemId,
            feedSessionId = feedSessionId or ""
        }
    end

    MomentsCommon.Analytics.reportMomentSkip(
        "feed_action",
        if feedItemId == nil then "nil" else "empty",
        { action = action }
    )
    return nil
end

return makeFeedActionFields
