-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Analytics = require(MomentsParent.MomentsCommon).Analytics
local EventNames = Analytics.EventNames

local function logFeedEndStateReached(tbl1)
    Analytics.fireAnalyticsEvent(EventNames.FeedEndStateReached, {
        source = tbl1.source,
        recommendationSource = tbl1.recommendationSource,
        feedSourceId = tbl1.feedSourceId,
        itemPosition = tostring(tbl1.itemPosition)
    })
end

return logFeedEndStateReached
