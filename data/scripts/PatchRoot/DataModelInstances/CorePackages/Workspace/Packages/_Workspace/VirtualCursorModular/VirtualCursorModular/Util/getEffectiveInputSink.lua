-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent
local FFlagVirtualCursorInputSink = require(VirtualCursorModularParent.SharedFlags).FFlagVirtualCursorInputSink

local function getEffectiveInputSink(arg1)
    assert(
        FFlagVirtualCursorInputSink,
        "getEffectiveInputSink should only be called when VirtualCursorInputSink is enabled"
    )

    local inputSink = arg1.InputSink
    if arg1:IsA("GuiButton") or arg1:IsA("TextBox") then
        if inputSink == Enum.InputSink.Activate and arg1.Active == false then
            return Enum.InputSink.None
        end
    elseif inputSink == Enum.InputSink.None and arg1.Active == true then
        return Enum.InputSink.Activate
    end
    return inputSink
end

return getEffectiveInputSink
