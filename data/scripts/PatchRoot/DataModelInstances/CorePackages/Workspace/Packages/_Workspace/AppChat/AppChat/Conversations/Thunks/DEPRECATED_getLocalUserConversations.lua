-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local NetworkingChat = require(AppChat.Http.NetworkingChat)
local Promise = require(AppChatParent.Promise)
local RoduxNetworking = require(AppChat.Http.RoduxNetworking)

local processConversations = require(script.Parent.processConversations)

return function(arg1, arg2)
    return function(arg3)
        if NetworkingChat.GetUserConversations.getStatus(arg3:getState(), arg1) == RoduxNetworking.Enum.NetworkStatus.Fetching then
            return Promise.resolve()
        end

        return arg3:dispatch(NetworkingChat.GetUserConversations.API(arg1, arg2)):andThen(function(arg4)
            local responseBody = arg4.responseBody

            arg3:dispatch(processConversations(responseBody))
        end):catch(function(arg4)
            warn("NetworkingChat failure in DEPRECATED_getLocalUserConversations, Status: " .. tostring(arg4))
        end)
    end
end
