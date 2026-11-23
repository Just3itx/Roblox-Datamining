-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local FFlagAppChatSignalsActionHandlers = require(AppChat.Flags.FFlagAppChatSignalsActionHandlers)

return game:DefineFastFlag("AppChatUseSignalsForChatSettings", false) and FFlagAppChatSignalsActionHandlers
