-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent
local Signals = require(DictationCoreParent.Signals)
local createMicStore = require(script.createMicStore)

return Signals.createComputed(function()
    return createMicStore()
end)
