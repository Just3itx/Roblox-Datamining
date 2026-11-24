-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local DataStatus = require(DataHydration.DataHydrationTypes).DataStatus
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId
local mergeListsWithoutDuplicates = require(DataHydration.DataHydrationUtils).mergeListsWithoutDuplicates

local Cryo = require(DataHydrationParent.Cryo)
local Signals = require(DataHydrationParent.Signals)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local LocalUserIdStore = require(DataHydrationParent.LocalUserIdStore).LocalUserIdStore

local FFlagEnableFriendsStoreChallengeInterceptor = SharedFlags.FFlagEnableFriendsStoreChallengeInterceptor
local FFlagFriendSortedByPresenceSignalsImplementation = SharedFlags.FFlagFriendSortedByPresenceSignalsImplementation
local FFlagFriendsStoreSortOnlineFriendsByRank = SharedFlags.FFlagFriendsStoreSortOnlineFriendsByRank
local FFlagPresenceRefetchTelemetryEnabled = require(DataHydration.Flags.FFlagPresenceRefetchTelemetryEnabled)

local FFlagAddFriendsPageTrustedFriendRequestSection = require(DataHydrationParent.SharedFlags).FFlagAddFriendsPageTrustedFriendRequestSection
local FFlagPresenceLocationType = SharedFlags.FFlagPresenceLocationType
local Requests = require(DataHydration.Friends.Requests)
local FindFriendsSort = require(DataHydration.Friends.Enums.FindFriendsSort)
local mapFriendshipStatusToEnum = require(DataHydration.Friends.mapFriendshipStatusToEnum)

local PresenceStore = require(DataHydration.Presence.PresenceStore)
local normalizePresenceRawData = require(DataHydration.Presence.normalizePresenceRawData)
local PresenceType = require(DataHydration.Presence.Enums.PresenceType)
local _createPresenceStore = require(DataHydration.Presence.createPresenceStore)

game:DefineFastInt("FriendsStoreProcessDelaySec", 1)
local function getFIntFriendsStoreProcessDelaySec(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetFastInt("FriendsStoreProcessDelaySec")
end

local num1 = game:DefineFastInt("OnlineFriendsCacheTtlSec", 0)
local num2 = game:DefineFastInt("IsFriendsWithCacheTtlSec", 0)
local num3 = game:DefineFastInt("AllFriendsCacheTtlSec", 0)
local num4 = game:DefineFastInt("FriendshipStatusCacheTtlSec", 0)
local num5 = game:DefineFastInt("FriendsCountCacheTtlSec", 0)

local function getCacheTTL(num6: number): number -- Luacid: Inlined by compiler; 5 call sites recovered
    return if num6 and num6 > 0 then num6 else math.huge
end

local num6 = game:DefineFastInt("FriendsPageSize", 50)
local num7 = game:DefineFastInt("InitialFriendsPageSize", 20)

local function normalizeId(arg1) -- Luacid: Inlined by compiler; 7 call sites recovered
    if not arg1 then
        return nil
    end

    return tostring(arg1)
end

local function normalizeStoredOnlineFriendRow(arg1): {id: number, sortScore: number}?
    if not arg1 or type(arg1) ~= "table" or arg1.id == nil then
        return nil
    end
    return {
        id = tostring(arg1.id),
        sortScore = tonumber(arg1.sortScore) or 0
    }
end

local function normalizePresenceFromOnlineFriendsRow(arg1)
    if not arg1 or type(arg1) ~= "table" or arg1.id == nil then
        return nil
    end

    local userPresence = arg1.userPresence
    if not userPresence or type(userPresence) ~= "table" then
        return nil
    end

    local tbl1 = {
        userPresenceType = userPresence.UserPresenceType,
        lastLocation = userPresence.lastLocation,
        lastOnline = userPresence.lastOnline,
        gameId = userPresence.gameInstanceId,
        placeId = userPresence.placeId,
        rootPlaceId = userPresence.rootPlaceId,
        universeId = userPresence.universeId,
        locationType = if FFlagPresenceLocationType then userPresence.UserLocationType else nil
    }
    return normalizePresenceRawData(tbl1, arg1.id)
end

local function normalizeFindFriendsNextCursor(str1: string?): string? -- Luacid: Inlined by compiler; 3 call sites recovered
    return if str1 == nil or str1 == "" then nil else str1
end

local function normalizeFindFriendsPageResponse(arg1)
    local friends = {}
    for _, value in not arg1 and {} or not arg1.PageItems and {} or arg1.PageItems do
        local id = normalizeId(value.id)
        if id then
            table.insert(friends, { id = id })
        end
    end

    local nextCursor = if arg1 then arg1.NextCursor else nil
    local var1 = normalizeFindFriendsNextCursor(nextCursor)
    return {
        friends = friends,
        nextCursor = var1,
        hasMore = if arg1 and arg1.HasMore ~= nil then arg1.HasMore else var1 ~= nil
    }
end

local function mergeListsWithoutDuplicates2(friends, tbl1, str1: string?)
    if not tbl1 or #tbl1 == 0 then
        return friends or {}
    end
    if not friends or #friends == 0 then
        return tbl1
    end

    local var1 = Cryo.List.toSet(Cryo.List.map(friends, function(arg1)
        return if str1 then arg1[str1] else arg1
    end))

    local var2 = Cryo.List.filter(tbl1, function(arg1): boolean
        if str1 then
            arg1 = arg1[str1]
        end

        return not var1[arg1]
    end)

    return Cryo.List.join(table.clone(friends), var2)
end

local function mergeAllFriendsPage(tbl1, tbl2, str1: string?)
    if not tbl1 then
        return {
            friends = tbl2.friends,
            nextCursor = tbl2.nextCursor,
            hasMore = tbl2.hasMore
        }
    end

    if normalizeFindFriendsNextCursor(tbl1.nextCursor) ~= normalizeFindFriendsNextCursor(str1) then
        return tbl1
    end

    return {
        friends = if FFlagAddFriendsPageTrustedFriendRequestSection then mergeListsWithoutDuplicates(tbl1.friends, tbl2.friends, "id") else mergeListsWithoutDuplicates2(tbl1.friends, tbl2.friends, "id"),
        nextCursor = tbl2.nextCursor,
        hasMore = tbl2.hasMore
    }
end

local function resolveLocalUserId(arg1) -- Luacid: Inlined by compiler; 18 call sites recovered
    local currentUserId = LocalUserIdStore.getCurrentUserId(arg1)
    if currentUserId ~= "" then
        return currentUserId
    end
    local localPlayerUserId = getLocalPlayerUserId()
    if localPlayerUserId then
        return tostring(localPlayerUserId)
    end

    return ""
end

local function createFriendsStore()
    local var1 = PresenceStore.get()
    local var2 = if FFlagFriendSortedByPresenceSignalsImplementation then nil else tostring(getLocalPlayerUserId())
    local cache = createDataCache((getCacheTTL(num1)))
    local dataCache = createDataCache((getCacheTTL(num2)))
    local dataCache2 = createDataCache((getCacheTTL(num3)))
    local bool1 = false

    local dataCache3 = createDataCache((getCacheTTL(num4)))
    local dataCache4 = createDataCache((getCacheTTL(num5)))

    local tbl1 = ({})

    local function appendUserToAllFriends(id: string)
        local var3 = if FFlagFriendSortedByPresenceSignalsImplementation then resolveLocalUserId(false) else var2
        local var4 = dataCache2.getItem(var3).data(false)
        if not var4 then
            return
        end

        local friends = if FFlagAddFriendsPageTrustedFriendRequestSection then mergeListsWithoutDuplicates(var4.friends, {{ id = id }}, "id") else mergeListsWithoutDuplicates2(var4.friends, {{ id = id }}, "id")

        if #friends == #var4.friends then
            return
        end
        dataCache2.replaceItem(var3, { friends = friends, nextCursor = var4.nextCursor, hasMore = var4.hasMore })
    end

    local function UpdateIsFriendsWith(str1: string, bool2: boolean) -- Luacid: Inlined by compiler; 4 call sites recovered
        dataCache.replaceItem(str1, bool2)

        if bool2 then
            appendUserToAllFriends(str1)
            dataCache3.replaceItem(str1, Enum.FriendStatus.Friend)
        end

        if not bool2 then
            var1.UpdateUserPresence(str1, nil, { isUpdatedRealtime = false })
        end
    end

    local function updateOnlineFriendDependecies(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        var1.UpdateUserPresence(arg1, arg2, { isUpdatedRealtime = true })
        UpdateIsFriendsWith(arg1, true)
    end

    local function updateOfflineFriendDependencies(id)
        local var3 = var1.GetPresenceByUserId(id, { skipFetch = true }).data(false)
        var1.UpdateUserPresence(
            id,
            var3 or normalizePresenceRawData({ userPresenceType = PresenceType.Offline }),
            { isUpdatedRealtime = true }
        )
        UpdateIsFriendsWith(id, true)
    end

    local function applyGetOnlineFriendsResponseBody(arg1)
        local result = ({})

        for _, value in not arg1 and {} or arg1.data or {} do
            local var3 = normalizeId(value.id)
            local var4 = normalizeStoredOnlineFriendRow(value)
            local var5 = normalizePresenceFromOnlineFriendsRow(value)

            if var3 then
                result[var3] = var4
                updateOnlineFriendDependecies(var3, var5)
            end
        end

        return result
    end

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, arg1)
            local var3 = arg1.data(false) or {}

            return Requests.GetOnlineFriends(str1):andThen(function(arg2)
                for _, value in var3 do
                    local var4 = normalizeId(value and value.id)
                    if not var4 then
                        continue
                    end

                    var1.UpdateUserPresence(
                        var4,
                        normalizePresenceRawData({ userPresenceType = PresenceType.Offline }),
                        { isUpdatedRealtime = true }
                    )
                end

                return (applyGetOnlineFriendsResponseBody(arg2))
            end):catch(function(arg2)
                error(arg2)
            end)
        end
    })

    local function fetchFriendshipStatuses(tbl2) -- Luacid: unused: defined but never referenced
        local var3 = if FFlagFriendSortedByPresenceSignalsImplementation then resolveLocalUserId(false) else var2

        return Requests.MultiGetFriendshipStatuses(var3, tbl2):andThen(function(arg1)
            local result = ({})

            for _, value in not arg1 and {} or arg1.data or {} do
                local var4 = normalizeId(value.id)
                if var4 then
                    result[var4] = mapFriendshipStatusToEnum(value.status)
                end
            end
            return result
        end)
    end

    local dataResolver2 = createDataResolver({
        cache = dataCache,
        queueProcessDelaySec = getFIntFriendsStoreProcessDelaySec(),
        fetchFn = function(tbl2)
            local var3 = Cryo.Dictionary.keys(tbl2)
            local var4 = if FFlagFriendSortedByPresenceSignalsImplementation then resolveLocalUserId(false) else var2

            return Requests.MultiGetFriendshipStatuses(var4, var3):andThen(function(arg1)
                local result = ({})

                for _, value in not arg1 and {} or arg1.data or {} do
                    local var5 = normalizeId(value.id)
                    if var5 then
                        result[var5] = mapFriendshipStatusToEnum(value.status)
                    end
                end
                return result
            end):andThen(function(tbl3)
                dataCache3.replaceItems(tbl3)
                local result = ({})
                for value, value2 in tbl3 do
                    result[value] = value2 == Enum.FriendStatus.Friend
                end
                return result
            end)
        end
    })

    local dataResolver3 = createDataResolver({
        cache = dataCache3,
        queueProcessDelaySec = getFIntFriendsStoreProcessDelaySec(),
        fetchFn = function(tbl2)
            local var3 = Cryo.Dictionary.keys(tbl2)
            local var4 = if FFlagFriendSortedByPresenceSignalsImplementation then resolveLocalUserId(false) else var2

            return Requests.MultiGetFriendshipStatuses(var4, var3):andThen(function(arg1)
                local result = ({})

                for _, value in not arg1 and {} or arg1.data or {} do
                    local var5 = normalizeId(value.id)
                    if var5 then
                        result[var5] = mapFriendshipStatusToEnum(value.status)
                    end
                end
                return result
            end):andThen(function<T>(tbl3): T
                local tbl4 = ({})
                for value, value2 in tbl3 do
                    tbl4[value] = value2 == Enum.FriendStatus.Friend
                end
                dataCache.replaceItems(tbl4)
                return tbl3
            end)
        end
    })

    local dataResolver4 = createDataResolver({
        cache = dataCache2,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(arg1, arg2)
            local var3 = if bool1 then nil else arg2.data(false)
            bool1 = false
            local nextCursor = if var3 then var3.nextCursor else nil
            local limit = if var3 then num6 else num7

            return Requests.GetFindFriendsPage(arg1, { limit = limit, cursor = nextCursor, sort = FindFriendsSort.FriendshipScore }):andThen(
                function(arg3)
                    local tbl2 = normalizeFindFriendsPageResponse(arg3)
                    for _, friend in tbl2.friends do
                        updateOfflineFriendDependencies(friend.id)
                    end

                    return (mergeAllFriendsPage(var3, tbl2, nextCursor))
                end
            ):catch(
                function(arg3)
                    error(arg3)
                end
            )
        end
    })
    local dataResolver5 = createDataResolver({
        cache = dataCache4,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string)
            return Requests.GetFriendsCountFromUserId(str1):andThen(function(arg1)
                return if arg1 then arg1.count else 0
            end)
        end
    })

    local computed = Signals.createComputed(function(arg1)
        local var3 = resolveLocalUserId(arg1)
        local var4 = dataResolver.getAndFetchItem(var3).data(arg1)

        if var4 == nil then
            return nil
        end

        local result = {}
        for _, value in pairs(var4) do
            if not value then
                continue
            end
            local presence = var1.GetPresenceByUserId(value.id, { skipFetch = true }).data(arg1)
            if not dataResolver2.getCachedItem(value.id).data(arg1)
                or not presence
                or not presence.userPresenceType
                or presence.userPresenceType == PresenceType.Offline
            then
                continue
            end
            table.insert(result, { id = value.id, sortScore = value.sortScore, presence = presence })
        end

        if FFlagFriendsStoreSortOnlineFriendsByRank then
            table.sort(result, function(arg2, arg3): boolean
                return arg2.sortScore > arg3.sortScore
            end)
        end

        return result
    end)

    local function GetOnlineFriends()
        local var3 = resolveLocalUserId(false)
        dataResolver.getAndFetchItem(var3)

        return computed
    end

    local onlineFriendsStatus = Signals.createComputed(function(arg1)
        local var3 = resolveLocalUserId(arg1)
        return dataResolver.getCachedItem(var3).status(arg1)
    end)

    local function GetOnlineFriendsByUniverseId(universeId: string)
        local var3 = resolveLocalUserId(false)
        dataResolver.getAndFetchItem(var3)

        local var4 = tbl1[universeId]
        if var4 then
            return var4
        end

        local computed3 = Signals.createComputed(function(arg1)
            local var5 = computed(arg1)
            if not var5 then
                return {}
            end

            local result = {}
            for _, value in var5 do
                if value.presence and value.presence.universeId == universeId then
                    table.insert(result, value)
                end
            end
            return result
        end)

        tbl1[universeId] = computed3
        return computed3
    end

    local computed3 = Signals.createComputed(function(arg1)
        local var3 = resolveLocalUserId(arg1)
        local var4 = dataResolver4.getAndFetchItem(var3).data(arg1)

        if var4 == nil then
            return nil
        end

        local var5 = var4.friends or {}

        return {
            friends = Cryo.List.filter(var5, function(arg2)
                return dataResolver2.getCachedItem(arg2.id).data(arg1)
            end),
            hasMore = var4.hasMore,
            nextCursor = var4.nextCursor
        }
    end)

    local allFriendsStatus = Signals.createComputed(function(arg1)
        local var3 = resolveLocalUserId(arg1)
        return dataResolver4.getCachedItem(var3).status(arg1)
    end)

    local function UpdateFriendshipStatus(str1: string, friendStatus) -- Luacid: Inlined by compiler; 6 call sites recovered
        dataCache3.replaceItem(str1, friendStatus)

        UpdateIsFriendsWith(str1, friendStatus == Enum.FriendStatus.Friend)
    end

    return {
        GetOnlineFriends = GetOnlineFriends,
        GetOnlineFriendsStatus = function()
            return onlineFriendsStatus
        end,
        RefetchOnlineFriends = function()
            dataResolver.fetchItem((resolveLocalUserId(false)))
        end,
        GetOnlineFriendsByUniverseId = GetOnlineFriendsByUniverseId,
        GetAllFriends = function()
            local var3 = resolveLocalUserId(false)
            dataResolver4.getAndFetchItem(var3)

            return computed3
        end,
        GetAllFriendsStatus = function()
            return allFriendsStatus
        end,
        FetchMoreFriends = function()
            local var3 = resolveLocalUserId(false)
            local cachedItem = dataResolver4.getCachedItem(var3)
            local var4 = cachedItem.data(false)

            if var4 ~= nil
                and var4.hasMore
                and var4.nextCursor ~= nil
                and cachedItem.status(false) ~= DataStatus.NotReady
                and not dataResolver4.isRequestInQueueOrInFlight(var3)
            then
                dataResolver4.fetchItem(var3)
            end
        end,
        RefetchAllFriends = function()
            bool1 = true

            dataResolver4.fetchItem((resolveLocalUserId(false)))
        end,
        GetIsFriendWith = function(str1: string)
            return dataResolver2.getAndFetchItem(str1)
        end,
        UpdateIsFriendsWith = UpdateIsFriendsWith,
        GetFriendsCountByUserId = function(str1: string, tbl2)
            if tbl2 and tbl2.skipFetch then
                return dataResolver5.getCachedItem(str1)
            end
            return dataResolver5.getAndFetchItem(str1)
        end,
        RefreshFriendsCountByUserId = function(str1: string)
            dataResolver5.fetchItem(str1)
        end,
        clear = function()
            dataResolver.clear()
            dataResolver2.clear()
            dataResolver4.clear()
            dataResolver3.clear()
            dataResolver5.clear()
            table.clear(tbl1)
        end,
        dispose = function()
            dataResolver.dispose()
            dataResolver2.dispose()
            dataResolver4.dispose()
            dataResolver3.dispose()
            dataResolver5.dispose()
            table.clear(tbl1)
        end,
        _fetchOnlineFriendsAsync = function()
            local var3 = resolveLocalUserId(false)

            return Requests.GetOnlineFriends(var3):andThen(function(arg1)
                local tbl2 = applyGetOnlineFriendsResponseBody(arg1)
                cache.replaceItems({ [var3] = tbl2 })
                return arg1 or { data = nil }
            end):catch(function(arg1)
                error(arg1)
            end)
        end,
        _getCachedFriendsPresences = function()
            if not FFlagPresenceRefetchTelemetryEnabled then
                return nil
            end

            local var3 = resolveLocalUserId(false)
            local var4 = dataResolver.getCachedItem(var3).data(false)
            if var4 == nil then
                return nil
            end

            local result = {}
            for _, value in pairs(var4) do
                if not value then
                    continue
                end

                table.insert(result, { id = value.id, presence = var1.GetPresenceByUserId(value.id, { skipFetch = true }).data(false) })
            end

            return result
        end,
        _getFetchedFriendIds = function()
            if not FFlagPresenceRefetchTelemetryEnabled then
                return nil
            end

            local var3 = resolveLocalUserId(false)
            local var4 = dataResolver.getCachedItem(var3).data(false)
            local var5 = dataResolver4.getCachedItem(var3).data(false)
            if var4 == nil and var5 == nil then
                return nil
            end

            local result = {}
            if var5 then
                for _, friend in var5.friends do
                    result[friend.id] = true
                end
            end
            if var4 then
                for _, value in pairs(var4) do
                    if value then
                        result[value.id] = true
                    end
                end
            end
            return result
        end,
        _updateFriendsPresences = function(tbl2, tbl3, _: string?)
            if not tbl2 then
                return
            end

            local tbl4 = tbl3 or {}

            local tbl5 = ({})

            for _, value in pairs(tbl2) do
                local id = normalizeId(value.userId)
                if not id then
                    continue
                end

                local var4 = normalizeStoredOnlineFriendRow({ id = id, sortScore = tbl4[id] })

                local var5 = normalizePresenceRawData(value)
                tbl5[id] = var4
                updateOnlineFriendDependecies(id, var5)
            end

            cache.updateItem(resolveLocalUserId(false), tbl5)
        end,
        GetFriendshipStatus = function(str1: string, tbl2)
            if str1 == "" then
                return nil
            elseif tbl2 and tbl2.skipFetch then
                return dataResolver3.getCachedItem(str1)
            end
            return dataResolver3.getAndFetchItem(str1)
        end,
        UpdateFriendshipStatus = UpdateFriendshipStatus,
        RefetchFriendshipStatus = function(str1: string)
            if str1 == "" then
                return
            end
            dataResolver3.fetchItem(str1)
        end,
        RequestFriendship = function(str1: string, str2: string?, tbl2, func1: ((...any) -> (...any))?)
            if not FFlagEnableFriendsStoreChallengeInterceptor then
                func1 = nil
            end

            local var3 = if tbl2 and tbl2.isContact then Requests.RequestFriendshipFromContactId(str1, func1) else Requests.RequestFriendshipFromUserId(str1, str2, func1)

            return var3:andThen(function()
                UpdateFriendshipStatus(str1, Enum.FriendStatus.FriendRequestSent)
            end):catch(function(arg1)
                if (if type(arg1) == "table" then arg1.firstErrorCode else nil) == 5 then
                    UpdateFriendshipStatus(str1, Enum.FriendStatus.Friend)
                    return
                end

                error(arg1)
            end)
        end,
        AcceptFriendRequest = function(str1: string)
            return Requests.AcceptFriendRequestFromUserId(str1):andThen(function()
                UpdateFriendshipStatus(str1, Enum.FriendStatus.Friend)
            end):catch(function(arg1)
                if (if type(arg1) == "table" then arg1.firstErrorCode else nil) == 5 then
                    UpdateFriendshipStatus(str1, Enum.FriendStatus.Friend)
                    return
                end

                error(arg1)
            end)
        end,
        DeclineFriendRequest = function(str1: string)
            return Requests.DeclineFriendRequestFromUserId(str1):andThen(function()
                UpdateFriendshipStatus(str1, Enum.FriendStatus.NotFriend)
            end)
        end,
        Unfriend = function(str1: string)
            return Requests.UnfriendTargetUserId(str1):andThen(function()
                UpdateFriendshipStatus(str1, Enum.FriendStatus.NotFriend)
            end)
        end
    }
end

return createFriendsStore
