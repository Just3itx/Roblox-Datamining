-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchGamePermissions = require(script.Parent.fetchGamePermissions)
local _GamePermissionsStoreTypes = require(script.Parent.GamePermissionsStoreTypes)

local function createGamePermissionsStore(tbl1)
    local tbl2 = tbl1 or {}

    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            return fetchGamePermissions.fetchUniversePermissions(tonumber(str1), { network = tbl2.network, baseUrl = tbl2.baseUrl })
        end
    })

    return {
        fetchUniversePermissions = function(num1: number)
            return dataResolver.fetchItem(tostring(num1))
        end,
        getAndFetchUniversePermissions = function(num1: number)
            return dataResolver.getAndFetchItem(tostring(num1))
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createGamePermissionsStore
