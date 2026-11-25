-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens

local FFlagSduiDividerThemeAwareStroke = require(ServerDrivenUiParent.SharedFlags).FFlagSduiDividerThemeAwareStroke

return React.memo(function(tbl1) -- name: SduiDivider
    local var1 = if FFlagSduiDividerThemeAwareStroke then useTokens() else nil
    local size = tbl1.size
    local layoutOrder = tbl1.layoutOrder
    local position = tbl1.position
    local anchorPoint = tbl1.anchorPoint
    local backgroundColor3 = tbl1.backgroundColor3
    local backgroundTransparency = tbl1.backgroundTransparency

    return React.createElement("Frame", {
        Size = size or UDim2.new(1, 0, 0, 1),
        LayoutOrder = layoutOrder,
        Position = position,
        AnchorPoint = anchorPoint,
        BackgroundColor3 = if FFlagSduiDividerThemeAwareStroke then backgroundColor3 or var1.Color.Stroke.Default.Color3 else backgroundColor3 or Color3.new(1, 1, 1),
        BackgroundTransparency = not FFlagSduiDividerThemeAwareStroke and (backgroundTransparency or 0.85)
            or backgroundTransparency
            or var1.Color.Stroke.Default.Transparency,
        BorderSizePixel = 0,
        [React.Tag] = "data-testid=--sdui-divider"
    })
end)
