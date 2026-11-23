-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)

local function useCallbackWithDynamicConversationId(func1: (...any) -> (...any), str1: string)
    local var1 = useGetConversationFromId(str1)
    local bool1 = var1 ~= nil
    local var2 = useGetOneToOneFriendIdFromConversationId(str1)
    local var3 = var1 and var1.source == "friends" and var2

    if var1 then
        if var1.source == "friends" then
            var1 = false
        else
            var1 = str1
        end
    end

    return React.useCallback(function(arg1)
        return func1(
            (Cryo.Dictionary.union(
                arg1 or {},
                {
                    conversationId = if var1 then str1 else nil,
                    friendId = if var3 then var2 else nil
                }
            ))
        )
    end, {
        func1,
        str1,
        var3,
        var1,
        var2
    }), bool1
end

return useCallbackWithDynamicConversationId
