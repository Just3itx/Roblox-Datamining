-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local React = require(GenericAbuseReporting.Parent.React)

local function UIListLayout(tbl1)
    return React.createElement("UIListLayout", {
        FillDirection = tbl1.FillDirection,
        HorizontalAlignment = tbl1.HorizontalAlignment,
        Padding = tbl1.Padding,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = tbl1.VerticalAlignment,
        ref = tbl1.Ref
    })
end

return UIListLayout
