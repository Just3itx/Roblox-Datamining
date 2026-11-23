-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local Constants = require(AppChat.Constants)
local RoundedVariant = require(AppChat.Enums.RoundedVariant)

local FoundationText = Foundation.Text
local Skeleton = Foundation.Skeleton
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue

local useAbbreviatedNumberLocalization = require(AppChatParent.Localization).Hooks.useAbbreviatedNumberLocalization

local GameCardThumbnail = require(script.Parent.GameCardThumbnail)

local tbl1 = {
    thumbnailAspectRatio = 16 / 9,
    thumbnailRoundedVariant = RoundedVariant.Top,
    isRepliedTo = false,
    isIncoming = false,
    isPending = false
}

function GameCardGroupable(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useTokens()
    local var3 = useAbbreviatedNumberLocalization(var1.gamePlayerCount)
    local size1600 = var2.Size.Size_1600
    local uDim2 = UDim2.fromOffset(
        useScaledValue(Constants.GameCard.THUMBNAIL_WIDTH),
        useScaledValue(Constants.GameCard.THUMBNAIL_HEIGHT)
    )
    local uDim2_2 = UDim2.new(1, 0, 0, size1600)
    local textStyle = if var1.isRepliedTo then var2.Color.Content.Default else var2.Color.Content.Emphasis
    local createElement = React.createElement
    local var5 = View
    local tbl3 = {
        tag = "col auto-xy",
        LayoutOrder = var1.LayoutOrder
    }
    local tbl4 = {
        ThumbnailContainer = React.createElement(View, { Size = uDim2, LayoutOrder = 1 }, {
            Thumbnail = React.createElement(GameCardThumbnail, {
                LayoutOrder = 1,
                gameThumbnail = var1.gameThumbnail,
                roundedVariant = var1.thumbnailRoundedVariant,
                aspectRatio = var1.thumbnailAspectRatio,
                onActivated = var1.onThumbnailActivated,
                Visible = not var1.isLoading
            })
        }),
        Footer = 0
    }

    local createElement2 = React.createElement
    local var6 = View
    local tbl5 = { tag = "padding-medium", Size = uDim2_2, LayoutOrder = 2 }

    local tbl6 = {
        Skeleton = React.createElement(View, {
            tag = "col size-full-full gap-xsmall",
            Visible = var1.isLoading
        }, {
            TitleSkeleton = React.createElement(
                View,
                {
                    tag = "grow-4",
                    Size = UDim2.new(0.9, 0, 0, 0),
                    LayoutOrder = 1
                },
                { React.createElement(Skeleton, { tag = "size-full-full", radius = Foundation.Enums.Radius.Small }) }
            ),
            MetadataSkeleton = React.createElement(
                View,
                {
                    tag = "grow-3",
                    Size = UDim2.new(0.5, 0, 0, 0),
                    LayoutOrder = 2
                },
                { React.createElement(Skeleton, { tag = "size-full-full", radius = Foundation.Enums.Radius.Small }) }
            )
        }),
        Content = 0
    }

    local createElement3 = React.createElement
    local var7 = View
    local tbl7 = {
        tag = "row size-full-full gap-small items-center align-y-center flex-between",
        Visible = not var1.isLoading
    }
    local tbl8 = { TextContainer = 0, PlayButton = 0 }
    local createElement4 = React.createElement
    local var8 = View
    local tbl9 = {
        tag = "col size-0-full fill align-y-center radius-small",
        LayoutOrder = 1,
        onActivated = var1.onMetadataActivated,
        Selectable = var1.onMetadataActivated ~= nil
    }
    local tbl10 = {
        Title = if var1.gameName then React.createElement(FoundationText, {
            tag = "auto-y size-full-500 text-title-medium text-align-x-left text-truncate-split",
            Text = var1.gameName,
            textStyle = textStyle,
            LayoutOrder = 1
        }) else nil,
        Metadata = 0
    }
    local var9

    if var1.gameRating or var3 then
        local createElement5 = React.createElement
        local var10 = View
        local tbl11 = {
            tag = "row auto-y size-full-500 gap-medium align-y-center",
            LayoutOrder = 2
        }

        local tbl12 = { RatingContainer = 0, PlayerCountContainer = 0 }
        local element

        if var1.gameRating then
            element = React.createElement(View, {
                tag = "auto-xy row gap-xsmall align-y-center",
                LayoutOrder = 1
            }, {
                RatingIcon = React.createElement(Icon, { name = IconName.ThumbUp, size = IconSize.Small, LayoutOrder = 1 }),
                Rating = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-body-small content-default text-truncate-split",
                        Text = var1.gameRating,
                        LayoutOrder = 2
                    }
                )
            })
        else
            element = nil
        end

        tbl12.RatingContainer = element

        tbl12.PlayerCountContainer = if var3 then React.createElement(
            View,
            { tag = "auto-xy row gap-xsmall align-y-center", LayoutOrder = 2 },
            {
                PlayerCountIcon = React.createElement(Icon, { name = IconName.PersonPlay, size = IconSize.Small, LayoutOrder = 1 }),
                PlayerCount = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-body-small content-default text-truncate-split",
                        Text = var3,
                        LayoutOrder = 2
                    }
                )
            }
        ) else nil
        var9 = createElement5(var10, tbl11, tbl12)
    else
        var9 = nil
    end

    tbl10.Metadata = var9
    tbl8.TextContainer = createElement4(var8, tbl9, tbl10)
    local element

    if var1.onPlayButtonActivated and var1.playButtonLabel then
        element = React.createElement(Foundation.Button, {
            text = var1.playButtonLabel,
            variant = Foundation.Enums.ButtonVariant.SubEmphasis,
            size = Foundation.Enums.InputSize.Small,
            onActivated = var1.onPlayButtonActivated,
            LayoutOrder = 2
        })
    elseif var1.onPlayButtonActivated then
        element = React.createElement(Foundation.IconButton, {
            icon = IconName.PlayLarge,
            isCircular = true,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            onActivated = var1.onPlayButtonActivated,
            LayoutOrder = 2
        })
    else
        element = nil
    end

    tbl8.PlayButton = element
    tbl6.Content = createElement3(var7, tbl7, tbl8)
    tbl4.Footer = createElement2(var6, tbl5, tbl6)
    return createElement(var5, tbl3, tbl4)
end

return React.memo(GameCardGroupable)
