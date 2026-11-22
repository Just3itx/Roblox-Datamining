-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local Signals = require(MomentsParent.Signals)
local createShareCountsStore = require(script.createShareCountsStore)

return Signals.createComputed(function()
    return createShareCountsStore()
end)
