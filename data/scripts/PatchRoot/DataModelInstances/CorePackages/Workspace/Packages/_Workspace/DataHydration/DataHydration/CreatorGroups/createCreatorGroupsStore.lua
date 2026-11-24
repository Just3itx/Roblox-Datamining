-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchCreatorGroups = require(script.Parent.fetchCreatorGroups)
local _CreatorGroupsStoreTypes = require(script.Parent.CreatorGroupsStoreTypes)

local function createCreatorGroupsStore(tbl1)
    local tbl2 = tbl1 or {}

    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            return fetchCreatorGroups(str1, { network = tbl2.network, baseUrl = tbl2.baseUrl })
        end
    })

    return {
        getGroups = function(arg1)
            return dataResolver.getCachedItem(arg1)
        end,
        fetchGroups = function(arg1)
            return dataResolver.fetchItem(arg1)
        end,
        getAndFetchGroups = function(arg1)
            return dataResolver.getAndFetchItem(arg1)
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createCreatorGroupsStore
