-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local Signals = require(MomentsParent.Signals)
local createDeletedMomentsStore = require(script.createDeletedMomentsStore)

return Signals.createComputed(function()
    return createDeletedMomentsStore()
end)
