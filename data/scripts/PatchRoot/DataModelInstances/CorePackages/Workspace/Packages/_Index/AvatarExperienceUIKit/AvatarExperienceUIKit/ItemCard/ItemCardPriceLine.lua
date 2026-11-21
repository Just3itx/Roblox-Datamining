-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Badge = Foundation.Badge
local IconSize = Foundation.Enums.IconSize
local BadgeVariant = Foundation.Enums.BadgeVariant
local useTokens = Foundation.Hooks.useTokens
local useDesignTokens = require(AvatarExperienceUIKitParent.Style).useDesignTokens

local getLocalizedPrice = require(AvatarExperienceUIKit.ItemCard.Utils.getLocalizedPrice)

local FFlagAXDurablesFooter = AvatarExperienceFlags.FFlagAXDurablesFooter

local function renderIconTextPair(tbl1)
    local result = {}

    if tbl1.iconName then
        result[tbl1.iconKey] = React.createElement(Icon, {
            name = tbl1.iconName,
            style = tbl1.resolvedColorStyle,
            size = IconSize.Small,
            LayoutOrder = tbl1.iconLayoutOrder,
            testId = tbl1.iconKey
        })
    end

    result[tbl1.textKey] = React.createElement(FoundationText, {
        textStyle = tbl1.resolvedColorStyle,
        fontStyle = tbl1.tokens.Typography.BodyMedium,
        LayoutOrder = tbl1.textLayoutOrder,
        Text = tbl1.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextTruncate = Enum.TextTruncate.SplitWord
    })

    return result
end

local function renderContentChildren(tbl1, str1: string, num1: number, num2: number, resolvedColorStyle, tokens, designTokens)
    local icon = nil
    local var1, str2, str3

    if tbl1.type == "price" then
        var1 = getLocalizedPrice(tbl1.price)
        icon = "robux"
        str2 = "RobuxIcon"
        str3 = "Amount"
    elseif tbl1.type == "timedOption" then
        icon = tbl1.icon
        var1 = tbl1.text
        str2 = "TimedOptionIcon"
        str3 = "TimedOptionText"
    else
        if tbl1.type ~= "text" then
            return {}
        end

        var1 = tbl1.text
        str2 = "Text"
        str3 = "Text"
    end

    local func1 = renderIconTextPair
    local tbl2 = {
        iconName = icon,
        text = var1,
        iconKey = `{str1}{str2}`,
        textKey = `{str1}{str3}`,
        iconLayoutOrder = num1,
        textLayoutOrder = 0,
        resolvedColorStyle = 0,
        tokens = 0,
        designTokens = 0
    }

    if icon then
        num1 = num2
    end

    tbl2.textLayoutOrder = num1
    tbl2.resolvedColorStyle = resolvedColorStyle
    tbl2.tokens = tokens
    tbl2.designTokens = designTokens
    return (func1(tbl2))
end

local function ItemCardPriceLine(tbl1)
    local var1 = useTokens()
    local designTokens = useDesignTokens()

    if tbl1.content.type == "badge" then
        return (React.createElement("Frame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = tbl1.LayoutOrder
        }, {
            Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.Padding.XSmall) }),
            Badge = React.createElement(
                Badge,
                {
                    text = tbl1.content.text,
                    variant = BadgeVariant.Neutral,
                    Position = UDim2.new(0, 0, 0, -var1.Gap.XXSmall)
                }
            )
        }))
    end

    local var2 = if tbl1.content and tbl1.content.colorStyle then tbl1.content.colorStyle else var1.Color.Content.Emphasis
    local size = if tbl1.content and tbl1.content.iconSize then tbl1.content.iconSize else IconSize.Small
    local fontStyle = if tbl1.content and tbl1.content.fontStyle then tbl1.content.fontStyle else var1.Typography.BodyMedium

    if not FFlagAXDurablesFooter or tbl1.content.type ~= "multi" then
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            LayoutOrder = tbl1.LayoutOrder
        }
        local tbl3 = {
            ItemCardPriceLineLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, var1.Gap.XXSmall)
            }),
            ItemCardPriceLineRobuxIcon = if tbl1.content.type == "price" then React.createElement(Icon, { name = "robux", style = var2, size = size, LayoutOrder = 1, testId = "priceLineRobuxIcon" }) else nil,
            ItemCardPriceLineAmount = React.createElement(FoundationText, {
                textStyle = var2,
                fontStyle = fontStyle,
                LayoutOrder = 2,
                Text = if tbl1.content.type == "price" then getLocalizedPrice(tbl1.content.price) else tbl1.content.text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextTruncate = Enum.TextTruncate.SplitWord
            })
        }
        return createElement(str1, tbl2, tbl3)
    end

    local content = tbl1.content
    local tbl2 = {
        ItemCardPriceLineLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.Gap.XXSmall)
        })
    }
    local num1 = 1
    for k, content2 in content.contents do
        if k > 1 then
            local str1 = `priceLineSpacer{k}`
            tbl2[str1] = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(var1.Gap.XSmall, 0),
                    LayoutOrder = num1
                }
            )
            num1 += 1
        end
        if content2.type == "badge" then
            local str1 = `priceLine{k}Badge`
            tbl2[str1] = React.createElement(
                Badge,
                {
                    text = content2.text,
                    variant = BadgeVariant.Neutral,
                    Position = UDim2.new(0, 0, 0, -var1.Gap.XXSmall)
                }
            )
            num1 += 1
        else
            local resolvedColorStyle = if content2.colorStyle then content2.colorStyle else var1.Color.Content.Emphasis

            for value, value2 in (renderContentChildren(content2, `priceLine{k}`, num1, num1 + 1, resolvedColorStyle, var1, designTokens)) do
                tbl2[value] = value2
            end
            num1 += 2
        end
    end

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        LayoutOrder = tbl1.LayoutOrder
    }, tbl2)
end

if AvatarExperienceFlags.FFlagAXItemCardComponentsMemo then
    return (React.memo(ItemCardPriceLine))
end

return ItemCardPriceLine
