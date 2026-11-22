-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Players = game:GetService("Players")

local MomentsCommon = require(MomentsParent.MomentsCommon)

local function firePostInsightsCoachmarkEvent(str1: string)
    MomentsCommon.Analytics.fireAnalyticsEvent(str1, {
        userId = tostring(if Players.LocalPlayer then Players.LocalPlayer.UserId else 0),
        timestamp = tostring(os.time()),
        identifier = "moments_post_insights"
    })
end

return firePostInsightsCoachmarkEvent
