-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local GetUnreadMessageCountStore = require(AppChat.Stores.GetUnreadMessageCountStore)

local tbl1 = {}

tbl1[AppChatNetworking.rodux.GetConversationMetadata.Succeeded.name] = function(arg1) -- name: handleGetConversationMetadataSucceeded
    GetUnreadMessageCountStore(false).receivedConversationMetadata(arg1.responseBody)
end

local function SignalsUnreadMessageCountMiddleware(func1: (...any) -> (...any), _)
    return function(arg1)
        local var1 = func1(arg1)

        local var2 = tbl1[arg1.type]
        if var2 then
            var2(arg1)
        end

        return var1
    end
end

return SignalsUnreadMessageCountMiddleware
