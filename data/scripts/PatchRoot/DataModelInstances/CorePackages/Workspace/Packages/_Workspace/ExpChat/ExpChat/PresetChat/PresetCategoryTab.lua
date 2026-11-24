-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)

return React.memo(function(tbl1) -- name: PresetCategoryTab
    return React.createElement(Foundation.Chip, {
        LayoutOrder = tbl1.layoutOrder or 0,
        text = tbl1.name,
        isChecked = tbl1.isSelected,
        onActivated = tbl1.onActivated,
        size = Foundation.Enums.ChipSize.Small
    })
end)
