-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)

return function(str1: string?)
    local var1 = useLocalUserId()
    local var2 = useGetConversationFromId(str1)

    if not (str1 and var1) then
        return nil
    end

    if not var2 then
        return nil
    end

    if var2.type ~= "one_to_one" then
        return nil
    end

    local otherParticipants = getOtherParticipants(var2, var1)
    return if #otherParticipants == 1 then otherParticipants[1] else nil
end
