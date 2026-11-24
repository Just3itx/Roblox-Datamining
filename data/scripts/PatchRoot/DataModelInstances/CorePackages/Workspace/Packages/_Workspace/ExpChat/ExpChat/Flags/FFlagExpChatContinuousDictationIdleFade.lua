-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local FFlagExpChatContinuousListeningChatIconDot = require(ExpChatParent.SharedFlags).FFlagExpChatContinuousListeningChatIconDot

return game:DefineFastFlag("ExpChatContinuousDictationIdleFade", false) and FFlagExpChatContinuousListeningChatIconDot
