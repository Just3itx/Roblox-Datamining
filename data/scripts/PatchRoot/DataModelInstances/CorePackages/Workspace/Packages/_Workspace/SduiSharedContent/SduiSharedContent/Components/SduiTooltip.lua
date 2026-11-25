-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)

local Tooltip = Foundation.Tooltip
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local tbl1 = {
    Top = PopoverSide.Top,
    Bottom = PopoverSide.Bottom,
    Left = PopoverSide.Left,
    Right = PopoverSide.Right
}

local tbl2 = {
    Start = PopoverAlign.Start,
    Center = PopoverAlign.Center,
    End = PopoverAlign.End
}

return React.memo(function(tbl3) -- name: SduiTooltip
    if tbl3.anchor == nil then
        return nil
    end

    local shortcut = if tbl3.shortcut and #tbl3.shortcut > 0 then tbl3.shortcut else nil
    return React.createElement(Tooltip, {
        title = tbl3.title or "",
        text = tbl3.text,
        shortcut = shortcut,
        side = tbl1[tbl3.side or ""],
        align = tbl2[tbl3.align or ""],
        LayoutOrder = tbl3.layoutOrder
    }, tbl3.anchor)
end)
