-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Button = Foundation.Button
local IconButton = Foundation.IconButton
local Skeleton = Foundation.Skeleton
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset

local Constants = require(AppChat.Constants)
local getGroupCornerRadii = require(AppChat.Components.ChatConversation.Grouping.getGroupCornerRadii)
local loadFoundationCloudAsset = require(AppChat.Utils.loadFoundationCloudAsset)
local Status = require(script.Parent.AssetCardTypes).Status

local var1 = table.freeze({ Color3 = Color3.new(1, 1, 1), Transparency = 1 })

local function ErrorContent(tbl1)
    local image = React.useMemo(function()
        return (loadFoundationCloudAsset("pictograms/alert"))
    end, {})

    return React.createElement(
        View,
        {
            tag = "col align-x-center gap-small size-full-0 auto-y padding-xxlarge",
            testId = "AssetCardError"
        },
        {
            Pictogram = React.createElement(
                Image,
                {
                    tag = "size-1600 content-system-contrast",
                    Image = image,
                    ScaleType = Enum.ScaleType.Fit,
                    LayoutOrder = 1
                }
            ),
            Text = if tbl1.text then React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-center content-system-contrast",
                Text = tbl1.text,
                LayoutOrder = 2
            }) else nil
        }
    )
end

local function Media(tbl1)
    local var2 = useTokens()
    local var3 = if tbl1.isPictogram then tbl1.pictogramScale or 0.66 else 1

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "bg-shift-200",
        testId = "AssetCardMedia",
        Size = UDim2.fromOffset(tbl1.width, math.round(tbl1.width / tbl1.aspectRatio)),
        cornerRadius = tbl1.cornerRadii,
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.isDisabled,
        selection = {
            Selectable = tbl1.isSelectable
        },
        cursor = {
            radius = tbl1.cursorRadius
        },
        ref = tbl1.mediaRef,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Image = 0, Overlay = 0 }
    local element

    if tbl1.image then
        element = React.createElement(Image, {
            tag = "position-center-center anchor-center-center",
            testId = "AssetCardMediaImage",
            Size = UDim2.fromScale(var3, var3),
            ImageContent = tbl1.image,
            ScaleType = if tbl1.isPictogram then Enum.ScaleType.Fit else Enum.ScaleType.Crop,
            imageStyle = if tbl1.isImageLoading then var1 elseif tbl1.isPictogram then var2.Color.Content.Emphasis else nil,
            cornerRadius = tbl1.cornerRadii,
            ZIndex = 1
        })
    else
        element = nil
    end

    tbl3.Image = element

    tbl3.Overlay = if tbl1.overlayIcon then React.createElement(View, {
        tag = "row align-x-center align-y-center position-center-center anchor-center-center size-1200-1200 radius-circle bg-over-media-0",
        testId = "AssetCardMediaOverlay",
        ZIndex = 3
    }, {
        Icon = React.createElement(Icon, { name = tbl1.overlayIcon, size = IconSize.Medium, style = var2.Color.Content.Emphasis })
    }) else nil
    return createElement(var4, tbl2, tbl3)
end

local function SkeletonRow(tbl1)
    return React.createElement(
        View,
        {
            tag = `row align-y-center {tbl1.heightTag}`,
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            Skeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(tbl1.width, 1), radius = Radius.Small, testId = tbl1.testId })
        }
    )
end

local function Title(tbl1)
    local var2 = useTokens()
    local var3 = useTextSizeOffset()

    if tbl1.isLoading then
        return React.createElement(
            SkeletonRow,
            {
                heightTag = "size-full-500",
                width = 0.6,
                testId = "AssetCardTitleSkeleton",
                LayoutOrder = tbl1.LayoutOrder
            }
        )
    end

    if tbl1.text == nil then
        return nil
    end

    local titleMedium = var2.Typography.TitleMedium
    local y = math.ceil((titleMedium.FontSize + var3) * titleMedium.LineHeight * tbl1.maxLines)

    return React.createElement(FoundationText, {
        tag = {
            ["size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis"] = true,
            ["text-wrap"] = tbl1.maxLines > 1
        },
        testId = "AssetCardTitle",
        Text = tbl1.text,
        sizeConstraint = tbl1.maxLines > 1 and {
            MaxSize = Vector2.new(math.huge, y)
        } or nil,
        LayoutOrder = tbl1.LayoutOrder
    })
end

local function Subtitle(tbl1)
    if not tbl1.isLoading and tbl1.text == nil then
        return nil
    end

    local tag = {
        ["row align-y-center gap-xsmall"] = true,
        ["size-full-500"] = tbl1.isLoading,
        ["size-full-0 auto-y"] = not tbl1.isLoading
    }

    return React.createElement(View, {
        tag = tag,
        testId = "AssetCardSubtitle",
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Icon = if tbl1.icon then React.createElement(
            Icon,
            {
                name = tbl1.icon,
                size = IconSize.Small,
                testId = "AssetCardSubtitleIcon",
                LayoutOrder = 1
            }
        ) else nil,
        Text = if tbl1.isLoading then React.createElement(
            Skeleton,
            {
                Size = UDim2.fromScale(0.7, 1),
                radius = Radius.Small,
                testId = "AssetCardSubtitleSkeleton",
                LayoutOrder = 2
            }
        ) else React.createElement(FoundationText, {
            tag = "fill auto-y text-body-medium text-align-x-left text-truncate-end content-default",
            Text = tbl1.text,
            LayoutOrder = 2
        })
    })
end

local function GameStat(tbl1)
    return React.createElement(View, {
        tag = "row align-y-center gap-xsmall auto-xy",
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Icon = React.createElement(Icon, { name = tbl1.icon, size = IconSize.Small, LayoutOrder = 1 }),
        Text = React.createElement(
            FoundationText,
            {
                tag = "auto-xy text-body-small content-default",
                Text = tbl1.text,
                LayoutOrder = 2
            }
        )
    })
end

local function GameStats(tbl1)
    if tbl1.isLoading then
        return React.createElement(
            SkeletonRow,
            {
                heightTag = "size-full-400",
                width = 0.4,
                testId = "AssetCardGameStatsSkeleton",
                LayoutOrder = tbl1.LayoutOrder
            }
        )
    end

    if tbl1.rating == nil and tbl1.playerCount == nil then
        return nil
    end

    return React.createElement(View, {
        tag = "row align-y-center gap-medium size-full-0 auto-y",
        testId = "AssetCardGameStats",
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Rating = if tbl1.rating then React.createElement(GameStat, { icon = IconName.ThumbUp, text = tbl1.rating, LayoutOrder = 1 }) else nil,
        PlayerCount = if tbl1.playerCount then React.createElement(GameStat, { icon = IconName.PersonPlay, text = tbl1.playerCount, LayoutOrder = 2 }) else nil
    })
end

local function ActionButton(tbl1)
    if tbl1.label then
        return React.createElement(Button, {
            text = tbl1.label,
            icon = tbl1.icon,
            variant = tbl1.variant or ButtonVariant.Standard,
            size = InputSize.Small,
            onActivated = tbl1.onActivated,
            Selectable = tbl1.isSelectable,
            testId = "AssetCardAction",
            LayoutOrder = tbl1.LayoutOrder
        })
    elseif tbl1.icon == nil then
        return nil
    end

    return React.createElement(IconButton, {
        icon = tbl1.icon,
        isCircular = true,
        variant = ButtonVariant.Emphasis,
        size = InputSize.Medium,
        onActivated = tbl1.onActivated,
        Selectable = tbl1.isSelectable,
        testId = "AssetCardAction",
        LayoutOrder = tbl1.LayoutOrder
    })
end

return React.memo(function(arg1) -- name: AssetCardView
    local var2 = useTokens()
    local width = useScaledValue(Constants.AssetCard.WIDTH)
    local size500 = var2.Size.Size_500
    local uDim = UDim.new(0, size500)
    local media = arg1.media
    local footer = arg1.footer
    local bool1 = arg1.status == Status.Ready
    local bool2 = arg1.status == Status.Error
    local isSelectable = bool1 and media.isSelectable

    local cornerRadius = getGroupCornerRadii(arg1.groupShape, size500)

    local cornerRadii = footer and {
        topLeft = cornerRadius.topLeft,
        topRight = cornerRadius.topRight,
        bottomLeft = 0,
        bottomRight = 0
    }
        or cornerRadius

    local createElement = React.createElement
    local var4 = View
    local tbl1 = {
        tag = "col auto-y",
        testId = "AssetCardView",
        Size = UDim2.fromOffset(width, 0),
        backgroundStyle = var2.Color.Shift.Shift_400,
        cornerRadius = cornerRadius,
        LayoutOrder = arg1.LayoutOrder
    }
    local tbl2 = {
        Error = if bool2 then React.createElement(ErrorContent, { text = arg1.errorText }) else nil,
        Media = 0,
        Footer = 0
    }
    local element

    if bool2 then
        element = nil
    else
        element = React.createElement(Media, {
            image = if bool1 then media.image else nil,
            isImageLoading = media.isLoading == true,
            aspectRatio = media.aspectRatio,
            isPictogram = media.isPictogram == true,
            pictogramScale = media.pictogramScale,
            overlayIcon = media.overlayIcon,
            onActivated = media.onActivated,
            isDisabled = not bool1,
            isSelectable = isSelectable,
            width = width,
            cornerRadii = cornerRadii,
            cursorRadius = uDim,
            mediaRef = if isSelectable then arg1.mediaRef else nil,
            LayoutOrder = 1
        })
    end

    tbl2.Media = element
    local var5

    if bool2 or not footer then
        var5 = nil
    else
        local createElement2 = React.createElement
        local var6 = View
        local tbl3 = {
            tag = "row align-y-center gap-medium size-full-0 auto-y padding-medium",
            testId = "AssetCardFooter",
            LayoutOrder = 2
        }

        local tbl4 = { TextColumn = 0, Action = 0 }
        local createElement3 = React.createElement
        local var7 = View
        local tbl5 = {
            tag = "col fill gap-xsmall auto-y",
            testId = "AssetCardFooterText",
            onActivated = footer.onActivated,
            isDisabled = not bool1,
            selection = { Selectable = false },
            cursor = { radius = uDim },
            LayoutOrder = 1
        }
        local tbl6 = {
            Title = React.createElement(Title, {
                text = footer.titleText,
                maxLines = footer.titleMaxLines or 1,
                isLoading = footer.isTitleLoading == true,
                LayoutOrder = 1
            }),
            Subtitle = React.createElement(Subtitle, {
                text = footer.subtitleText,
                icon = footer.subtitleIcon,
                isLoading = footer.isSubtitleLoading == true,
                LayoutOrder = 2
            }),
            GameStats = React.createElement(GameStats, {
                rating = if footer.gameStats then footer.gameStats.rating else nil,
                playerCount = if footer.gameStats then footer.gameStats.playerCount else nil,
                isLoading = footer.isGameStatsLoading == true,
                LayoutOrder = 3
            })
        }
        tbl4.TextColumn = createElement3(var7, tbl5, tbl6)
        local element2

        if bool1 and footer.action then
            element2 = React.createElement(ActionButton, {
                label = footer.action.label,
                variant = footer.action.variant,
                icon = footer.action.icon,
                onActivated = footer.action.onActivated,
                isSelectable = footer.action.isSelectable,
                LayoutOrder = 2
            })
        else
            element2 = nil
        end

        tbl4.Action = element2
        var5 = createElement2(var6, tbl3, tbl4)
    end

    tbl2.Footer = var5
    return createElement(var4, tbl1, tbl2)
end)
