-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local FFlagAXAddTextXAlignmentProp = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXAddTextXAlignmentProp

local function ItemCardTitle(tbl1)
    local var1 = useTokens()
    return React.createElement(FoundationText, {
        textStyle = var1.Color.Content.Emphasis,
        fontStyle = if tbl1.titleTextSize then tbl1.titleTextSize else var1.Typography.TitleMedium,
        LayoutOrder = tbl1.LayoutOrder,
        Text = tbl1.title,
        TextXAlignment = if FFlagAXAddTextXAlignmentProp and tbl1.TextXAlignment then tbl1.TextXAlignment else Enum.TextXAlignment.Left,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextTruncate = Enum.TextTruncate.SplitWord
    })
end

if require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXItemCardComponentsMemo then
    return (React.memo(ItemCardTitle))
end

return ItemCardTitle
