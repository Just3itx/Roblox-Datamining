-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local ExpChatShared = require(FriendsChatParent.ExpChatShared)

local fetchConversationListPageToSignals = require(script.Parent.ExpChatConversationListAdapter).fetchConversationListPageToSignals

local var1 = ExpChatShared.Logger:new(script.Name)

local function useConversationListPagination(bool1: boolean, tbl1)
    local retryInitialFetch = React.useCallback(function()
        if not bool1 or tbl1.isFetchingConversations == true then
            return
        end

        fetchConversationListPageToSignals():catch(function(arg1)
            var1:warning(`Failed to retry FriendsChat conversation list fetch: {tostring(arg1)}`)
        end)
    end, { bool1, tbl1.isFetchingConversations })

    local loadNext = React.useCallback(function()
        if not bool1 or tbl1.isFetchingConversations == true or tbl1.isExhausted == true then
            return
        end

        local nextCursor = tbl1.nextCursor
        if nextCursor == nil or nextCursor == "" then
            return
        end

        fetchConversationListPageToSignals({ cursor = nextCursor }):catch(function(arg1)
            var1:warning(`Failed to fetch next FriendsChat conversation list page: {tostring(arg1)}`)
        end)
    end, {
        bool1,
        tbl1.isFetchingConversations,
        tbl1.isExhausted,
        tbl1.nextCursor
    })

    React.useEffect(function()
        if not bool1 then
            return nil
        end
        if tbl1.isFetchingConversations == true then
            return nil
        end
        if tbl1.hasFetchedInitialPage == true or tbl1.error ~= nil then
            return nil
        end

        fetchConversationListPageToSignals():catch(function(arg1)
            var1:warning(`Failed to fetch initial FriendsChat conversation list page: {tostring(arg1)}`)
        end)
        return nil
    end, {
        bool1,
        tbl1.error,
        tbl1.hasFetchedInitialPage,
        tbl1.isFetchingConversations
    })

    return { loadNext = loadNext, retryInitialFetch = retryInitialFetch }
end

return useConversationListPagination
