-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local useFeed = require(Moments.Components.Feed.FeedContext).useFeed
local MomentOverlayInsetContext = require(Moments.Components.Feed.Items.Moment.MomentOverlayInsetContext)
local MomentUnavailableView = require(script.Parent.MomentUnavailableView)
local useIsPagerItemActive = require(Moments.Components.VerticalPager).useIsPagerItemActive
local FFlagMomentsFeedAboveNavBar = require(Moments.Flags.FFlagMomentsFeedAboveNavBar)

local usePreferences = Foundation.Hooks.usePreferences

local function MomentUnavailableItem(tbl1)
    local var1 = useFeed()
    local reducedMotion = usePreferences().reducedMotion
    local var2 = MomentOverlayInsetContext.useMomentOverlayInset()

    local bottomInset = if FFlagMomentsFeedAboveNavBar then 0 else var2
    local var4 = useIsPagerItemActive()

    local scrollToNext = var1.scrollToNext
    local onNext = React.useCallback(function()
        if scrollToNext ~= nil then
            scrollToNext()
        end
    end, { scrollToNext })

    return React.createElement(MomentUnavailableView, {
        LayoutOrder = tbl1.LayoutOrder,
        isModerated = tbl1.isModerated,
        onNext = onNext,
        animate = var1.isActiveFeed and var1.isPlaybackActive and var4 and not reducedMotion,
        bottomInset = bottomInset
    })
end

return MomentUnavailableItem
