-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ReactCurrentBatchConfig = require(scriptParentParent.Shared).ReactSharedInternals.ReactCurrentBatchConfig

return {
    NoTransition = 0,
    requestCurrentTransition = function()
        return ReactCurrentBatchConfig.transition
    end
}
