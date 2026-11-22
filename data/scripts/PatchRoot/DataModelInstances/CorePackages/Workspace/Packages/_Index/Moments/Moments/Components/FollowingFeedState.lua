-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local FoundationCloudAssets = require(MomentsParent.FoundationCloudAssets)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local FeedMessageView = require(Moments.Components.Feed.FeedMessageView)
local useIsPersonalizedFeed = require(Moments.Hooks.useIsPersonalizedFeed)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    emptyTitle = "Feature.Moments.Label.FollowingEmptyTitle",
    emptyBodyRecommended = "Feature.Moments.Description.FollowingEmptyBodyRecommended",
    emptyBodyTrending = "Feature.Moments.Description.FollowingEmptyBodyTrending",
    emptyActionRecommended = "Feature.Moments.Action.ViewRecommended",
    emptyActionTrending = "Feature.Moments.Action.ViewTrending",
    caughtUpTitle = "Feature.Moments.Label.FollowingCaughtUpTitle",
    caughtUpBody = "Feature.Moments.Description.FollowingCaughtUpBody",
    caughtUpAction = "Feature.Moments.Action.ViewOtherFeed"
}

local tbl2 = {
    emptyTitle = "Follow creators to view their Moments",
    emptyBodyRecommended = "Enjoy Moments from your favorites after you follow a few creators. View recommended to find some.",
    emptyBodyTrending = "Enjoy Moments from your favorites after you follow a few creators. View trending to find some.",
    emptyActionRecommended = "View recommended",
    emptyActionTrending = "View trending",
    caughtUpTitle = "You're caught up for now",
    caughtUpBody = "You've watched all the new Moments in this feed. Switch feeds to view more.",
    caughtUpAction = "View other feed"
}

FoundationCloudAssets.preloadAsset("pictograms/magnifyglassperson")

local function FollowingFeedState(tbl3)
    local var1 = useLocalization(tbl1)
    local var2 = useIsPersonalizedFeed()

    local function text(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var3 = var1[str1]
        return if var3 == nil or var3 == "" then tbl2[str1] else var3
    end

    local bool1 = tbl3.variant == "empty"
    return React.createElement(FeedMessageView, {
        LayoutOrder = tbl3.LayoutOrder,
        iconName = if bool1 then nil else "icons/brands/moments_large",
        tilted = true,
        pictogram = if bool1 then "pictograms/magnifyglassperson" else nil,
        title = text(if bool1 then "emptyTitle" else "caughtUpTitle"),
        description = text(if bool1 then if var2 then "emptyBodyRecommended" else "emptyBodyTrending" else "caughtUpBody"),
        primaryAction = {
            text = text(if bool1 then if var2 then "emptyActionRecommended" else "emptyActionTrending" else "caughtUpAction"),
            onActivated = tbl3.onViewRecommended,
            testId = "--moments-following-view-recommended"
        },
        testId = if bool1 then "--moments-following-empty" else "--moments-following-caught-up"
    })
end

return FollowingFeedState
