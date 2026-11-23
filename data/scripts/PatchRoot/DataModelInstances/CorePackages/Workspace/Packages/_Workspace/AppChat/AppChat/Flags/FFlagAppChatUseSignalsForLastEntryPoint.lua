-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local FFlagAppChatSignalsActionHandlers = require(AppChat.Flags.FFlagAppChatSignalsActionHandlers)

return game:DefineFastFlag("AppChatUseSignalsForLastEntryPoint", false) and FFlagAppChatSignalsActionHandlers
