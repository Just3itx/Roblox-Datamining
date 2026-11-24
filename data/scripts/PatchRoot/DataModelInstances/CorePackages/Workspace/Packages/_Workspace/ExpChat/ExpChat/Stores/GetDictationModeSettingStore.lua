-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)
local createDictationModeSettingStore = require(script.createDictationModeSettingStore)

return Signals.createComputed(function()
    return createDictationModeSettingStore()
end)
