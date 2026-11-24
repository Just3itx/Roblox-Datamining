-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local FFlagExpChatDictationStateStore = require(ExpChatParent.SharedFlags).FFlagExpChatDictationStateStore

return game:DefineFastFlag("ExpChatDictationStopOnRateLimit", false) and FFlagExpChatDictationStateStore
