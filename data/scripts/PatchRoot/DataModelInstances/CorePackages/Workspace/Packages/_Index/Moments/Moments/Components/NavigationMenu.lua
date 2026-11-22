-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local FFlagMomentsFollowingFeed = require(Moments.Flags.FFlagMomentsFollowingFeed)
local useTrendingFeedLabel = require(Moments.Hooks.useTrendingFeedLabel)

local ThreeDotsHorizontal = BuilderIcons.Icon.ThreeDotsHorizontal

local IconButton = Foundation.IconButton
local Menu = Foundation.Menu

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local useLocalization = Localization.Hooks.useLocalization
local useToggleState = MomentsCommon.Hooks.useToggleState

local tbl1 = {
    trending = "Feature.Moments.Label.FeedTrending",
    myMoments = "Feature.Moments.Label.FeedMyMoments"
}

local function NavigationMenu(tbl2)
    local var1 = useLocalization(tbl1)
    local trending = var1.trending
    if FFlagMomentsFollowingFeed then
        trending = useTrendingFeedLabel()
    end
    local var2 = useToggleState()

    local onActivated = React.useCallback(function()
        if var2.enabled then
            var2.disable()
            return
        end
        var2.enable()
    end, { var2.enabled, var2.enable, var2.disable })

    local var3 = React.useCallback(function()
        var2.disable()
        tbl2.onNavigateToTrending()
    end, { var2.disable, tbl2.onNavigateToTrending })

    local var4 = React.useCallback(function()
        var2.disable()
        tbl2.onNavigateToMyMoments()
    end, { var2.disable, tbl2.onNavigateToMyMoments })

    local items = React.useMemo(function()
        return {
            { id = "trending", text = trending, onActivated = var3 },
            {
                id = "myMoments",
                text = var1.myMoments,
                onActivated = var4
            }
        }
    end, {
        var3,
        var4,
        var1,
        trending
    })
    local moreMenuButton = React.createElement(IconButton, {
        LayoutOrder = tbl2.layoutOrder,
        icon = ThreeDotsHorizontal,
        onActivated = onActivated,
        variant = tbl2.buttonVariant or ButtonVariant.OverMedia,
        size = InputSize.Medium,
        isCircular = true,
        Selectable = true,
        testId = tbl2.buttonTestId or "--moments-navigation-menu-button"
    })

    return React.createElement(Menu, {
        align = Foundation.Enums.PopoverAlign.End,
        isOpen = var2.enabled,
        items = items,
        LayoutOrder = tbl2.layoutOrder,
        onPressedOutside = var2.disable,
        side = Foundation.Enums.PopoverSide.Bottom
    }, { MoreMenuButton = moreMenuButton })
end

return NavigationMenu
