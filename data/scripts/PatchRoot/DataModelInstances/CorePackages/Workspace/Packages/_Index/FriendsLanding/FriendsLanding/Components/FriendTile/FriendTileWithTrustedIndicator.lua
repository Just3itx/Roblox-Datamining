-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)

local React = dependencies.React
local useLocalization = require(FriendsLandingParent.Localization).Hooks.useLocalization
local llama = require(FriendsLandingParent.LuaSocialLibrariesDeps).llama
local VerifiedBadges = require(FriendsLandingParent.VerifiedBadges)

local UIBlox = dependencies.UIBlox
local useStyle = UIBlox.Core.Style.useStyle
local PlayerTile = UIBlox.App.Tile.PlayerTile
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport
local PlayerContext = UIBlox.App.Indicator.PlayerContext

local _PresenceType = dependencies.RoduxPresence.Enums.PresenceType

local Foundation = require(FriendsLandingParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local FoundationText = Foundation.Text
local Skeleton = Foundation.Skeleton
local Enums = Foundation.Enums
local StateLayerAffordance = Enums.StateLayerAffordance

local GetFFlagLuaAppEnableOpenTypeSupport = require(FriendsLandingParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport
local FFlagEnableBlackbirdCheck = require(FriendsLandingParent.SharedFlags).FFlagEnableBlackbirdCheck

local tbl1 = {
    userPresence = nil,
    index = 1,
    openPlayerProfile = nil,
    buttons = nil,
    trustedConnection = false,
    isVerified = false
}

local function FriendTileWithTrustedIndicator(tbl2)
    tbl2 = llama.Dictionary.join(tbl1, tbl2 or {})
    local var1 = useStyle()
    local var2 = useTokens()
    local var3 = useLocalization({ trustedText = "Feature.Friends.TrustedConnection.Label.Trusted" })

    local textDefault = var1.Theme.TextDefault
    local iconColor, icon, iconTransparency

    if tbl2.relevancyInfo then
        iconColor = tbl2.relevancyInfo.iconColor
        icon = tbl2.relevancyInfo.icon
        iconTransparency = tbl2.relevancyInfo.iconTransparency
    else
        icon = nil
        iconColor = nil
        iconTransparency = nil
    end

    local createElement = React.createElement
    local var4 = View
    local tbl3 = {
        tag = "col auto-xy size-0-0 gap-small",
        onActivated = tbl2.openPlayerProfile,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }
    local tbl4 = {
        PlayerTile = React.createElement(View, {
            tag = "size-full-full aspect-1-1 bg-surface-100 clip",
            LayoutOrder = 1
        }, { React.createElement(PlayerTile, {
                tileSize = UDim2.fromScale(1, 1),
                thumbnail = tbl2.user.thumbnail,
                title = "",
                subtitle = "",
                onActivated = tbl2.openPlayerProfile,
                forwardedRef = tbl2.playerTileRef,
                buttons = tbl2.buttons,
                Selectable = false,
                openTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
            }) }),
        TextColumn = 0
    }

    local createElement2 = React.createElement
    local var5 = View
    local tbl5 = { tag = "col size-full-0 auto-y gap-xxsmall", LayoutOrder = 2 }

    local tbl6 = { Title = 0, Subtitle = 0, RelevancyContainer = 0 }
    local createElement3 = React.createElement
    local var6 = View
    local tbl7 = { tag = "auto-y size-full-0" }

    local tbl8 = {
        LoadingSkeleton = if tbl2.title then nil else React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, var2.Typography.TitleLarge.FontSize) }),
        Title = 0
    }

    local title = tbl2.title

    if title then
        title = React.createElement(View, {
            tag = "row auto-y size-full-0 align-y-center ",
            LayoutOrder = 1
        }, {
            TitleText = React.createElement(FoundationText, {
                tag = "text-truncate-end text-align-x-left auto-xy shrink content-default",
                fontStyle = var2.Typography.TitleLarge,
                Text = tbl2.title,
                LayoutOrder = 1,
                RichText = true
            }),
            VerifiedBadge = tbl2.isVerified
                and React.createElement(FoundationText, {
                    tag = "auto-xy content-default",
                    fontStyle = var2.Typography.TitleLarge,
                    Text = VerifiedBadges.emoji.verified,
                    LayoutOrder = 2,
                    RichText = true
                }),
            SubscriptionBadge = if FFlagEnableBlackbirdCheck and tbl2.isRobloxSubscriber == true then React.createElement(
                Foundation.Icon,
                {
                    name = Enums.IconName.RobloxPlus,
                    size = Enums.IconSize.Small,
                    style = var2.Color.Content.Emphasis,
                    LayoutOrder = 3
                }
            ) else nil
        })
    end

    tbl8.Title = title
    tbl6.Title = createElement3(var6, tbl7, tbl8)

    local createElement4 = React.createElement
    local var7 = View
    local tbl9 = { tag = "row auto-y size-full-0", LayoutOrder = 2 }

    local tbl10 = {
        LoadingSkeleton = if tbl2.subtitle and tbl2.subtitle ~= "@" then nil else React.createElement(Skeleton, { Size = UDim2.new(0.4, 0, 0, var2.Typography.BodySmall.FontSize) }),
        SubtitleText = 0,
        TCTextLabel = 0
    }

    local subtitle = tbl2.subtitle

    if subtitle then
        if tbl2.subtitle == "@" then
            subtitle = false
        else
            subtitle = React.createElement(FoundationText, {
                tag = "text-truncate-end auto-xy text-align-x-left shrink content-default",
                fontStyle = var2.Typography.BodySmall,
                Text = tbl2.subtitle,
                LayoutOrder = 1,
                RichText = true
            })
        end
    end

    tbl10.SubtitleText = subtitle

    local subtitle2 = tbl2.isTrustedConnection and tbl2.subtitle

    if subtitle2 then
        if tbl2.subtitle == "@" then
            subtitle2 = false
        else
            subtitle2 = React.createElement(FoundationText, {
                tag = "content-default auto-xy text-align-x-left",
                LayoutOrder = 2,
                fontStyle = var2.Typography.BodySmall,
                Text = " • " .. var3.trustedText
            })
        end
    end

    tbl10.TCTextLabel = subtitle2
    tbl6.Subtitle = createElement4(var7, tbl9, tbl10)

    local createElement5 = React.createElement
    local var8 = View
    local tbl11 = {
        tag = "size-full-0 row auto-y gap-xsmall align-x-left align-y-center",
        LayoutOrder = 3
    }

    local tbl12 = { ContextualPresence = 0 }
    local text = tbl2.relevancyInfo and tbl2.relevancyInfo.text

    if text then
        text = React.createElement(PlayerContext, {
            fontStyle = var1.Font.CaptionBody,
            icon = icon,
            iconColor = iconColor,
            iconSize = UDim2.fromOffset(12, 12),
            iconTransparency = iconTransparency,
            layoutOrder = 2,
            text = if tbl2.relevancyInfo then tbl2.relevancyInfo.text else nil,
            textColorStyle = textDefault,
            onActivated = tbl2.openPlayerProfile,
            Selectable = false
        })
    end

    tbl12.ContextualPresence = text
    tbl6.RelevancyContainer = createElement5(var8, tbl11, tbl12)
    tbl4.TextColumn = createElement2(var5, tbl5, tbl6)
    return createElement(var4, tbl3, tbl4)
end

return FriendTileWithTrustedIndicator
