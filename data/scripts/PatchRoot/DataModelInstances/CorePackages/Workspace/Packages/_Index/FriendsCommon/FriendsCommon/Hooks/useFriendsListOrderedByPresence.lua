-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommon = script:FindFirstAncestor("FriendsCommon")
local FriendsCommonParent = FriendsCommon.Parent

local React = require(FriendsCommonParent.React)
local Cryo = require(FriendsCommonParent.Cryo)

local ApolloClient = require(FriendsCommonParent.ApolloClient)
local useQuery = ApolloClient.useQuery
local useApolloClient = ApolloClient.useApolloClient

local queries = require(FriendsCommonParent.ApolloLocalState).queries

local ApolloFriends = require(FriendsCommonParent.ApolloFriends)
local ApolloPresence = require(FriendsCommonParent.ApolloPresence)

local PresenceType = require(FriendsCommonParent.GraphQLServer).types.PresenceType

local useSignalState = require(FriendsCommonParent.SignalsReact).useSignalState
local DataHydration = require(FriendsCommonParent.DataHydration)

local FriendsCommonPresenceUpdateSignal = require(FriendsCommon.Signals).FriendsCommonPresenceUpdateSignal

local num1 = game:DefineFastInt("FriendsListDefaultPageSize", 12)

local FFlagFriendSortedByPresenceSignalsImplementation = require(FriendsCommonParent.SharedFlags).FFlagFriendSortedByPresenceSignalsImplementation

local usePresenceImpressionEvents = require(script.Parent.usePresenceImpressionEvents)

local bool1 = game:DefineFastFlag("UseFriendsListOrderedByIdPresenceImpressionEventsEnabled", false)

local bool2 = game:DefineFastFlag("FriendsListStableEmptyOnlineFriends", false)

local var1 = DataHydration.Friends.FriendsStore.get()

local var2 = table.freeze({})

local function func1(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return Cryo.List.map(tbl1, function(arg1)
        if not arg1.presence or arg1.presence.userPresenceType ~= PresenceType.InGame or arg1.presence.universeId ~= "" then
            return arg1
        end

        local presence = Cryo.Dictionary.join(arg1.presence, { userPresenceType = PresenceType.Online })
        return Cryo.Dictionary.join(arg1, { presence = presence })
    end)
end

local function func2(tbl1, tbl2)
    local tbl3 = {}

    for _, value in tbl1 do
        tbl3[value.id] = value.presence
    end

    local var3 = Cryo.List.filter(tbl2 or {}, function(arg1): boolean
        return not tbl3[arg1.id]
    end)

    return Cryo.List.sort(tbl1, function(arg1, arg2): boolean
        return arg1.sortScore > arg2.sortScore
    end), var3
end

local function shouldRefetchOnlineFriends(arg1, variables, arg2): boolean
    local var3 = arg1:readQuery({ query = queries.onlineFriendsByUserId, variables = variables })

    local tbl1 = {}

    for _, value in not var3 and {} or var3.onlineFriendsByUserId or {} do
        tbl1[value.id] = value.presence
    end

    return #Cryo.List.filter(arg2, function(arg3): boolean
        return not (ApolloPresence.Formatters.formatNumberToPresenceType(arg3.userPresenceType) == PresenceType.Offline)
            and not tbl1[tostring(arg3.userId)]
    end) > 0
end

local function bulkUpdateUserPresences(arg1, arg2)
    for _, value in arg2 do
        ApolloPresence.Mutations.createUserPresenceCache(arg1, {
            id = value.userId,
            userPresenceNumber = value.userPresenceType,
            lastLocation = value.lastLocation,
            lastOnline = value.lastOnline,
            gameId = value.gameId,
            placeId = value.placeId,
            rootPlaceId = value.rootPlaceId,
            universeId = value.universeId
        })
    end
end

local function useFriendsListOrderedByPresence(tbl1)
    local var3 = if FFlagFriendSortedByPresenceSignalsImplementation then nil else useApolloClient()

    local var4 = if FFlagFriendSortedByPresenceSignalsImplementation then React.useMemo(function()
        return var1.GetOnlineFriends()
    end, {}) else nil

    local var5 = if FFlagFriendSortedByPresenceSignalsImplementation then useSignalState(var4) else nil
    local pageLimit = tbl1.pageSize or num1

    local var7 = if FFlagFriendSortedByPresenceSignalsImplementation then React.useMemo(function()
        return var1.GetAllFriends()
    end, {}) else nil

    local var8 = if FFlagFriendSortedByPresenceSignalsImplementation then useSignalState(var7) else nil

    local var9 = if FFlagFriendSortedByPresenceSignalsImplementation then React.useMemo(function()
        return var1.GetAllFriendsStatus()
    end, {}) else nil

    local var10 = if FFlagFriendSortedByPresenceSignalsImplementation then useSignalState(var9) else nil
    local variables = {
        userId = tbl1.userId,
        sort = ApolloFriends.Enums.Sort.FriendshipScore
    }

    local var11 = React.useRef(nil)
    local var12 = React.useRef(nil)
    local var13 = if FFlagFriendSortedByPresenceSignalsImplementation then nil else useQuery(queries.allFriendsByUserId, {
        errorPolicy = "all",
        skip = false,
        notifyOnNetworkStatusChange = true,
        variables = Cryo.Dictionary.join(variables, { pageLimit = pageLimit, pageCursor = "" })
    })
    local var14 = if FFlagFriendSortedByPresenceSignalsImplementation then nil else useQuery(queries.onlineFriendsByUserId, { skip = false, notifyOnNetworkStatusChange = true, variables = variables })
    local nextCursor = if FFlagFriendSortedByPresenceSignalsImplementation then if var8 then var8.nextCursor or nil else nil elseif var13.data then var13.data.allFriendsByUserId.nextCursor else nil
    local friends = if FFlagFriendSortedByPresenceSignalsImplementation then if var8 then var8.friends or nil else nil elseif var13.data then var13.data.allFriendsByUserId.friends else nil
    local hasMore = if FFlagFriendSortedByPresenceSignalsImplementation and var8 then var8.hasMore or nil else nil
    local var15 = if FFlagFriendSortedByPresenceSignalsImplementation then var5 or not bool2 and {} or var2 else not var14.data and {} or var14.data.onlineFriendsByUserId or {}

    local fetchMoreFriends = React.useCallback(function()
        if FFlagFriendSortedByPresenceSignalsImplementation then
            if not hasMore then
                return
            end
        elseif not nextCursor or nextCursor == "" or var13.loading then
            return
        end

        if FFlagFriendSortedByPresenceSignalsImplementation then
            var1.FetchMoreFriends()
            return
        end
        var13:fetchMore({ variables = { pageCursor = nextCursor, pageLimit = pageLimit } }):andThen(function(arg1)
            var12.current = arg1 and arg1.errors
        end)

        var11.current = nextCursor
    end, { if FFlagFriendSortedByPresenceSignalsImplementation then nil else nextCursor, if FFlagFriendSortedByPresenceSignalsImplementation then nil else var13.loading, if FFlagFriendSortedByPresenceSignalsImplementation then hasMore else nil })

    local function refreshFriendsData()
        if FFlagFriendSortedByPresenceSignalsImplementation then
            var1.RefetchOnlineFriends()
            var1.RefetchAllFriends()
            return
        end
        var14:refetch()
        var13:refetch()
        var11.current = nil
        var12.current = nil
    end

    if not FFlagFriendSortedByPresenceSignalsImplementation then
        React.useEffect(function()
            FriendsCommonPresenceUpdateSignal.Event:Connect(function(arg1)
                bulkUpdateUserPresences(var3, arg1)
                if not shouldRefetchOnlineFriends(var3, variables, arg1) then
                    return
                end

                if FFlagFriendSortedByPresenceSignalsImplementation then
                    var1._fetchOnlineFriendsAsync()
                    return
                end
                var14:refetch()
            end)

            return function()
                FriendsCommonPresenceUpdateSignal:Destroy()
            end
        end, {})
    end

    local onlineFriends, offlineFriends = React.useMemo(function()
        return func2(func1(var15), friends)
    end, { var15, friends })

    if bool1 then
        usePresenceImpressionEvents(var15)
    end

    local bool3 = not nextCursor or nextCursor == ""
    local isLoading = if FFlagFriendSortedByPresenceSignalsImplementation then var8 == nil and var10 == DataHydration.DataStatus.NotReady else var13.loading
    local tbl3 = {
        onlineFriends = onlineFriends,
        offlineFriends = offlineFriends,
        fetchMoreFriends = fetchMoreFriends,
        refreshFriendsData = refreshFriendsData,
        isEndOfList = 0,
        isLoading = 0
    }

    if FFlagFriendSortedByPresenceSignalsImplementation then
        bool3 = not hasMore
    end

    tbl3.isEndOfList = bool3
    tbl3.isLoading = isLoading
    return tbl3
end

return useFriendsListOrderedByPresence
