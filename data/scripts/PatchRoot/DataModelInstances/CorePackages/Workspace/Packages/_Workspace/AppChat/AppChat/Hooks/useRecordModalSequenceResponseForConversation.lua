-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

return function(str1: string?)
    local var1 = useDispatch()
    local var2 = useGetConversationFromId(str1)

    local var3 = useGetOneToOneFriendIdFromConversationId(str1)

    return function(arg1, arg2, str2: string?, arg3)
        if var2 and var2.source == "friends" and var3 then
            return var1(AppChatNetworking.rodux.RecordModalSequenceResponse.API(arg1, arg2, str2, arg3, nil, var3))
        end

        return var1(AppChatNetworking.rodux.RecordModalSequenceResponse.API(arg1, arg2, str2, arg3, str1))
    end
end
