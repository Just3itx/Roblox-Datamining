-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)
local fetchMessagePage = require(FriendsChatParent.AppChat.fetchMessagePage)
local fetchOlderMessages = require(FriendsChatParent.AppChat.fetchOlderMessages)
local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)

local FFlagFriendsChatPaginateOlderMessages = require(FriendsChat.Flags.FFlagFriendsChatPaginateOlderMessages)

local var1 = ExpChatShared.Logger:new(script.Name)

local function hasStartedPagination(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = GetConversationMessageListStore(false).getMetadata(str1, false)
    return not (var2 == nil) and (var2.isLoading or var2.nextPageCursor ~= nil or var2.fetchedOldest)
end

local function useFetchNewestMessagePage(str1: string, bool1: boolean, bool2: boolean): boolean
    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        if not bool1 then
            return
        end

        local bool3 = false
        local var4 = if FFlagFriendsChatPaginateOlderMessages and not hasStartedPagination(str1) then fetchOlderMessages(str1) else fetchMessagePage(str1, nil)

        var4:catch(function(arg1)
            if not bool3 then
                var1:warning(`Failed to fetch conversation messages for {str1}: {tostring(arg1)}`)
            end
        end):finally(function()
            if not bool3 and bool2 then
                var3(str1)
            end
        end)
        return function()
            bool3 = true
        end
    end, { str1, bool1, bool2 })

    return not bool1 or not bool2 or var2 == str1
end

return useFetchNewestMessagePage
