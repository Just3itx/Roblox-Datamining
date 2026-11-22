-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local FIntSocalCarouselMaxNewRequestsCount = require(SocialCarousel.Flags.FIntSocalCarouselMaxNewRequestsCount)

local function getBadgeAnalyticsFields(newRequestCount: number, badgeEnabled: boolean)
    return {
        newRequestCount = newRequestCount,
        badgeEnabled = badgeEnabled,
        badgeShown = badgeEnabled and newRequestCount > 0,
        badgeCapped = FIntSocalCarouselMaxNewRequestsCount < newRequestCount
    }
end

return getBadgeAnalyticsFields
