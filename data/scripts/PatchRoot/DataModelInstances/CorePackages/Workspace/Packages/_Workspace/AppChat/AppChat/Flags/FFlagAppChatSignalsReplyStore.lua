-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local FFlagAppChatSignalsMessageStore = require(AppChat.Flags.FFlagAppChatSignalsMessageStore)

return game:DefineFastFlag("AppChatSignalsReplyStore", false) and FFlagAppChatSignalsMessageStore
