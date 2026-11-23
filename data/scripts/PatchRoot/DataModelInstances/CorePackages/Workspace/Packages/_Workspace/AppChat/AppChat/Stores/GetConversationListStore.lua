-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationViewModelStore = require(AppChat.Stores.GetConversationViewModelStore)
local createConversationListStore = require(script.createConversationListStore)

return Signals.createComputed(function()
    return createConversationListStore(GetConversationStore(false), GetConversationViewModelStore(false))
end)
