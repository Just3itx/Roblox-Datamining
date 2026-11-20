-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ControlState = require(scriptParentParent.Core.Control.Enum.ControlState)
local _StyleTypes = require(scriptParentParent.App.Style.StyleTypes)

return function(arg1, arg2)
    if arg1 == ControlState.Initialize then
        return arg2.Initialize
    end

    if arg1 == ControlState.Default then
        return arg2.Default
    end

    if arg1 == ControlState.Pressed then
        return arg2.Pressed
    end

    if arg1 == ControlState.Hover then
        return arg2.Hover
    end

    if arg1 == ControlState.Selected then
        return arg2.Selected
    end

    if arg1 == ControlState.SelectedPressed then
        return arg2.SelectedPressed
    end

    if arg1 == ControlState.Disabled then
        return arg2.Disabled
    end

    return nil
end
