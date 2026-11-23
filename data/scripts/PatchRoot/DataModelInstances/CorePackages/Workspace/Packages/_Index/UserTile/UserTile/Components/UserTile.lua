-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTile = script:FindFirstAncestor("UserTile")
local UserTileParent = UserTile.Parent
local React = require(UserTileParent.React)
local Foundation = require(UserTileParent.Foundation)
local TitleStack = require(UserTile.Components.TitleStack)
local Avatar = require(UserTile.Components.Avatar)
local AvatarPile = require(UserTile.Components.AvatarPile)
local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local Enums = Foundation.Enums

local LayoutMode = require(script.Parent.Parent.Enums.LayoutMode)

local FFlagProfilePlatformNewProfileHeader = require(UserTileParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local FFlagUserTileShowShimmerWhenLoading = require(UserTile.Flags.FFlagUserTileShowShimmerWhenLoading)
local FFlagEnableBlackbirdCheck = require(UserTileParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagUserTileShowBadges = require(UserTileParent.SharedFlags).FFlagUserTileShowBadges
local FFlagEnableMobileGameJoinCard = require(UserTileParent.SharedFlags).FFlagEnableMobileGameJoinCard
local FFlagSocialCarouselInGamePlayIcon = require(UserTileParent.SharedFlags).FFlagSocialCarouselInGamePlayIcon
local FFlagUserTileAddContextualInfoIcon = require(UserTileParent.SharedFlags).FFlagUserTileAddContextualInfoIcon
local FFlagUserTileTitleStackAddExtraInfo = require(UserTileParent.SharedFlags).FFlagUserTileTitleStackAddExtraInfo
local FFlagUserTileUnfilteredChatIndicator = require(UserTileParent.SharedFlags).FFlagUserTileUnfilteredChatIndicator

local function UserTile2(tbl1)
    local hover, var2 = React.useState(false)
    local bool1 = tbl1.onActivated ~= nil
    local onStateChanged = React.useCallback(function(arg1)
        var2(bool1 and (arg1 == ControlState.Hover or arg1 == ControlState.Pressed))
        if tbl1.onStateChanged then
            tbl1.onStateChanged(arg1)
        end
    end, { tbl1.onActivated, tbl1.onStateChanged })

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = {
            ["size-full"] = true,
            ["col align-x-center gap-small"] = tbl1.layoutMode == LayoutMode.compact,
            ["row align-y-center gap-medium"] = tbl1.layoutMode == LayoutMode.wide
        },
        selection = {
            Selectable = tbl1.selectable
        },
        onStateChanged = onStateChanged,
        onActivated = tbl1.onActivated,
        stateLayer = {
            affordance = Enums.StateLayerAffordance.None
        },
        ref = if FFlagSocialCarouselInGamePlayIcon then tbl1.buttonRef else nil
    }
    local tbl3 = { AvatarThumbnail = 0, TitleStack = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = {
        tag = "size-full aspect-1-1",
        Size = tbl1.avatarSize,
        LayoutOrder = 1
    }
    local tbl5 = { AvatarComponent = 0 }
    local element

    if tbl1.facePileSecondUserId then
        element = React.createElement(AvatarPile, {
            layoutOrder = 1,
            primaryUserId = tbl1.userId,
            secondUserId = tbl1.facePileSecondUserId,
            userPresenceType = tbl1.userPresenceType,
            ZIndex = 2,
            hover = hover
        })
    else
        element = React.createElement(Avatar, {
            avatarThumbnailUrl = if FFlagUserTileShowShimmerWhenLoading then tbl1.avatarThumbnailUrl else nil,
            layoutOrder = 1,
            userId = tbl1.userId,
            userPresenceType = tbl1.userPresenceType,
            ZIndex = 2,
            hover = hover,
            backplateStyle = tbl1.backplateStyle,
            includeProfileFrame = tbl1.includeProfileFrame,
            overlayIcon = tbl1.overlayIcon
        })
    end

    tbl5.AvatarComponent = element
    tbl3.AvatarThumbnail = createElement2(var5, tbl4, tbl5)

    tbl3.TitleStack = React.createElement(TitleStack, {
        layoutOrder = 2,
        title = tbl1.title,
        isVerified = if FFlagUserTileShowBadges then tbl1.isVerified else nil,
        isPremium = if FFlagUserTileShowBadges then tbl1.isPremium else nil,
        isRobloxAdmin = if FFlagUserTileShowBadges then tbl1.isRobloxAdmin else nil,
        subtitle = tbl1.subtitle,
        contextualInfo = tbl1.contextualInfo,
        contextualInfoIcon = if FFlagUserTileAddContextualInfoIcon then tbl1.contextualInfoIcon else nil,
        layoutMode = tbl1.layoutMode,
        titleStyle = tbl1.titleStyle,
        subtitleStyle = tbl1.subtitleStyle,
        contextualInfoStyle = tbl1.contextualInfoStyle,
        ZIndex = 1,
        titleIcon = tbl1.titleIcon,
        onSubtitleClicked = if FFlagProfilePlatformNewProfileHeader or FFlagEnableMobileGameJoinCard then tbl1.onSubtitleClicked else nil,
        isTitleLoading = if FFlagUserTileShowShimmerWhenLoading then tbl1.isTitleLoading else nil,
        isSubtitleLoading = if FFlagUserTileShowShimmerWhenLoading then tbl1.isSubtitleLoading else nil,
        isContextualInfoLoading = if FFlagUserTileShowShimmerWhenLoading then tbl1.isContextualInfoLoading else nil,
        customTextTruncation = tbl1.customTextTruncation,
        isTrustedConnection = tbl1.isTrustedConnection,
        trustedConnectionIndicatorEnabled = tbl1.trustedConnectionIndicatorEnabled,
        shouldShowUnfilteredChatIndicator = if FFlagUserTileUnfilteredChatIndicator then tbl1.shouldShowUnfilteredChatIndicator else nil,
        isRobloxSubscriber = if FFlagEnableBlackbirdCheck then tbl1.isRobloxSubscriber else nil,
        extraInfo = tbl1.extraInfo,
        isExtraInfoLoading = if FFlagUserTileTitleStackAddExtraInfo then tbl1.isExtraInfoLoading else nil,
        extraInfoStyle = tbl1.extraInfoStyle,
        onExtraInfoClicked = tbl1.onExtraInfoClicked
    })
    return createElement(var4, tbl2, tbl3)
end

return UserTile2
