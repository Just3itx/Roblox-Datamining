-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local tbl1 = {}
local tbl2 = {}

local function createSingleEntityResolver(func1: (...any) -> (...any), tbl3)
    local var1 = tbl3 and tbl3.cache or tbl1
    local var2 = tbl3 and tbl3.resolver or tbl2
    local cache = createDataCache(var1.ttlSeconds, var1.failedTtlSeconds, { ttlSecondsForItem = var1.ttlSecondsForItem })

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(str1: string, _)
            return func1(tonumber(str1))
        end,
        queueProcessDelaySec = var2.queueProcessDelaySec,
        requestTimeoutSec = var2.requestTimeoutSec,
        replaceItems = var2.replaceItems,
        logError = var2.logError,
        onClear = var2.onClear
    })

    return {
        cache = cache,
        get = function(arg1)
            return dataResolver.getCachedItem(tostring(arg1))
        end,
        fetch = function(arg1)
            return dataResolver.fetchItem(tostring(arg1))
        end,
        refetch = function(arg1)
            return dataResolver.refetchItem(tostring(arg1))
        end,
        getAndFetch = function(arg1)
            return dataResolver.getAndFetchItem(tostring(arg1))
        end,
        update = function(arg1, arg2)
            cache.updateItem(tostring(arg1), arg2)
        end,
        getAccountResetGeneration = dataResolver.getAccountResetGeneration,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createSingleEntityResolver
