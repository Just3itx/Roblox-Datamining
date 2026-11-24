-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)
local Promise = require(FriendsChatParent.Promise)
local fetchOlderMessages = require(FriendsChatParent.AppChat.fetchOlderMessages)
local FIntAppChatGetAllMessagesDepth = require(FriendsChatParent.AppChat.FIntAppChatGetAllMessagesDepth)

local var1 = ExpChatShared.Logger:new(script.Name)

local function useFetchAllOlderMessages(str1: string, bool1: boolean): boolean
    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        if not bool1 then
            return
        end

        local bool2 = false
        local function fetchFrom(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
            if bool2 or FIntAppChatGetAllMessagesDepth <= num1 then
                return Promise.resolve()
            end
            return fetchOlderMessages(str1):andThen(function(arg1)
                if arg1.response == nil then
                    return nil
                end
                return fetchFrom(num1 + 1)
            end)
        end

        fetchFrom(0):catch(function(arg1)
            if not bool2 then
                var1:warning(`Failed to fetch older messages for {str1}: {tostring(arg1)}`)
            end
        end):finally(function()
            if not bool2 then
                var3(str1)
            end
        end)
        return function()
            bool2 = true
        end
    end, { str1, bool1 })

    return not bool1 or var2 == str1
end

return useFetchAllOlderMessages
