-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local React = require(GenericAbuseReporting.Parent.React)

return (React.forwardRef(function(tbl1, ref)
    return React.createElement("Frame", {
        AutomaticSize = tbl1.AutomaticSize or Enum.AutomaticSize.XY,
        BackgroundColor3 = tbl1.BackgroundColor3,
        BackgroundTransparency = tbl1.BackgroundTransparency or 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Position = tbl1.Position,
        Size = tbl1.Size or UDim2.fromScale(1, 1),
        ZIndex = tbl1.ZIndex,
        children = tbl1.children,
        ref = ref
    })
end))
