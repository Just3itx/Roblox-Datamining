-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local reloadMessagesForConversations = require(script.Parent.reloadMessagesForConversations)

local function reloadAllMessages()
    return function(arg1)
        local conversations = arg1:getState().ChatAppReducer.Conversations
        return arg1:dispatch(reloadMessagesForConversations(Cryo.Dictionary.keys(conversations)))
    end
end
return reloadAllMessages
