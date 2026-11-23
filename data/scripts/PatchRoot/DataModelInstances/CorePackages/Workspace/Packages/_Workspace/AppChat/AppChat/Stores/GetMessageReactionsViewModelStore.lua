-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local GetMessageReactionsStore = require(AppChat.Stores.GetMessageReactionsStore)
local createMessageReactionsViewModelStore = require(script.createMessageReactionsViewModelStore)

return Signals.createComputed(function()
    return createMessageReactionsViewModelStore(GetMessageReactionsStore(false))
end)
