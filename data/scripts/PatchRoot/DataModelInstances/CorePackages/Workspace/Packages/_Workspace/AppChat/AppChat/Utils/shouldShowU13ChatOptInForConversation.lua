-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local Conversation = require(AppChat.Models.Conversation)
local FFlagAppChatEnableU13ChatOptIn = require(AppChatParent.SharedFlags).FFlagAppChatEnableU13ChatOptIn

return function(arg1): boolean
    return if FFlagAppChatEnableU13ChatOptIn then if arg1 then arg1.userOptedIntoChatMessages == Conversation.UserOptedIntoChatMessagesStatus.NotOptedIn else false else false
end
