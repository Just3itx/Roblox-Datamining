-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local _MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local MomentsHeaderContainer = require(Moments.Components.MomentsHeader.MomentsHeaderContainer)
local FFlagMomentsCreateAvatarPosts = require(MomentsParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = { defaultTitle = "Feature.Moments.Label.MomentsExperienceName" }

local function TopBar(tbl2)
    local var1 = useLocalization(tbl1)

    return React.createElement(MomentsHeaderContainer, {
        layoutOrder = tbl2.layoutOrder,
        variant = if tbl2.isBaseScreen then "base" else "close",
        showFtuxTooltip = tbl2.showFtuxTooltip,
        onFtuxTooltipDismissed = tbl2.onFtuxTooltipDismissed,
        onCreatePressed = tbl2.onCreatePressed,
        onCreateAvatarMomentPressed = if FFlagMomentsCreateAvatarPosts then tbl2.onCreateAvatarMomentPressed else nil,
        onClose = tbl2.onClose,
        onNavigateToTrending = tbl2.onNavigateToTrending,
        onNavigateToMyMoments = tbl2.onNavigateToMyMoments,
        title = tbl2.title or var1.defaultTitle,
        showTopScrim = tbl2.showTopScrim,
        animateWithImmersiveChrome = true,
        showHamburger = tbl2.showHamburger,
        selectedFeedType = tbl2.selectedFeedType,
        onFeedTypeSelected = tbl2.onFeedTypeSelected
    })
end

return TopBar
