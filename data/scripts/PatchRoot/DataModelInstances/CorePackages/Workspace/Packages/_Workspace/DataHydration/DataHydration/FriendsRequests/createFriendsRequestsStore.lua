-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local DataStatus = require(DataHydration.DataHydrationTypes).DataStatus
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId
local mergeListsWithoutDuplicates = require(DataHydration.DataHydrationUtils).mergeListsWithoutDuplicates

local _Signals = require(DataHydrationParent.Signals)
local LocalUserIdStore = require(DataHydrationParent.LocalUserIdStore).LocalUserIdStore
local FFlagShowRequestsInCarouselForAllUsers = require(DataHydrationParent.SharedFlags).FFlagShowRequestsInCarouselForAllUsers

local Requests = require(script.Parent.Requests)
local _FriendsRequestsStoreTypes = require(script.Parent.FriendsRequestsStoreTypes)
local FriendsStore = require(DataHydration.Friends.FriendsStore)

local num1 = game:DefineFastInt("FriendsRequestsPageSize", 25)

local num2 = game:DefineFastInt("FriendsRequestsCacheTtlSec", 0)

local function getCacheTTL(num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if num3 > 0 then num3 else math.huge
end

local function normalizeId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return nil
    end
    return tostring(arg1)
end

local function normalizeCursor(str1: string?): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == nil or str1 == "" then nil else str1
end

local function normalizeFriendRequest(arg1): {contactName: number, id: any, isUnseen: any, mutualFriendsIds: number, originSourceType: number, sentAt: number, sourceUniverseId: number}?
    local id = normalizeId(arg1.id)
    if not id then
        return nil
    end

    local friendRequest = arg1.friendRequest
    local tbl1

    if arg1.mutualFriendsList then
        tbl1 = {}
        for _, mutualFriend in arg1.mutualFriendsList do
            table.insert(tbl1, tostring(mutualFriend))
        end
    else
        tbl1 = nil
    end

    return {
        id = id,
        isUnseen = arg1.isUnseen,
        sentAt = if friendRequest and friendRequest.sentAt then DateTime.fromIsoDate(friendRequest.sentAt) else nil,
        sourceUniverseId = if friendRequest then friendRequest.sourceUniverseId else nil,
        originSourceType = if friendRequest then friendRequest.originSourceType else nil,
        contactName = if friendRequest then friendRequest.contactName else nil,
        mutualFriendsIds = tbl1
    }
end

local function normalizeGetFriendRequestsResponse(arg1)
    local requests = {}
    for _, value in not (arg1 and arg1.data) and {} or arg1.data do
        local var1 = normalizeFriendRequest(value)
        if var1 then
            table.insert(requests, var1)
        end
    end

    local nextPageCursor = if arg1 then arg1.nextPageCursor else nil
    local var1 = normalizeCursor(nextPageCursor)
    return {
        requests = requests,
        nextPageCursor = var1,
        hasMore = var1 ~= nil
    }
end

local function updateFriendshipStatusesForPage(tbl1)
    local var1 = FriendsStore.get()
    for _, request in tbl1.requests do
        var1.UpdateFriendshipStatus(request.id, Enum.FriendStatus.FriendRequestReceived)
    end
end

local function mergeFriendsRequestsPage(arg1, tbl1, nextPageCursor)
    if not arg1 then
        return {
            requests = tbl1.requests,
            nextPageCursor = tbl1.nextPageCursor,
            hasMore = tbl1.hasMore
        }
    end

    if arg1.nextPageCursor ~= nextPageCursor then
        return arg1
    end

    return {
        requests = mergeListsWithoutDuplicates(arg1.requests, tbl1.requests, "id"),
        nextPageCursor = tbl1.nextPageCursor,
        hasMore = tbl1.hasMore
    }
end

local function resolveLocalUserId(bool1: boolean) -- Luacid: Inlined by compiler; 15 call sites recovered
    local currentUserId = LocalUserIdStore.getCurrentUserId(bool1)
    if currentUserId ~= "" then
        return currentUserId
    end
    local localPlayerUserId = getLocalPlayerUserId()
    if localPlayerUserId then
        return tostring(localPlayerUserId)
    end

    return ""
end

local function createFriendsRequestsStore()
    local cache = createDataCache((getCacheTTL(num2)))
    local dataCache = createDataCache()
    local dataCache2 = createDataCache()

    local bool1 = false
    local var1 = nil

    local function stageSessionId(str1: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
        if str1 == "" then
            str1 = nil
        end

        var1 = str1
    end

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_, arg1)
            local var2 = if bool1 then nil else arg1.data(false)
            bool1 = false
            local nextPageCursor = if var2 then var2.nextPageCursor else nil

            return Requests.GetFriendsRequests(nextPageCursor, num1, var1):andThen(function(arg2)
                local tbl1 = normalizeGetFriendRequestsResponse(arg2)

                updateFriendshipStatusesForPage(tbl1)

                return (mergeFriendsRequestsPage(var2, tbl1, nextPageCursor))
            end):catch(function(arg2)
                error(arg2)
            end)
        end
    })

    local dataResolver2 = createDataResolver({
        cache = dataCache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_)
            return Requests.GetFriendRequestsCount():andThen(function(arg1)
                return if arg1 and arg1.count then arg1.count else 0
            end)
        end
    })

    local dataResolver3 = createDataResolver({
        cache = dataCache2,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_)
            return Requests.GetNewFriendRequestsCount():andThen(function(arg1)
                return if arg1 and arg1.count then arg1.count else 0
            end)
        end
    })

    local function refetchFriendRequests(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = resolveLocalUserId(false)

        if dataResolver.isRequestInQueueOrInFlight(var2) then
            return
        end

        stageSessionId(str1)
        bool1 = true
        dataResolver.fetchItem(var2)
    end

    local function refetchFriendRequestCount() -- Luacid: Inlined by compiler; 1 call site recovered
        dataResolver2.fetchItem((resolveLocalUserId(false)))
    end

    local function clearNewFriendRequestCount() -- Luacid: Inlined by compiler; 1 call site recovered
        dataCache2.replaceItem(resolveLocalUserId(false), 0)
    end

    return {
        getFriendsRequests = function(tbl1)
            local var2 = resolveLocalUserId(false)

            if tbl1 and tbl1.skipFetch then
                return dataResolver.getCachedItem(var2)
            end

            if tbl1 and tbl1.forceFetch then
                local sessionId = if tbl1 then tbl1.sessionId else nil
                refetchFriendRequests(sessionId)
            end

            local sessionId = if tbl1 then tbl1.sessionId else nil
            stageSessionId(sessionId)
            return dataResolver.getAndFetchItem(var2)
        end,
        fetchMoreFriendsRequests = function(str1: string?)
            local var2 = resolveLocalUserId(false)
            local cachedItem = dataResolver.getCachedItem(var2)
            local var3 = cachedItem.data(false)

            if var3 ~= nil
                and var3.hasMore
                and var3.nextPageCursor ~= nil
                and cachedItem.status(false) ~= DataStatus.NotReady
                and not dataResolver.isRequestInQueueOrInFlight(var2)
            then
                stageSessionId(str1)
                dataResolver.fetchItem(var2)
            end
        end,
        refetchFriendRequests = refetchFriendRequests,
        declineAllFriendRequests = function()
            return Requests.DeclineAllFriendRequests():andThen(function<T>(arg1: T): T
                local var2 = resolveLocalUserId(false)
                cache.replaceItem(var2, { requests = {}, nextPageCursor = nil, hasMore = false })

                dataCache.replaceItem(var2, 0)

                return arg1
            end)
        end,
        removeFriendRequestByUserId = function(id)
            local var2 = resolveLocalUserId(false)
            local var3 = dataResolver.getCachedItem(var2).data(false)
            if var3 == nil then
                return
            end
            local requests = {}
            local bool2 = false
            for _, request in var3.requests do
                if request.id ~= id then
                    table.insert(requests, request)
                else
                    bool2 = true
                end
            end

            if not bool2 then
                return
            end
            cache.replaceItem(var2, { requests = requests, nextPageCursor = var3.nextPageCursor, hasMore = var3.hasMore })
        end,
        appendNewUserId = function(arg1)
            local id = normalizeId(arg1)

            if not id then
                return
            end

            local var3 = resolveLocalUserId(false)
            local var4 = dataResolver.getCachedItem(var3).data(false)

            local tbl1 = { id = id, isUnseen = true }

            if var4 ~= nil then
                local requests = { tbl1 }

                for _, request in var4.requests do
                    if request.id ~= id then
                        table.insert(requests, request)
                    end
                end

                cache.replaceItem(var3, { requests = requests, nextPageCursor = var4.nextPageCursor, hasMore = var4.hasMore })
            elseif FFlagShowRequestsInCarouselForAllUsers then
                local var5 = resolveLocalUserId(false)

                if not dataResolver.isRequestInQueueOrInFlight(var5) then
                    var1 = nil

                    bool1 = true
                    dataResolver.fetchItem(var5)
                end
            else
                cache.replaceItem(var3, { requests = { tbl1 }, nextPageCursor = nil, hasMore = false })
            end

            FriendsStore.get().UpdateFriendshipStatus(id, Enum.FriendStatus.FriendRequestReceived)
        end,
        getFriendsRequestCount = function(tbl1)
            local var2 = resolveLocalUserId(false)

            if tbl1 and tbl1.skipFetch then
                return dataResolver2.getCachedItem(var2)
            end

            if tbl1 and tbl1.forceFetch then
                refetchFriendRequestCount()
            end

            return dataResolver2.getAndFetchItem(var2)
        end,
        refetchFriendRequestCount = refetchFriendRequestCount,
        getNewFriendsRequestCount = function(tbl1)
            local var2 = resolveLocalUserId(false)

            if tbl1 and tbl1.skipFetch then
                return dataResolver3.getCachedItem(var2)
            end

            return dataResolver3.getAndFetchItem(var2)
        end,
        refetchNewFriendRequestCount = function()
            dataResolver3.fetchItem((resolveLocalUserId(false)))
        end,
        clearNewFriendRequest = function()
            return Requests.ClearNewFriendRequests():andThen(function()
                clearNewFriendRequestCount()
            end)
        end,
        clearNewFriendRequestCount = clearNewFriendRequestCount,
        clear = function()
            dataResolver.clear()
            dataResolver2.clear()
            dataResolver3.clear()
        end,
        dispose = function()
            dataResolver.dispose()
            dataResolver2.dispose()
            dataResolver3.dispose()
        end
    }
end
return createFriendsRequestsStore
