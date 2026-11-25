-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Workspace = game:GetService("Workspace")

local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent
local FFlagVirtualCursorInputSink = require(VirtualCursorModularParent.SharedFlags).FFlagVirtualCursorInputSink

local isInputSinkRolloutEnabled = require(script.Parent.isInputSinkRolloutEnabled)

local function getUsesInputSink(arg1, bool1: boolean)
    assert(FFlagVirtualCursorInputSink, "getUsesInputSink should only be called when VirtualCursorInputSink is enabled")

    if not bool1 then
        return isInputSinkRolloutEnabled(Workspace.InputSinkEnabled)
    end

    local layerCollector = arg1:FindFirstAncestorWhichIsA("LayerCollector")

    return not (layerCollector == nil) and layerCollector.Enabled and isInputSinkRolloutEnabled(layerCollector.InputSinkEnabled)
end

return getUsesInputSink
