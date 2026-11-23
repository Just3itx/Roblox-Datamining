-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local selectUsersTyping = require(AppChat.Components.ChatConversation.Conversations.Selectors.selectUsersTyping)

return function(str1: string)
    return useSelector(function(arg1)
        return selectUsersTyping(arg1, str1)
    end)
end
