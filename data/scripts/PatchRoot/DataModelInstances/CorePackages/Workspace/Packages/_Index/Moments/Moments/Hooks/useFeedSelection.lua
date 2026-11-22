-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local createMockFeedSource = require(Moments.Components.Feed.Sources.createMockFeedSource)
local FollowingFeedState = require(Moments.Components.FollowingFeedState)
local MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)
local createFollowingFeedSource = require(Moments.Stores.GetMomentsStore.createFollowingFeedSource)
local isStudio = require(MomentsParent.MomentsCommon.isStudio)
local GetFFlagArgusStudioMockFeed = require(Moments.Flags.GetFFlagArgusStudioMockFeed)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)
local FFlagMomentsRecommendationFeedType = require(Moments.Flags.FFlagMomentsRecommendationFeedType)

local function getFeedTypeDestination(trending) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if FFlagMomentsNavigationEvent and trending == MomentsFeedType.Trending then NavigationDestinationType.Trending else nil
end

local function createFollowingSource() -- Luacid: Inlined by compiler; 1 call site recovered
    if isStudio() and GetFFlagArgusStudioMockFeed() then
        return createMockFeedSource()
    end
    return createFollowingFeedSource()
end

local function useFeedSelection(tbl1)
    local refreshFeed = tbl1.refreshFeed
    local flushView = tbl1.flushView
    local selected, var2 = React.useState(MomentsFeedType.Trending)
    local var3 = React.useRef(selected)
    local var4 = React.useRef(nil)

    local getSelected = React.useCallback(function()
        return var3.current
    end, {})

    local select = React.useCallback(function(current)
        if var3.current == current then
            refreshFeed((getFeedTypeDestination(current)))
            return
        end

        flushView((getFeedTypeDestination(current)))
        var3.current = current
        var2(current)
    end, { refreshFeed, flushView })

    local bool1 = selected == MomentsFeedType.Following
    if bool1 and var4.current == nil then
        var4.current = createFollowingSource()
    end
    local current = var4.current
    if not bool1 or current == nil then
        current = tbl1.trendingSource
    end

    local trendingTelemetry = if bool1 then nil else tbl1.trendingTelemetry

    if FFlagMomentsRecommendationFeedType and bool1 then
        trendingTelemetry = tbl1.followingTelemetry
    end

    local var7 = React.useMemo(function()
        if not bool1 then
            return {}
        end
        local function onViewRecommended()
            select(MomentsFeedType.Trending)
        end
        return {
            emptyState = React.createElement(FollowingFeedState, { variant = "empty", onViewRecommended = onViewRecommended }),
            caughtUpState = React.createElement(FollowingFeedState, { variant = "caughtUp", onViewRecommended = onViewRecommended })
        }
    end, { bool1, select })

    return React.useMemo(function()
        return {
            selected = selected,
            getSelected = getSelected,
            select = select,
            source = current,
            telemetry = trendingTelemetry,
            emptyState = var7.emptyState,
            caughtUpState = var7.caughtUpState
        }
    end, {
        selected,
        getSelected,
        select,
        current,
        trendingTelemetry,
        var7
    })
end
return useFeedSelection
