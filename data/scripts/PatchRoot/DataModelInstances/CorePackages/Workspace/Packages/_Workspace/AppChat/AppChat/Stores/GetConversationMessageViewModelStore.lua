-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local GetConversationMessageStore = require(AppChat.Stores.GetConversationMessageStore)
local GetConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore)
local createConversationMessageViewModelStore = require(script.createConversationMessageViewModelStore)

return Signals.createComputed(function()
    local conversationMessageStore = GetConversationMessageStore(false)
    local conversationMessageListStore = GetConversationMessageListStore(false)
    return createConversationMessageViewModelStore(conversationMessageStore, conversationMessageListStore)
end)
