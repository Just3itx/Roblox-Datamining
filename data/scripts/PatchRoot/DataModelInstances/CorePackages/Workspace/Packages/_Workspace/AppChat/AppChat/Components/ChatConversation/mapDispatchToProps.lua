-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local Messages = script.Parent.Messages
local getOlderMessages = require(Messages.NetworkRequests.getOlderMessages)
local markConversationAsRead = require(Messages.NetworkRequests.markConversationAsRead)
local sendTextMessage = require(Messages.Thunks.sendTextMessage)
local getRemainingOlderMessages = require(Messages.Thunks.getRemainingOlderMessages)
local updateTypingStatus = require(Messages.NetworkRequests.updateTypingStatus)
local createFriendConversation = require(AppChat.Conversations.Thunks.createFriendConversation)
local SendGameLinkMessage = require(AppChat.Conversations.Thunks.SendGameLinkMessage)

return function(arg1)
    local function func1(arg2, arg3, arg4, _)
        return arg1(getOlderMessages(arg2, arg3, arg4))
    end

    return {
        getOlderMessages = function(arg2, _)
            return arg1(getRemainingOlderMessages(func1, arg2))
        end,
        sendMessage = function(arg2, arg3, arg4)
            return arg1(sendTextMessage(arg2, arg3, arg4))
        end,
        sendGameLinkChatMessage = function(arg2, arg3)
            return arg1(SendGameLinkMessage(arg2, arg3))
        end,
        createFriendConversation = function(arg2, arg3)
            return arg1(createFriendConversation(arg2, arg3))
        end,
        markConversationAsRead = function(arg2)
            arg1(markConversationAsRead(arg2))
        end,
        postTypingStatus = function(arg2, _)
            return arg1(updateTypingStatus(arg2))
        end
    }
end
