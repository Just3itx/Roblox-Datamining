-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ControlState = require(Foundation.Enums.ControlState)

local Visibility = require(Foundation.Enums.Visibility)

local function getKnobVisibility(tbl1)
    if tbl1.isDisabled then
        return false
    end

    if tbl1.knobVisibility == Visibility.None then
        return tbl1.isSelected
    end

    if tbl1.knobVisibility == Visibility.Always then
        return true
    end

    return tbl1.isDragging
        or tbl1.isSelected
        or tbl1.controlState == ControlState.Hover
        or tbl1.controlState == ControlState.Pressed
end

return getKnobVisibility
