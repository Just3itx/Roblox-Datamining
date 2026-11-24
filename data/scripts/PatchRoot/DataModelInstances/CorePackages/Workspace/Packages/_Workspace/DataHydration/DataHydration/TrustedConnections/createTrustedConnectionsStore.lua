-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local Promise = require(DataHydrationParent.Promise)
local Cryo = require(DataHydrationParent.Cryo)

local Requests = require(DataHydration.TrustedConnections.Requests)
local TrustedConnectionStatus = require(DataHydration.TrustedConnections.Enums.TrustedConnectionStatus)

local createTrustedConnectionEventListener = require(DataHydration.TrustedConnections.createTrustedConnectionEventListener)
local createFriendshipEventListener = require(DataHydration.TrustedConnections.createFriendshipEventListener)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId
local mergeListsWithoutDuplicates = require(DataHydration.DataHydrationUtils).mergeListsWithoutDuplicates
local FFlagConnectionManagementChips = require(DataHydrationParent.SharedFlags).FFlagConnectionManagementChips

local FFlagAddFriendsPageTrustedFriendRequestSection = require(DataHydrationParent.SharedFlags).FFlagAddFriendsPageTrustedFriendRequestSection

local FFlagAddFriendsPageHighlightUnseenTrustedRequests = require(DataHydrationParent.SharedFlags).FFlagAddFriendsPageHighlightUnseenTrustedRequests

local FIntTrustedFriendRequestsPageSize = require(DataHydrationParent.SharedFlags).FIntTrustedFriendRequestsPageSize
local FFlagProfileTFCardUseQrScanContext = require(DataHydrationParent.SharedFlags).FFlagProfileTFCardUseQrScanContext
local FFlagTrustedFriendCandidatesSection = require(DataHydrationParent.SharedFlags).FFlagTrustedFriendCandidatesSection

local num1 = game:DefineFastInt("TrustedConnectionsStoreDataTtlSec", 0)

game:DefineFastInt("TrustedConnectionsStoreProcessDelaySec", 1)
local function func1(): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return game:GetFastInt("TrustedConnectionsStoreProcessDelaySec")
end

game:DefineFastInt("TrustedConnectionsStoreIncomingRequestsProcessDelaySec", 0)
local function func2(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetFastInt("TrustedConnectionsStoreIncomingRequestsProcessDelaySec")
end

local num2 = game:DefineFastInt("TrustedFriendCandidatesPageSize", 20)

local num3 = game:DefineFastInt("TrustedFriendCandidatesMaxReadsPerFetch", 5)

local tbl1 = {
    None = TrustedConnectionStatus.Friends,
    RequestSent = TrustedConnectionStatus.RequestSent,
    RequestReceived = TrustedConnectionStatus.RequestReceived
}

local function createTrustedConnectionsStore()
    local num4 = not (num1 > 0) and math.huge or num1

    local cache = createDataCache(num4)
    local dataCache = createDataCache(num4)
    local dataCache2 = if FFlagConnectionManagementChips then createDataCache(num4) else nil
    local dataCache3 = if FFlagAddFriendsPageTrustedFriendRequestSection then createDataCache(num4) else nil
    local dataCache4 = if FFlagAddFriendsPageTrustedFriendRequestSection then createDataCache(num4) else nil
    local bool1 = false
    local dataCache5 = if FFlagTrustedFriendCandidatesSection then createDataCache(num4) else nil
    local bool2 = not FFlagTrustedFriendCandidatesSection and nil

    local var1 = FFlagAddFriendsPageTrustedFriendRequestSection and function(id: string)
        local str2 = tostring(getLocalPlayerUserId())
        local var1 = dataCache3.getItem(str2).data(false)
        if not var1 then
            return
        end

        if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
            local requests = var1.requests
            if not requests then
                return
            end

            local var2 = mergeListsWithoutDuplicates({{ id = id, isUnseen = true }}, requests, "id")
            if #var2 == #requests then
                return
            end

            dataCache3.replaceItem(
                str2,
                {
                    senderIds = nil,
                    requests = var2,
                    nextPageCursor = var1.nextPageCursor,
                    hasMore = var1.hasMore
                }
            )
        else
            local senderIds = mergeListsWithoutDuplicates(var1.senderIds, { id })
            if #senderIds == #var1.senderIds then
                return
            end

            dataCache3.replaceItem(str2, { senderIds = senderIds, nextPageCursor = var1.nextPageCursor, hasMore = var1.hasMore })
        end

        local var2 = dataCache4.getItem(str2).data(false)
        if var2 then
            dataCache4.replaceItem(str2, math.max(var2 + 1, 0))
        end
    end or nil

    local var2 = FFlagAddFriendsPageTrustedFriendRequestSection and function(id: string)
        local str1 = tostring(getLocalPlayerUserId())
        local var2 = dataCache3.getItem(str1).data(false)
        if not var2 then
            return
        end

        if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
            local requests = var2.requests
            if not requests then
                return
            end

            local var3 = Cryo.List.filter(requests, function(arg1): boolean
                return arg1.id ~= id
            end)
            if #var3 == #requests then
                return
            end

            dataCache3.replaceItem(
                str1,
                {
                    senderIds = nil,
                    requests = var3,
                    nextPageCursor = var2.nextPageCursor,
                    hasMore = var2.hasMore
                }
            )
        else
            local senderIds = Cryo.List.removeValue(var2.senderIds, id)
            if #senderIds == #var2.senderIds then
                return
            end

            dataCache3.replaceItem(str1, { senderIds = senderIds, nextPageCursor = var2.nextPageCursor, hasMore = var2.hasMore })
        end

        local var3 = dataCache4.getItem(str1).data(false)
        if var3 then
            dataCache4.replaceItem(str1, math.max(var3 - 1, 0))
        end
    end or nil

    local var3 = FFlagTrustedFriendCandidatesSection and function(id: string)
        local str1 = tostring(getLocalPlayerUserId())
        local var3 = dataCache5.getItem(str1).data(false)
        if not var3 then
            return
        end

        local candidates = Cryo.List.filter(var3.candidates, function(arg1): boolean
            return arg1.id ~= id
        end)
        if #candidates == #var3.candidates then
            return
        end

        dataCache5.replaceItem(str1, { candidates = candidates, nextPageCursor = var3.nextPageCursor, hasMore = var3.hasMore })
    end or nil

    local dataResolver = if FFlagConnectionManagementChips then createDataResolver({
        cache = dataCache2,
        supportsMultiGet = false,
        queueProcessDelaySec = func1(),
        replaceItems = true,
        fetchFn = function(str1: string)
            return Requests.GetUserTrustedConnections(str1):andThen(function(arg1)
                local var4 = arg1.PageItems or {}
                return Cryo.List.map(var4, function(arg2)
                    return {
                        id = tostring(arg2.id)
                    }
                end)
            end)
        end
    }) else nil

    local trustedConnectionEventListener = createTrustedConnectionEventListener(function(str1: string, arg1)
        cache.updateItems({ [str1] = arg1 })

        dataCache.updateItems({ [str1] = arg1 == TrustedConnectionStatus.TrustedFriends })

        if FFlagAddFriendsPageTrustedFriendRequestSection and arg1 == TrustedConnectionStatus.RequestReceived then
            var1(str1)
        end

        if FFlagTrustedFriendCandidatesSection and arg1 == TrustedConnectionStatus.TrustedFriends then
            var3(str1)
        end

        if not FFlagConnectionManagementChips then
            return
        end
        local localPlayerUserId = getLocalPlayerUserId()
        if localPlayerUserId then
            dataResolver.fetchItem(tostring(localPlayerUserId))
        end
    end)

    local friendshipEventListener = if FFlagAddFriendsPageTrustedFriendRequestSection then createFriendshipEventListener(function(str1: string, arg1)
        cache.updateItems({ [str1] = arg1 })

        dataCache.updateItems({ [str1] = arg1 == TrustedConnectionStatus.TrustedFriends })

        if arg1 ~= TrustedConnectionStatus.NotFriends then
            return
        end

        var2(str1)

        if FFlagTrustedFriendCandidatesSection then
            var3(str1)
        end
    end) else nil

    local dataResolver2 = createDataResolver({
        cache = dataCache,
        queueProcessDelaySec = func1(),
        fetchFn = function(tbl2)
            local var4 = Cryo.Dictionary.keys(tbl2)
            return Requests.MultiGetUsersAreTrustedConnections(var4):andThen(function(arg1)
                local var5 = Cryo.List.foldLeft(arg1, function(arg2, arg3)
                    arg2[tostring(arg3)] = true
                    return arg2
                end, {})

                return Cryo.List.foldLeft(var4, function(arg2, arg3)
                    arg2[tostring(arg3)] = var5[arg3] or false
                    return arg2
                end, {})
            end)
        end
    })

    local dataResolver3 = createDataResolver({
        cache = cache,
        queueProcessDelaySec = func1(),
        fetchFn = function(tbl2)
            local var4 = Cryo.Dictionary.keys(tbl2)
            local var5 = Cryo.List.foldLeft(var4, function<T>(tbl3: {T}, arg1): {T}
                local userTrustedConnectionStatus = Requests.GetUserTrustedConnectionStatus(arg1)

                table.insert(tbl3, userTrustedConnectionStatus:andThen(function(arg2)
                    return {
                        [arg1] = arg2
                    }
                end))
                return tbl3
            end, {})

            return Promise.all(var5):andThen(function(tbl3: {any})
                return Cryo.Dictionary.join(table.unpack(tbl3))
            end)
        end
    })

    local dataResolver4 = if FFlagAddFriendsPageTrustedFriendRequestSection then createDataResolver({
        cache = dataCache3,
        supportsMultiGet = false,
        replaceItems = true,
        queueProcessDelaySec = func2(),
        fetchFn = function(_: string, arg1)
            local var4 = if bool1 then nil else arg1.data(false)
            bool1 = false
            local nextPageCursor = if var4 then var4.nextPageCursor else nil

            return Requests.GetTrustedFriendRequests(nextPageCursor, FIntTrustedFriendRequestsPageSize):andThen(function(arg2)
                if not FFlagAddFriendsPageHighlightUnseenTrustedRequests then
                    local data = if arg2 then arg2.data else nil

                    local var5 = Cryo.List.map(data or {}, function(arg3): string
                        return tostring(arg3.senderId)
                    end)

                    local senderIds = if var4 then var4.senderIds else nil
                    local nextPageCursor2 = if arg2 then arg2.nextPageCursor else nil
                    return {
                        senderIds = mergeListsWithoutDuplicates(senderIds, var5),
                        nextPageCursor = nextPageCursor2,
                        hasMore = nextPageCursor2 ~= nil
                    }
                end

                local data = if arg2 then arg2.data else nil

                local var5 = Cryo.List.map(data or {}, function(arg3)
                    return {
                        id = tostring(arg3.senderId),
                        isUnseen = arg3.isUnseen
                    }
                end)

                local requests = if var4 then var4.requests else nil
                local nextPageCursor2 = if arg2 then arg2.nextPageCursor else nil
                return {
                    senderIds = nil,
                    requests = mergeListsWithoutDuplicates(requests, var5, "id"),
                    nextPageCursor = nextPageCursor2,
                    hasMore = nextPageCursor2 ~= nil
                }
            end)
        end
    }) else nil

    local dataResolver5 = if FFlagAddFriendsPageTrustedFriendRequestSection then createDataResolver({
        cache = dataCache4,
        supportsMultiGet = false,
        replaceItems = true,
        queueProcessDelaySec = func2(),
        fetchFn = function(_: string)
            return Requests.GetTrustedFriendRequestsCount():andThen(function(arg1)
                return if arg1 then arg1.count else 0
            end)
        end
    }) else nil

    local function fetchTrustedFriendCandidatesPage(str1: string?, num5: number) -- Luacid: Inlined by compiler; 1 call site recovered
        return Requests.GetTrustedFriendCandidates(str1, num2):andThen(function(arg1)
            local var4 = not (arg1 and arg1.data) and {} or arg1.data
            local nextPageCursor = if arg1 then arg1.nextPageCursor else nil
            local candidates = {}
            local statuses = ({})
            for _, value in var4 do
                local id = tostring(value.userId)
                table.insert(candidates, { id = id })
                statuses[id] = tbl1[value.state]
            end

            if #candidates == 0 and nextPageCursor ~= nil and num5 > 1 then
                return fetchTrustedFriendCandidatesPage(nextPageCursor, num5 - 1)
            end

            return { candidates = candidates, statuses = statuses, nextPageCursor = nextPageCursor }
        end)
    end

    local function applyTrustedFriendCandidatesPage(tbl2, tbl3)
        cache.updateItems(tbl2.statuses)

        return {
            candidates = mergeListsWithoutDuplicates(if tbl3 then tbl3.candidates else nil, tbl2.candidates, "id"),
            nextPageCursor = tbl2.nextPageCursor,
            hasMore = tbl2.nextPageCursor ~= nil
        }
    end

    local dataResolver6 = if FFlagTrustedFriendCandidatesSection then createDataResolver({
        cache = dataCache5,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_: string, arg1)
            local var4 = bool2
            bool2 = false
            local var5 = if var4 then nil else arg1.data(false)
            local nextPageCursor = if var5 then var5.nextPageCursor else nil

            return fetchTrustedFriendCandidatesPage(nextPageCursor, num3):andThen(function(tbl2)
                local var6 = if var4 then nil else arg1.data(false)
                return (applyTrustedFriendCandidatesPage(tbl2, var6))
            end)
        end
    }) else nil

    local var4 = FFlagConnectionManagementChips and function()
        local localPlayerUserId = getLocalPlayerUserId()
        return dataResolver.getAndFetchItem(tostring(localPlayerUserId))
    end or nil

    local var5 = FFlagAddFriendsPageTrustedFriendRequestSection and function()
        local str1 = tostring(getLocalPlayerUserId())
        dataResolver5.fetchItem(str1)
    end or nil

    local var6 = FFlagAddFriendsPageTrustedFriendRequestSection and function(tbl2)
        if FFlagAddFriendsPageHighlightUnseenTrustedRequests and tbl2 and tbl2.forceFetch then
            var5()
        end

        local localPlayerUserId = getLocalPlayerUserId()
        return dataResolver5.getAndFetchItem(tostring(localPlayerUserId))
    end or nil

    local var7 = FFlagAddFriendsPageTrustedFriendRequestSection and function()
        local str1 = tostring(getLocalPlayerUserId())
        local var7 = dataCache3.getItem(str1).data(false)
        if var7 and not var7.hasMore then
            return
        end
        dataResolver4.fetchItem(str1)
    end or nil

    local var8 = FFlagAddFriendsPageTrustedFriendRequestSection and function()
        bool1 = true

        local str1 = tostring(getLocalPlayerUserId())
        dataResolver4.fetchItem(str1)
    end or nil

    local var9 = FFlagAddFriendsPageTrustedFriendRequestSection and function(tbl2)
        if FFlagAddFriendsPageHighlightUnseenTrustedRequests and tbl2 and tbl2.forceFetch then
            var8()
        end

        local localPlayerUserId = getLocalPlayerUserId()
        return dataResolver4.getAndFetchItem(tostring(localPlayerUserId))
    end or nil

    local var10 = FFlagTrustedFriendCandidatesSection and function()
        bool2 = true

        local str1 = tostring(getLocalPlayerUserId())

        dataResolver6.refetchItem(str1)
    end or nil

    local var11 = FFlagTrustedFriendCandidatesSection and function(tbl2)
        if tbl2 and tbl2.forceFetch then
            var10()
        end

        local localPlayerUserId = getLocalPlayerUserId()
        return dataResolver6.getAndFetchItem(tostring(localPlayerUserId))
    end or nil

    local var12 = FFlagTrustedFriendCandidatesSection and function()
        local str1 = tostring(getLocalPlayerUserId())
        local var12 = dataCache5.getItem(str1).data(false)
        if var12 and not var12.hasMore then
            return
        end
        dataResolver6.fetchItem(str1)
    end or nil

    local var13 = FFlagTrustedFriendCandidatesSection and function(str1: string)
        return dataResolver3.refetchItem(str1)
    end or nil

    local function sendTrustedConnectionRequest(str1: string, str2: string?)
        return Requests.PostUserSendTrustedConnectionRequest(str1, str2):andThen(function(arg1)
            if FFlagProfileTFCardUseQrScanContext and arg1 and arg1.responseBody and arg1.responseBody.success == false then
                return Promise.reject("Trusted connection request was not sent")
            end
            cache.updateItems({ [str1] = TrustedConnectionStatus.RequestSent })

            return nil
        end)
    end

    local function acceptTrustedConnectionRequest(str1: string)
        return Requests.PostUserAcceptTrustedConnectionRequest(str1):andThen(function()
            cache.updateItems({ [str1] = TrustedConnectionStatus.TrustedFriends })

            dataCache.updateItems({ [str1] = true })

            if FFlagAddFriendsPageTrustedFriendRequestSection then
                var2(str1)
            end

            if FFlagTrustedFriendCandidatesSection then
                var3(str1)
            end
        end)
    end

    local function ignoreTrustedConnectionRequest(str1: string)
        return Requests.PostUserIgnoreTrustedConnectionRequest(str1):andThen(function()
            cache.updateItems({ [str1] = TrustedConnectionStatus.RequestIgnored })

            if FFlagAddFriendsPageTrustedFriendRequestSection then
                var2(str1)
            end
        end)
    end

    local var14 = FFlagAddFriendsPageTrustedFriendRequestSection and function()
        return Requests.PostUserIgnoreAllTrustedFriendRequests():andThen(function()
            local str1 = tostring(getLocalPlayerUserId())
            if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
                dataCache3.replaceItem(str1, { senderIds = nil, requests = {}, nextPageCursor = nil, hasMore = false })
            else
                dataCache3.replaceItem(str1, { senderIds = {}, nextPageCursor = nil, hasMore = false })
            end

            dataCache4.replaceItem(str1, 0)

            if FFlagTrustedFriendCandidatesSection then
                dataResolver3.clear()
            end
        end)
    end or nil

    local function removeTrustedConnectionRequest(str1: string)
        return Requests.PostUserRemoveTrustedConnection(str1):andThen(function()
            cache.updateItems({ [str1] = TrustedConnectionStatus.RequestReceived })

            dataCache.updateItems({ [str1] = false })
        end)
    end

    local function createTrustedFriendLink(str1: string)
        return Requests.PostUserCreateTrustedFriendLink(str1)
    end

    local function validateTrustedFriendLink(str1: string, tbl2)
        return Requests.PostUserValidateTrustedFriendLink(str1, tbl2)
    end

    local function addTrustedFriendFromLink(str1: string, tbl2)
        return Requests.PostUserAddTrustedFriendFromLink(str1, tbl2)
    end

    local function clear()
        cache.clear()
        dataCache.clear()
        dataResolver2.clear()
        dataResolver3.clear()

        if FFlagConnectionManagementChips then
            dataCache2.clear()
            dataResolver.clear()
        end

        if FFlagAddFriendsPageTrustedFriendRequestSection then
            dataCache3.clear()
            dataResolver4.clear()
            dataCache4.clear()
            dataResolver5.clear()
        end

        if FFlagTrustedFriendCandidatesSection then
            dataCache5.clear()
            dataResolver6.clear()
        end
    end

    local function dispose()
        cache.dispose()
        dataCache.dispose()
        dataResolver2.dispose()
        dataResolver3.dispose()
        trustedConnectionEventListener()
        if FFlagAddFriendsPageTrustedFriendRequestSection then
            friendshipEventListener()
        end
        if FFlagConnectionManagementChips then
            dataCache2.dispose()
            dataResolver.dispose()
        end

        if FFlagAddFriendsPageTrustedFriendRequestSection then
            dataCache3.dispose()
            dataResolver4.dispose()
            dataCache4.dispose()
            dataResolver5.dispose()
        end

        if FFlagTrustedFriendCandidatesSection then
            dataCache5.dispose()
            dataResolver6.dispose()
        end
    end

    local tbl2 = {
        getStatus = function(str1: string)
            return dataResolver3.getAndFetchItem(str1)
        end,
        getIsTrustedConnection = function(str1: string)
            return dataResolver2.getAndFetchItem(str1)
        end,
        getUserTrustedConnections = 0,
        getTrustedFriendRequests = 0,
        getTrustedFriendRequestsCount = 0,
        loadMoreTrustedFriendRequests = 0,
        refetchTrustedFriendRequests = 0,
        refetchTrustedFriendRequestsCount = 0,
        getTrustedFriendCandidates = 0,
        loadMoreTrustedFriendCandidates = 0,
        refetchTrustedFriendCandidates = 0,
        refetchStatus = 0,
        sendTrustedConnectionRequest = 0,
        acceptTrustedConnectionRequest = 0,
        ignoreTrustedConnectionRequest = 0,
        ignoreAllTrustedFriendRequests = 0,
        removeTrustedConnectionRequest = 0,
        createTrustedFriendLink = 0,
        validateTrustedFriendLink = 0,
        addTrustedFriendFromLink = 0,
        clear = 0,
        dispose = 0
    }

    if not FFlagConnectionManagementChips then
        var4 = nil
    end

    tbl2.getUserTrustedConnections = var4
    if not FFlagAddFriendsPageTrustedFriendRequestSection then
        var9 = nil
    end

    tbl2.getTrustedFriendRequests = var9

    if not FFlagAddFriendsPageTrustedFriendRequestSection then
        var6 = nil
    end

    tbl2.getTrustedFriendRequestsCount = var6

    if not FFlagAddFriendsPageTrustedFriendRequestSection then
        var7 = nil
    end

    tbl2.loadMoreTrustedFriendRequests = var7

    tbl2.refetchTrustedFriendRequests = if FFlagAddFriendsPageTrustedFriendRequestSection then var8 else nil

    tbl2.refetchTrustedFriendRequestsCount = if FFlagAddFriendsPageTrustedFriendRequestSection then var5 else nil

    if not FFlagTrustedFriendCandidatesSection then
        var11 = nil
    end

    tbl2.getTrustedFriendCandidates = var11

    if not FFlagTrustedFriendCandidatesSection then
        var12 = nil
    end

    tbl2.loadMoreTrustedFriendCandidates = var12

    tbl2.refetchTrustedFriendCandidates = if FFlagTrustedFriendCandidatesSection then var10 else nil

    if not FFlagTrustedFriendCandidatesSection then
        var13 = nil
    end

    tbl2.refetchStatus = var13

    tbl2.sendTrustedConnectionRequest = sendTrustedConnectionRequest
    tbl2.acceptTrustedConnectionRequest = acceptTrustedConnectionRequest
    tbl2.ignoreTrustedConnectionRequest = ignoreTrustedConnectionRequest
    if not FFlagAddFriendsPageTrustedFriendRequestSection then
        var14 = nil
    end

    tbl2.ignoreAllTrustedFriendRequests = var14

    tbl2.removeTrustedConnectionRequest = removeTrustedConnectionRequest

    tbl2.createTrustedFriendLink = createTrustedFriendLink

    tbl2.validateTrustedFriendLink = validateTrustedFriendLink
    tbl2.addTrustedFriendFromLink = addTrustedFriendFromLink

    tbl2.clear = clear
    tbl2.dispose = dispose
    return tbl2
end

return createTrustedConnectionsStore
