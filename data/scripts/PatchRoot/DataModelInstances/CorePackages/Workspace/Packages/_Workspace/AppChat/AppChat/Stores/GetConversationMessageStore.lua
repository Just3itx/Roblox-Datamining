-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Signals = require(AppChatParent.Signals)

local createConversationMessageStore = require(script.createConversationMessageStore)

return Signals.createComputed(createConversationMessageStore)
