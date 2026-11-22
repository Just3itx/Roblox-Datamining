-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local Signals = require(MomentsParent.Signals)
local createModeratedItemsStore = require(script.createModeratedItemsStore)

return Signals.createComputed(function()
    return createModeratedItemsStore()
end)
