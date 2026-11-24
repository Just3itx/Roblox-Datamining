-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Signals = require(scriptParentParentParent.Signals)

local createLatestCaptureStore = require(script.createLatestCaptureStore)

return Signals.createComputed(function(_)
    return createLatestCaptureStore()
end)
