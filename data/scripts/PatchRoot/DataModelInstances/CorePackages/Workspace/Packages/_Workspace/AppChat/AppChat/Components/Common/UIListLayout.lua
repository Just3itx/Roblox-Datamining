-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local React = require(AppChat.Parent.React)

local function UIListLayout(tbl1)
    return React.createElement("UIListLayout", {
        HorizontalAlignment = tbl1.HorizontalAlignment,
        FillDirection = tbl1.FillDirection,
        VerticalAlignment = tbl1.VerticalAlignment,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
end

return UIListLayout
