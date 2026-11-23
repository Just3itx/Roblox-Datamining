-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTile = script:FindFirstAncestor("UserTile")
local UserTileParent = UserTile.Parent
local React = require(UserTileParent.React)
local Foundation = require(UserTileParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local llama = require(UserTileParent.LuaSocialLibrariesDeps).llama
local useLocalization = require(UserTileParent.Localization).Hooks.useLocalization
local VerifiedBadge = require(UserTileParent.VerifiedBadges.VerifiedBadge)

local Constants = require(UserTile.Constants)
local LayoutMode = require(script.Parent.Parent.Enums.LayoutMode)

local TextKeys = require(UserTile.TextKeys)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local Enums = Foundation.Enums
local StateLayerAffordance = Enums.StateLayerAffordance
local Radius = Enums.Radius
local IconSize = Enums.IconSize
local FFlagProfilePlatformNewProfileHeader = require(UserTileParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local FFlagUserTileShowShimmerWhenLoading = require(UserTile.Flags.FFlagUserTileShowShimmerWhenLoading)
local FFlagUserTileShowBadges = require(UserTileParent.SharedFlags).FFlagUserTileShowBadges
local FFlagEnableBlackbirdCheck = require(UserTileParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagHidePremiumIconography = require(UserTileParent.SharedFlags).FFlagHidePremiumIconography
local FFlagEnableMobileGameJoinCard = require(UserTileParent.SharedFlags).FFlagEnableMobileGameJoinCard
local FFlagUserTileAddContextualInfoIcon = require(UserTileParent.SharedFlags).FFlagUserTileAddContextualInfoIcon
local bool1 = game:DefineFastFlag("UserTileRemoveContextualInfoTag", false)
local FFlagUserTileTitleStackAddExtraInfo = require(UserTileParent.SharedFlags).FFlagUserTileTitleStackAddExtraInfo
local FFlagUserTileUnfilteredChatIndicator = require(UserTileParent.SharedFlags).FFlagUserTileUnfilteredChatIndicator
local FFlagUnifyVerifiedBadgeComponent = require(UserTileParent.SharedFlags).FFlagUnifyVerifiedBadgeComponent
local FFlagSocialCarouselInGameTitleMarquee = require(UserTileParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee

local tbl1 = { layoutOrder = 2 }

local function TitleStack(tbl2)
    local var1 = llama.Dictionary.join(tbl1, tbl2 or {})
    local var2 = useTokens()
    local str1 = if var1.layoutMode == LayoutMode.compact then "align-x-center" else "align-x-left"
    local titleIcon = if var1.titleIcon then React.createElement(Image, { Image = var1.titleIcon, tag = "size-300-300 radius-circle", LayoutOrder = 1 }) else nil
    local subtitle = if typeof(var1.subtitle) == "string" then var1.subtitle else nil
    local subtitle2 = if FFlagSocialCarouselInGameTitleMarquee and typeof(var1.subtitle) == "table" then var1.subtitle else nil
    local bool2 = not (var1.contextualInfo and not subtitle) and (var1.layoutMode == LayoutMode.compact or subtitle ~= nil)
    local yOffset = (var1.titleStyle or var2.Typography.TitleMedium).FontSize - var2.Padding.XSmall * 2
    local yOffset2 = (var1.subtitleStyle or var2.Typography.BodyMedium).FontSize - var2.Padding.XSmall * 2
    local yOffset3 = (var1.contextualInfoStyle or var2.Typography.BodySmall).FontSize - var2.Padding.XSmall * 2

    local yOffset4 = if FFlagUserTileTitleStackAddExtraInfo then (var1.extraInfoStyle or var2.Typography.BodySmall).FontSize - var2.Padding.XSmall * 2 else 0
    local bool3 = if FFlagUserTileShowShimmerWhenLoading then var1.layoutMode == LayoutMode.compact else nil
    local xScale, xScale2, xScale3, xScale4

    if FFlagUserTileShowShimmerWhenLoading then
        if bool3 then
            xScale = Constants.TITLE_SHIMMER_WIDTH_SCALE_COMPACT
            xScale2 = Constants.SUBTITLE_SHIMMER_WIDTH_SCALE_COMPACT
            xScale3 = Constants.CONTEXTUAL_INFO_SHIMMER_WIDTH_SCALE_COMPACT
            xScale4 = Constants.EXTRA_INFO_SHIMMER_WIDTH_SCALE_COMPACT
        else
            xScale = Constants.TITLE_SHIMMER_WIDTH_SCALE_WIDE
            xScale2 = Constants.SUBTITLE_SHIMMER_WIDTH_SCALE_WIDE
            xScale3 = Constants.CONTEXTUAL_INFO_SHIMMER_WIDTH_SCALE_WIDE
            xScale4 = Constants.EXTRA_INFO_SHIMMER_WIDTH_SCALE_WIDE
        end
    else
        xScale = nil
        xScale2 = nil
        xScale3 = nil
        xScale4 = nil
    end

    local str2 = if FFlagUserTileShowShimmerWhenLoading and var1.layoutMode == LayoutMode.compact then "align-x-center" else "align-x-left"

    local str3 = if var1.layoutMode == LayoutMode.compact then "size-full-0" else "grow"

    local textTruncate = var1.customTextTruncation or Enum.TextTruncate.AtEnd
    local bool4 = if FFlagEnableBlackbirdCheck then var1.isRobloxSubscriber == true else nil
    local var4 = not FFlagHidePremiumIconography and var1.isPremium and not bool4
    local var5 = useLocalization({ trustedLabel = TextKeys.trustedLabel, unfilteredChatLabel = TextKeys.unfilteredChatLabel })

    local var6 = FFlagUserTileUnfilteredChatIndicator and var1.shouldShowUnfilteredChatIndicator == true
    local bool5 = (var1.trustedConnectionIndicatorEnabled and var1.isTrustedConnection) == true
    local bool6 = not (subtitle == nil) and subtitle ~= ""
    local createElement = React.createElement
    local var7 = View
    local tbl3 = {
        tag = `{str3} auto-y col`,
        LayoutOrder = var1.layoutOrder
    }
    local tbl4 = { Title = 0, Subtitle = 0, ContextualInfo = 0, ExtraInfo = 0 }
    local element2

    if FFlagUserTileShowShimmerWhenLoading and var1.isTitleLoading then
        element2 = React.createElement(
            View,
            {
                tag = `size-full-0 auto-y padding-xsmall {str2}`,
                LayoutOrder = 1
            },
            {
                TitleSkeleton = React.createElement(Skeleton, { Size = UDim2.new(xScale, 0, 0, yOffset), radius = Radius.Small })
            }
        )
    else
        local createElement2 = React.createElement
        local var8 = View
        local tbl5 = {
            tag = `size-full-0 row auto-y gap-xxsmall align-y-center {str1}`,
            LayoutOrder = 1
        }
        local tbl6 = { TitleIcon = titleIcon, TitleText = 0 }
        local var9

        if FFlagProfilePlatformNewProfileHeader then
            var9 = var1.title

            if var9 then
                local createElement3 = React.createElement
                local var10 = View
                local tbl7 = {
                    tag = {
                        ["row align-y-center gap-xsmall content-emphasis"] = true,
                        ["auto-xy text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                        ["auto-y size-full-0 text-align-x-left"] = var1.layoutMode == LayoutMode.wide
                    },
                    LayoutOrder = 2
                }

                local tbl8 = {
                    Title = React.createElement(FoundationText, {
                        tag = {
                            ["shrink content-default auto-xy"] = true,
                            ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide,
                            ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact
                        },
                        fontStyle = var1.titleStyle or var2.Typography.TitleMedium,
                        Text = var1.title,
                        LayoutOrder = 1,
                        RichText = true,
                        TextTruncate = textTruncate
                    }),
                    BadgesRow = 0
                }
                local var11

                if FFlagUserTileShowBadges then
                    local createElement4 = React.createElement
                    local var12 = View
                    local tbl9 = {
                        tag = "row align-y-center auto-xy content-default gap-xxsmall",
                        ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide,
                        ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                        LayoutOrder = 2
                    }
                    local tbl10 = {
                        VerifiedBadge = 0,
                        SubscriptionBadge = 0,
                        PremiumBadge = 0,
                        AdminBadge = 0
                    }
                    local isVerified = var1.isVerified

                    if isVerified then
                        if FFlagUnifyVerifiedBadgeComponent then
                            isVerified = React.createElement(VerifiedBadge, { size = IconSize.Large, LayoutOrder = 2 })
                        else
                            isVerified = React.createElement(View, {
                                tag = "auto-xy content-default",
                                LayoutOrder = 2
                            }, {
                                VerifiedBackplateIcon = React.createElement(Foundation.Icon, {
                                    name = Foundation.Enums.IconName.VerifiedBackplate,
                                    size = Foundation.Enums.IconSize.Large,
                                    style = var2.Color.System.Emphasis,
                                    AnchorPoint = Vector2.new(0, 0),
                                    Position = UDim2.fromScale(0, 0),
                                    ZIndex = 1
                                }),
                                VerifiedCheckIcon = React.createElement(Foundation.Icon, {
                                    name = Foundation.Enums.IconName.VerifiedCheck,
                                    size = Foundation.Enums.IconSize.Large,
                                    style = {
                                        Color3 = Color3.fromRGB(255, 255, 255),
                                        Transparency = 0
                                    },
                                    AnchorPoint = Vector2.new(0, 0),
                                    Position = UDim2.fromScale(0, 0),
                                    ZIndex = 2
                                })
                            })
                        end
                    end

                    tbl10.VerifiedBadge = isVerified

                    tbl10.SubscriptionBadge = if bool4 then React.createElement(Foundation.Icon, {
                        name = Foundation.Enums.IconName.RobloxPlus,
                        size = Foundation.Enums.IconSize.Small,
                        style = var2.Color.Content.Emphasis,
                        LayoutOrder = 3
                    }) else nil

                    tbl10.PremiumBadge = if var4 then React.createElement(
                        Foundation.Icon,
                        {
                            name = Foundation.Enums.IconName.Premium,
                            size = Foundation.Enums.IconSize.Large,
                            LayoutOrder = 4
                        }
                    ) else nil

                    tbl10.AdminBadge = var1.isRobloxAdmin
                        and React.createElement(
                            Foundation.Icon,
                            {
                                name = Foundation.Enums.IconName.Tilt,
                                size = Foundation.Enums.IconSize.Large,
                                LayoutOrder = 5
                            }
                        )
                    var11 = createElement4(var12, tbl9, tbl10)
                else
                    var11 = nil
                end

                tbl8.BadgesRow = var11
                var9 = createElement3(var10, tbl7, tbl8)
            end
        elseif var1.title then
            var9 = React.createElement(FoundationText, {
                tag = {
                    ["content-emphasis"] = true,
                    ["auto-xy text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                    ["auto-y size-full-0 text-align-x-left"] = var1.layoutMode == LayoutMode.wide
                },
                fontStyle = var1.titleStyle or var2.Typography.TitleMedium,
                Text = var1.title,
                LayoutOrder = 2,
                RichText = true,
                TextTruncate = textTruncate
            })
                or nil
        else
            var9 = nil
        end

        tbl6.TitleText = var9
        element2 = createElement2(var8, tbl5, tbl6)
    end

    tbl4.Title = element2

    if not subtitle2 then
        if FFlagUserTileShowShimmerWhenLoading and var1.isSubtitleLoading then
            subtitle2 = React.createElement(
                View,
                {
                    tag = `size-full-0 auto-y padding-xsmall {str2}`,
                    LayoutOrder = 2
                },
                {
                    SubtitleSkeleton = React.createElement(Skeleton, { Size = UDim2.new(xScale2, 0, 0, yOffset2), radius = Radius.Small })
                }
            )
        elseif bool2 or var6 then
            local createElement2 = React.createElement
            local var8 = View

            local tbl5 = {
                tag = {
                    ["row auto-y size-full-0 align-y-center"] = true,
                    ["align-x-center"] = var1.layoutMode == LayoutMode.compact,
                    ["align-x-left"] = var1.layoutMode == LayoutMode.wide
                },
                LayoutOrder = 2,
                onActivated = (FFlagProfilePlatformNewProfileHeader or FFlagEnableMobileGameJoinCard) and var1.onSubtitleClicked and function()
                    var1.onSubtitleClicked()
                end or nil,
                stateLayer = (FFlagProfilePlatformNewProfileHeader or FFlagEnableMobileGameJoinCard)
                    and var1.onSubtitleClicked
                    and {
                        affordance = StateLayerAffordance.None
                    }
                    or nil
            }

            local tbl6 = {
                SubtitleText = React.createElement(FoundationText, {
                    tag = {
                        ["auto-xy shrink content-default"] = true,
                        ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                        ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide
                    },
                    fontStyle = var1.subtitleStyle or var2.Typography.BodyMedium,
                    Text = subtitle or "",
                    LayoutOrder = 1,
                    RichText = true,
                    TextTruncate = textTruncate
                }),
                TCTextLabel = 0,
                UnfilteredChatLabel = 0
            }
            local element3

            if var1.trustedConnectionIndicatorEnabled and var1.isTrustedConnection then
                element3 = React.createElement(FoundationText, {
                    tag = {
                        ["auto-xy content-default"] = true,
                        ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                        ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide
                    },
                    fontStyle = var1.subtitleStyle or var2.Typography.BodyMedium,
                    Text = (if FFlagUserTileUnfilteredChatIndicator and not bool6 then "" else " • ") .. var5.trustedLabel,
                    LayoutOrder = 2,
                    RichText = true,
                    TextTruncate = textTruncate
                })
            else
                element3 = nil
            end

            tbl6.TCTextLabel = element3
            local element4

            if var6 then
                element4 = React.createElement(FoundationText, {
                    tag = {
                        ["auto-xy content-default"] = true,
                        ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                        ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide
                    },
                    fontStyle = var1.subtitleStyle or var2.Typography.BodyMedium,
                    Text = (if bool6 or bool5 then " • " else "") .. var5.unfilteredChatLabel,
                    LayoutOrder = 3,
                    RichText = true,
                    TextTruncate = textTruncate
                })
            else
                element4 = nil
            end

            tbl6.UnfilteredChatLabel = element4
            subtitle2 = createElement2(var8, tbl5, tbl6)
        else
            subtitle2 = nil
        end
    end

    tbl4.Subtitle = subtitle2
    local element3

    if FFlagUserTileShowShimmerWhenLoading and var1.isContextualInfoLoading then
        element3 = React.createElement(
            View,
            {
                tag = `size-full-0 auto-y padding-xsmall {str2}`,
                LayoutOrder = 3
            },
            {
                ContextualInfoSkeleton = React.createElement(Skeleton, { Size = UDim2.new(xScale3, 0, 0, yOffset3), radius = Radius.Small })
            }
        )
    elseif var1.contextualInfo then
        local element4

        if FFlagUserTileAddContextualInfoIcon and var1.contextualInfoIcon then
            element4 = React.createElement(View, {
                tag = {
                    ["row align-y-center gap-xsmall size-full-0 auto-y"] = true,
                    ["align-x-center"] = var1.layoutMode == LayoutMode.compact,
                    ["align-x-left"] = var1.layoutMode == LayoutMode.wide
                },
                LayoutOrder = 3
            }, {
                ContextualInfoIcon = React.createElement(Icon, { name = var1.contextualInfoIcon, size = IconSize.XSmall, LayoutOrder = 1 }),
                ContextualInfoText = React.createElement(FoundationText, {
                    tag = {
                        ["content-secondary shrink auto-xy"] = not bool1,
                        ["shrink auto-xy"] = bool1
                    },
                    fontStyle = var1.contextualInfoStyle or var2.Typography.BodySmall,
                    TextTruncate = textTruncate,
                    Text = var1.contextualInfo,
                    LayoutOrder = 2,
                    RichText = true
                })
            })
        else
            element4 = React.createElement(FoundationText, {
                tag = {
                    ["auto-y size-full-0 content-secondary"] = not bool1,
                    ["size-full-0 auto-y"] = bool1,
                    ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                    ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide
                },
                fontStyle = var1.contextualInfoStyle or var2.Typography.BodySmall,
                TextTruncate = textTruncate,
                Text = var1.contextualInfo,
                LayoutOrder = 3,
                RichText = true
            })
        end

        element3 = element4 or nil
    else
        element3 = nil
    end

    tbl4.ContextualInfo = element3
    local element4

    if FFlagUserTileTitleStackAddExtraInfo and var1.isExtraInfoLoading then
        element4 = React.createElement(
            View,
            {
                tag = `size-full-0 auto-y padding-xsmall {str2}`,
                LayoutOrder = 4
            },
            {
                ExtraInfoSkeleton = React.createElement(Skeleton, { Size = UDim2.new(xScale4, 0, 0, yOffset4), radius = Radius.Small })
            }
        )
    elseif FFlagUserTileTitleStackAddExtraInfo and var1.extraInfo then
        element4 = React.createElement(FoundationText, {
            tag = {
                ["size-full-0 auto-y"] = true,
                ["text-align-x-center"] = var1.layoutMode == LayoutMode.compact,
                ["text-align-x-left"] = var1.layoutMode == LayoutMode.wide
            },
            fontStyle = var1.extraInfoStyle or var2.Typography.BodySmall,
            TextTruncate = textTruncate,
            Text = var1.extraInfo,
            LayoutOrder = 4,
            RichText = true,
            onActivated = var1.onExtraInfoClicked,
            stateLayer = var1.onExtraInfoClicked and {
                affordance = StateLayerAffordance.None
            } or nil
        })
    else
        element4 = nil
    end

    tbl4.ExtraInfo = element4
    return createElement(var7, tbl3, tbl4)
end

return TitleStack
