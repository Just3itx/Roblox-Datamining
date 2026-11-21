-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

return function(tbl1)
    local bool1 = (tbl1.sideChipText or "") ~= "" and tbl1.showSideChip ~= false

    return React.createElement(Foundation.Text, {
        tag = "text-caption-medium text-wrap content-emphasis",
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.fromScale(0, 1),
        Text = tbl1.sideChipText or "",
        TextTransparency = tbl1.transparency or 1,
        Visible = bool1,
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged,
        onActivated = tbl1.onSideChipActivated
    })
end
