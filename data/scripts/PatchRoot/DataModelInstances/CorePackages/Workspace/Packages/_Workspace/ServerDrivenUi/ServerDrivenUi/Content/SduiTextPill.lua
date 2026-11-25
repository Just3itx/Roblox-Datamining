-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Foundation = require(ServerDrivenUiParent.Foundation)
local React = require(ServerDrivenUiParent.React)
local Colors = require(ServerDrivenUiParent.Style).Colors
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

return React.memo(function(tbl1) -- name: SduiTextPill
    if not tbl1.text or tbl1.text == "" then
        return nil
    end

    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local position = tbl1.position
    local zIndex = tbl1.zIndex
    local backgroundColor3 = tbl1.backgroundColor3
    local backgroundTransparency = tbl1.backgroundTransparency
    local textColor3 = tbl1.textColor3

    local var1 = useTokens()
    local small = var1.Padding.Small
    local xSmall = var1.Padding.XSmall
    local var2 = tbl1.fontStyle or var1.Typography.LabelSmall
    local yOffset = var2.FontSize * var2.LineHeight

    return React.createElement("Frame", {
        [React.Tag] = "data-testid=--sdui-text-pill",
        BackgroundColor3 = backgroundColor3 or Colors.White,
        BackgroundTransparency = backgroundTransparency or 0,
        Position = position,
        AnchorPoint = anchorPoint,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        AutomaticSize = Enum.AutomaticSize.XY
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, xSmall),
            PaddingLeft = UDim.new(0, small),
            PaddingBottom = UDim.new(0, xSmall),
            PaddingRight = UDim.new(0, small)
        }),
        TextLabel = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 0, yOffset),
            AutomaticSize = Enum.AutomaticSize.X,
            Text = tbl1.text,
            TextColor3 = textColor3 or var1.LightMode.Content.Emphasis.Color3,
            FontFace = normalizeFontFace(var2.Font),
            TextSize = var2.FontSize,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
    })
end)
