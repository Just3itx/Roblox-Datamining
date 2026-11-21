-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local function ItemCardAnimationStateIndicator(tbl1)
    local var1 = useTokens()

    local tbl2 = {
        TabsLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDim.new(0, var1.Gap.XSmall)
        })
    }

    local text = nil
    for layoutOrder, value2 in tbl1.states do
        local var2 = if value2.isSelected then var1.Color.Stroke.Emphasis else var1.Color.Stroke.Muted
        local str1 = `{layoutOrder}-{value2.text}`
        tbl2[str1] = React.createElement("Frame", {
            BorderSizePixel = 0,
            BackgroundColor3 = var2.Color3,
            Transparency = var2.Transparency,
            Size = UDim2.new(1, 0, 0, var1.Size.Size_150),
            LayoutOrder = layoutOrder
        })
        if value2.isSelected then
            text = value2.text
        end
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ZIndex = tbl1.ZIndex
    }
    local tbl4 = {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 0)
        }),
        Padding = if tbl1.paddingTop or tbl1.paddingBottom or tbl1.paddingLeft or tbl1.paddingRight then React.createElement(
            "UIPadding",
            {
                PaddingTop = tbl1.paddingTop,
                PaddingBottom = tbl1.paddingBottom,
                PaddingLeft = tbl1.paddingLeft,
                PaddingRight = tbl1.paddingRight
            }
        ) else nil,
        Tabs = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1
        }, tbl2),
        Label = 0
    }
    local element

    if text then
        element = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            Text = text,
            FontFace = normalizeFontFace(var1.Typography.TitleLarge.Font),
            TextSize = var1.Typography.TitleLarge.FontSize,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            LayoutOrder = 2
        })
    else
        element = nil
    end

    tbl4.Label = element
    return createElement(str1, tbl3, tbl4)
end

return ItemCardAnimationStateIndicator
