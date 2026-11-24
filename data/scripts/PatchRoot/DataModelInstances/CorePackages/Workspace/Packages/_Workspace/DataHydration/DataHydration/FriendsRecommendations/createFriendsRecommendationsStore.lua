-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId
local LocalUserIdStore = require(DataHydrationParent.LocalUserIdStore).LocalUserIdStore

local Requests = require(script.Parent.Requests)
local _FriendsRecommendationsStoreTypes = require(script.Parent.FriendsRecommendationsStoreTypes)
local ContextType = require(script.Parent.Enums.ContextType)

local FFlagShowClassmatesOnPYMK = require(DataHydrationParent.SharedFlags.FFlagShowClassmatesOnPYMK)

local tbl1 = {
    [ContextType.None] = true,
    [ContextType.MutualFriends] = true,
    [ContextType.Frequents] = true,
    [ContextType.Contacts] = true
}

if FFlagShowClassmatesOnPYMK then
    tbl1[ContextType.Classmates] = true
end

local function resolveTargetUserId() -- Luacid: Inlined by compiler; 1 call site recovered
    local currentUserId = LocalUserIdStore.getCurrentUserId(false)
    if currentUserId ~= "" then
        return currentUserId
    end
    local localPlayerUserId = getLocalPlayerUserId()
    if localPlayerUserId then
        return tostring(localPlayerUserId)
    end

    return ""
end

local function normalizeRecommendation(arg1)
    local contactId = if arg1.contactId and arg1.contactId ~= "" then arg1.contactId else nil
    return {
        id = tostring(contactId or arg1.id),
        rank = arg1.rank or 0,
        hasIncomingFriendRequest = not not arg1.friendRequest,
        type = if contactId then "Contact" else "User",
        contactProps = {
            contactId = contactId,
            displayName = arg1.displayName,
            thumbnailEntities = arg1.thumbnailEntities
        },
        contextProps = {
            contextType = if arg1.contextType and tbl1[arg1.contextType] then arg1.contextType else nil,
            mutualFriendsCount = arg1.mutualFriendsCount or arg1.mutualFriendsList and #arg1.mutualFriendsList or nil
        }
    }
end

local function createFriendsRecommendationsStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(str1: string, _)
            return Requests.GetFriendsRecommendations(resolveTargetUserId(), str1):andThen(function(arg1)
                local var1 = if arg1.data then Cryo.List.map(arg1.data, normalizeRecommendation) else nil

                if var1 then
                    table.sort(var1, function(arg2, arg3): boolean
                        return (arg2.rank or 0) < (arg3.rank or 0)
                    end)
                end

                return {
                    data = var1,
                    recommendationRequestId = arg1.recommendationRequestId
                }
            end)
        end
    })

    return {
        getFriendsRecommendations = function(str1: string, tbl2)
            if tbl2 and tbl2.skipFetch then
                return dataResolver.getCachedItem(str1)
            end
            if tbl2 and tbl2.forceFetch and not dataResolver.isRequestInQueueOrInFlight(str1) then
                dataResolver.fetchItem(str1)
            end

            return dataResolver.getAndFetchItem(str1)
        end,
        refreshFriendsRecommendations = function(str1: string)
            return dataResolver.fetchItem(str1)
        end,
        removeFriendsRecommendationByUserId = function(str1: string, id: string)
            local var1 = dataResolver.getCachedItem(str1).data(false)
            if var1 == nil or var1.data == nil then
                return
            end
            local tbl2 = {}
            for _, value in var1.data do
                if value.id ~= id then
                    table.insert(tbl2, value)
                end
            end
            cache.replaceItem(str1, { data = tbl2, recommendationRequestId = var1.recommendationRequestId })
        end,
        clear = function()
            dataResolver.clear()
        end,
        dispose = function()
            dataResolver.dispose()
        end
    }
end
return createFriendsRecommendationsStore
