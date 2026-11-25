-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local Cryo = require(ServerDrivenUiParent.Cryo)
local UIBlox = require(ServerDrivenUiParent.UIBlox)
local Foundation = require(ServerDrivenUiParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local checkAndFormatPossibleLink = require(ServerDrivenUiParent.CollectionViews).checkAndFormatPossibleLink
local TextSize = require(ServerDrivenUiParent.TextSize)

local tbl1 = {
    anchorPoint = "AnchorPoint",
    automaticSize = "AutomaticSize",
    backgroundColor3 = "BackgroundColor3",
    backgroundTransparency = "BackgroundTransparency",
    layoutOrder = "LayoutOrder",
    position = "Position",
    richText = "RichText",
    size = "Size",
    text = "Text",
    textTruncate = "TextTruncate",
    textWrapped = "TextWrapped",
    textXAlignment = "TextXAlignment",
    textYAlignment = "TextYAlignment",
    zIndex = "ZIndex"
}

local function applyOverrides(tbl2, tbl3)
    if tbl3 == nil then
        return tbl2
    end
    local tbl4 = {}
    for value, value2 in tbl3 do
        tbl4[tbl1[value] or value] = value2
    end
    return Cryo.Dictionary.join(tbl2, tbl4)
end

return React.memo(function(tbl2) -- name: SduiTextIconRow
    local layoutOrder = tbl2.layoutOrder
    local anchorPoint = tbl2.anchorPoint
    local automaticSize = tbl2.automaticSize
    local size = tbl2.size
    local zIndex = tbl2.zIndex
    local position = tbl2.position
    local selectable = tbl2.selectable

    local var1 = TextSize.getTextSizeStore(false).getTextSizeOffset(false)

    local var2 = useTokens()

    local var3 = tbl2.fontStyle or var2.Typography.HeadingSmall
    local textColor3 = tbl2.textColor or var2.Color.Content.Emphasis.Color3
    local num1 = math.ceil(var3.LineHeight * var3.FontSize + var1)
    local uDim2 = if tbl2.iconWidth then UDim2.new(0, tbl2.iconWidth, 0, tbl2.iconWidth) else UDim2.new(0, num1, 0, num1)
    local imageColor3 = tbl2.iconColor or textColor3

    local active = tbl2.onActivated ~= nil

    local var6, var7 = checkAndFormatPossibleLink(tbl2.text)

    local createElement = React.createElement
    local str1 = if active then "TextButton" else "Frame"
    local tbl3 = {
        Position = position,
        AnchorPoint = anchorPoint,
        AutomaticSize = automaticSize,
        Size = size or UDim2.new(1, 0, 0, num1),
        BackgroundTransparency = tbl2.backgroundStyle and tbl2.backgroundStyle.Transparency or 1,
        BackgroundColor3 = if tbl2.backgroundStyle then tbl2.backgroundStyle.Color3 or nil else nil,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        Text = if active then "" else nil,
        TextTransparency = if active then 1 else nil,
        AutoButtonColor = not active and nil,
        [React.Event.Activated] = if active then tbl2.onActivated else nil,
        Active = active,
        Selectable = selectable,
        [React.Tag] = not tbl2.testId and (if active then "data-testid=--sdui-text-icon-row-button" else "data-testid=--sdui-text-icon-row")
            or `data-testid={tbl2.testId}`
    }
    local tbl4 = {
        UICorner = if tbl2.cornerRadius then React.createElement("UICorner", { CornerRadius = tbl2.cornerRadius }) else nil,
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, tbl2.gap or 0),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Text = React.createElement(
            "TextLabel",
            applyOverrides({
                BackgroundTransparency = 1,
                Text = var7 or "",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = size or UDim2.new(0, 0, 0, num1),
                FontFace = normalizeFontFace(var3.Font),
                TextSize = var3.FontSize,
                TextTransparency = 0,
                TextColor3 = textColor3,
                TextWrapped = false,
                TextTruncate = Enum.TextTruncate.SplitWord,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = (if tbl2.iconFirst then -1 else 1) * 1,
                RichText = if var6 then true else nil,
                [React.Tag] = "data-testid=--sdui-text-icon-row-text"
            }, tbl2.textOverrides),
            {
                UIFlexItem = if tbl2.textFlexMode then React.createElement("UIFlexItem", { FlexMode = tbl2.textFlexMode }) else nil
            }
        ),
        Icon = if tbl2.icon then React.createElement(
            ImageSetLabel,
            applyOverrides({
                LayoutOrder = (if tbl2.iconFirst then -1 else 1) * 2,
                Size = uDim2,
                BackgroundTransparency = 1,
                ImageColor3 = imageColor3,
                ImageTransparency = 0,
                Image = tbl2.icon,
                [React.Tag] = "data-testid=--sdui-text-icon-row-icon"
            }, tbl2.iconOverrides)
        ) else nil
    }
    return createElement(str1, tbl3, tbl4)
end)
