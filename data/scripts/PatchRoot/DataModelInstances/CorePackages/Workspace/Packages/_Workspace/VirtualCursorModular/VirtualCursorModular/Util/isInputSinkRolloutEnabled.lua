-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent

local FFlagVirtualCursorInputSink = require(VirtualCursorModularParent.SharedFlags).FFlagVirtualCursorInputSink
local engineFeature = game:GetEngineFeature("InputSinkDefault")

local function isInputSinkRolloutEnabled(rolloutState): boolean
    assert(
        FFlagVirtualCursorInputSink,
        "isInputSinkRolloutEnabled should only be called when VirtualCursorInputSink is enabled"
    )

    return rolloutState == Enum.RolloutState.Enabled or engineFeature and rolloutState == Enum.RolloutState.Default
end

return isInputSinkRolloutEnabled
