-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local _ConversationChannels = require(AppChat.Models.ConversationChannels)

local parseNewConversationResponse = require(script.Parent.Parent.parseNewConversationResponse)

return function(arg1, tbl1, arg2, str1: string?)
    return function(arg3)
        return arg3:dispatch(AppChatNetworking.rodux.CreateConversation.API(arg1, tbl1)):andThen(function(arg4)
            return parseNewConversationResponse(arg4.responseBody.conversations and arg4.responseBody.conversations[1], arg2, str1)
        end)
    end
end
