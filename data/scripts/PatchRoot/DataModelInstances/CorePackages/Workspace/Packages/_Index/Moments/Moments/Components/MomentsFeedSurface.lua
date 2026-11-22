-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local View = Foundation.View
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode

local Feed = require(Moments.Components.Feed)
local Constants = require(Moments.Constants)
local MomentsHostContext = require(Moments.MomentsHostContext)
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed
local FFlagProfileRenderAvatarMoments = require(MomentsParent.SharedFlags).FFlagProfileRenderAvatarMoments

local Feed2 = Feed.Feed

local function MomentsFeedSurface(tbl1)
    local bottomInset = tbl1.bottomInset or 0
    local var1 = if FFlagProfileRenderAvatarMoments then MomentsHostContext.useMomentsHost() else nil
    local bool1 = var1 == nil or var1.isTopShell ~= false
    local backgroundStyle = FFlagMomentsRenderAvatarPostsInFeed and { Transparency = 1 } or nil

    local feed = React.createElement(Feed2, {
        source = tbl1.source,
        active = not (FFlagProfileRenderAvatarMoments and not bool1) and tbl1.active,
        playbackActive = not (FFlagProfileRenderAvatarMoments and not bool1) and tbl1.playbackActive,
        telemetry = tbl1.telemetry,
        inactiveDestination = tbl1.inactiveDestination,
        controllerRef = tbl1.controllerRef,
        initialIndex = tbl1.initialIndex,
        trackSurfaceLoad = tbl1.trackSurfaceLoad,
        emptyState = tbl1.emptyState,
        caughtUpState = tbl1.caughtUpState
    })
    local renderFeedContainer = tbl1.renderFeedContainer
    local feedContainer = if renderFeedContainer ~= nil then renderFeedContainer(feed) else React.createElement(
        View,
        {
            backgroundStyle = backgroundStyle,
            tag = "size-full",
            padding = bottomInset > 0 and {
                bottom = UDim.new(0, bottomInset)
            } or nil,
            ZIndex = Constants.DisplayOrder.Feed
        },
        { Feed = feed }
    )
    return React.createElement(View, {
        backgroundStyle = backgroundStyle,
        tag = {
            ["size-full"] = FFlagMomentsRenderAvatarPostsInFeed,
            ["size-full bg-surface-0"] = not FFlagMomentsRenderAvatarPostsInFeed
        }
    }, {
        FoundationContainer = React.createElement(View, {
            backgroundStyle = backgroundStyle,
            tag = "size-full"
        }, {
            OnVideoUI = React.createElement(
                FoundationProvider,
                {
                    colorMode = ColorMode.Dark
                },
                {
                    FeedContainer = feedContainer,
                    Header = tbl1.header
                }
            )
        })
    })
end
return MomentsFeedSurface
