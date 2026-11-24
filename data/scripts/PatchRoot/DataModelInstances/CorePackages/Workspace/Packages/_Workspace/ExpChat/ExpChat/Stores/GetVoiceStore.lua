-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)
local createVoiceStore = require(script.createVoiceStore)

return Signals.createComputed(createVoiceStore)
