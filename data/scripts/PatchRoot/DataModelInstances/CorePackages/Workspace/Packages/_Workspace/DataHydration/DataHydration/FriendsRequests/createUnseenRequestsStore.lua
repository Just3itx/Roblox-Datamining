-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local LocalUserIdStore = require(DataHydrationParent.LocalUserIdStore).LocalUserIdStore
local _Signals = require(DataHydrationParent.Signals)

local Requests = require(script.Parent.Requests)
local _FriendsRequestsStoreTypes = require(script.Parent.FriendsRequestsStoreTypes)

local function resolveLocalUserId(bool1: boolean) -- Luacid: Inlined by compiler; 4 call sites recovered
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

local function createUnseenRequestsStore()
    local cache = createDataCache()

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_: string)
            return Requests.GetNewFriendRequestsCount():andThen(function(arg1)
                return if arg1 and arg1.count then arg1.count else 0
            end)
        end
    })

    local function clearUnseenRequestCount() -- Luacid: Inlined by compiler; 1 call site recovered
        cache.replaceItem(resolveLocalUserId(false), 0)
    end

    return {
        getUnseenRequestCount = function(tbl1)
            local var1 = resolveLocalUserId(false)

            if tbl1 and tbl1.skipFetch then
                return dataResolver.getCachedItem(var1)
            end

            return dataResolver.getAndFetchItem(var1)
        end,
        refetchUnseenRequestCount = function()
            dataResolver.fetchItem((resolveLocalUserId(false)))
        end,
        clearUnseenRequest = function()
            return Requests.ClearNewFriendRequests():andThen(function()
                clearUnseenRequestCount()
            end)
        end,
        clearUnseenRequestCount = clearUnseenRequestCount,
        clear = function()
            dataResolver.clear()
        end,
        dispose = function()
            dataResolver.dispose()
        end
    }
end
return createUnseenRequestsStore
