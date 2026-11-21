-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local View = require(AvatarExperienceUIKitParent.Foundation).View

local function ItemCardIndicatorStack(tbl1)
    return React.createElement(
        View,
        {
            tag = "row align-x-right align-y-center gap-xsmall auto-xy",
            testId = "item-card-indicator-stack"
        },
        {
            ItemCardIndicatorStackStatus = if tbl1.statusSlot then React.cloneElement(tbl1.statusSlot, { LayoutOrder = 1 }) else nil,
            ItemCardIndicatorStackItemType = if tbl1.itemTypeSlot then React.cloneElement(tbl1.itemTypeSlot, { LayoutOrder = 2 }) else nil
        }
    )
end

return ItemCardIndicatorStack
