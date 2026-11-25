-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getEffectiveInputSink = require(script.Parent.getEffectiveInputSink)

local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent
local FFlagVirtualCursorInputSink = require(VirtualCursorModularParent.SharedFlags).FFlagVirtualCursorInputSink

local function isSinkingGuiObject(arg1, bool1: boolean?)
    if not (FFlagVirtualCursorInputSink and bool1) then
        return arg1.Visible and arg1.Active and arg1.Interactable
    end

    local effectiveInputSink = getEffectiveInputSink(arg1)
    return arg1.Visible and (effectiveInputSink == Enum.InputSink.All or effectiveInputSink == Enum.InputSink.Activate)
end

return isSinkingGuiObject
