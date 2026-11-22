-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Localization = require(MomentsParent.Localization)

local useIsPersonalizedFeed = require(Moments.Hooks.useIsPersonalizedFeed)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    recommended = "Feature.Moments.Label.FeedRecommended",
    trending = "Feature.Moments.Label.FeedTrending"
}

local tbl2 = { recommended = "Recommended", trending = "Trending" }

local function useTrendingFeedLabel()
    local var1 = useLocalization(tbl1)
    local str1 = if useIsPersonalizedFeed() then "recommended" else "trending"
    local var2 = var1[str1]
    return if var2 == nil or var2 == "" then tbl2[str1] else var2
end

return useTrendingFeedLabel
