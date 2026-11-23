-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationMessageStore = require(AppChat.Stores.GetConversationMessageStore)
local GetConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore)
local createConversationViewModelStore = require(script.createConversationViewModelStore)

return Signals.createComputed(function()
    local conversationStore = GetConversationStore(false)
    local conversationMessageStore = GetConversationMessageStore(false)
    local conversationMessageListStore = GetConversationMessageListStore(false)
    return createConversationViewModelStore(conversationStore, conversationMessageStore, conversationMessageListStore)
end)
