-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local function ItemCardStatus(tbl1)
    local var1 = useTokens()
    return React.createElement(FoundationText, {
        textStyle = var1.Inverse.Content.Emphasis,
        fontStyle = var1.Typography.LabelSmall,
        LayoutOrder = tbl1.LayoutOrder,
        Text = tbl1.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.fromScale(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        backgroundStyle = var1.Color.System.Contrast,
        padding = var1.Padding.Small,
        cornerRadius = UDim.new(0.5, 0)
    })
end

return ItemCardStatus
