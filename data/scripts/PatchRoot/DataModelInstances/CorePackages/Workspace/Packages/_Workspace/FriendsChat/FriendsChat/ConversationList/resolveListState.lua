-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local _useConversationSearch = require(FriendsChatParent.AppChat.useConversationSearch)

local _ExpChatConversationListAdapter = require(script.Parent.ExpChatConversationListAdapter)
local isInboxInitialLoading = require(script.Parent.isInboxInitialLoading)

local function resolveListState(tbl1, arg1)
    if arg1 ~= nil then
        local items = arg1.items
        return {
            items = items,
            isInitialLoading = arg1.isAwaitingResults and #items == 0,
            shouldShowBlockingError = arg1.hasError and #items == 0,
            shouldShowEmptyState = #items == 0 and not arg1.isAwaitingResults and arg1.hasSearched,
            shouldOfferRetry = false,
            hasNoFriends = false,
            isLoadingNextPage = arg1.isFetching,
            oldestConversationIsFetched = arg1.nextCursor == nil,
            listKey = `List-{arg1.debouncedQuery}`,
            loadNext = arg1.loadNext
        }
    end

    local var1 = tbl1.hasError and tbl1.totalCount == 0
    return {
        items = tbl1.items,
        isInitialLoading = isInboxInitialLoading(tbl1.isFetching, tbl1.totalCount),
        shouldShowBlockingError = var1,
        shouldShowEmptyState = #tbl1.items == 0 and not tbl1.isFetching and (tbl1.totalCount > 0 or tbl1.hasFetchedInitialPage or var1),
        shouldOfferRetry = var1,
        hasNoFriends = tbl1.totalCount == 0,
        isLoadingNextPage = tbl1.isFetchingNextPage,
        oldestConversationIsFetched = tbl1.oldestConversationIsFetched,
        listKey = "List",
        loadNext = tbl1.loadNext
    }
end

return resolveListState
