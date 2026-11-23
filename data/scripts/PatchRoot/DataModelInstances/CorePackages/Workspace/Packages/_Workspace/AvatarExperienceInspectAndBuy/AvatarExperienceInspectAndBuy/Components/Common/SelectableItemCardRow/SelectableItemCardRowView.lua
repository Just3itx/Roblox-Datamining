-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local CatalogRowItemCard = require(AvatarExperienceInspectAndBuyParent.AXCommon).Components.CatalogItemCard.CatalogRowItemCard

local function SelectableItemCardRowView(tbl1)
    return React.createElement(
        Foundation.View,
        {
            tag = "row align-y-top gap-medium auto-xy",
            testId = "SelectableItemCardRowView",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            SelectionCheckbox = if tbl1.isSelectionEnabled then React.createElement(Foundation.Checkbox, {
                label = "",
                isChecked = tbl1.isSelected,
                isDisabled = tbl1.isSelectionDisabled,
                onActivated = tbl1.onSelectionToggled,
                size = tbl1.checkboxSize or Foundation.Enums.InputSize.Small,
                LayoutOrder = 1
            }) else nil,
            ItemCard = React.createElement(CatalogRowItemCard, tbl1.cardProps)
        }
    )
end
return SelectableItemCardRowView
