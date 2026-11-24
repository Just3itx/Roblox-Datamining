-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchAdCampaignToolCallStatus = require(script.Parent.fetchAdCampaignToolCallStatus)
local _AdCampaignToolCallStatusStoreTypes = require(script.Parent.AdCampaignToolCallStatusStoreTypes)

local function cacheKey(num1: number, str1: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return tostring(num1) .. ":" .. str1
end

local function parseCacheKey(str1: string): (number?, string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = string.find(str1, ":", 1, true)
    assert(var1 ~= nil, "Invalid ad campaign tool-call status cache key")
    local var2 = tonumber(string.sub(str1, 1, var1 - 1))
    local str2 = string.sub(str1, var1 + 1)
    assert(not (var2 == nil or not (var2 > 0)) and str2 ~= "", "Invalid ad campaign tool-call status cache key")
    return var2, str2
end

local function createAdCampaignToolCallStatusStore(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.fetchToolCallStatus or fetchAdCampaignToolCallStatus

    local cache = createDataCache(tbl2.ttlSeconds or 300)
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            local var2, str2 = parseCacheKey(str1)
            return var1(str2, var2)
        end
    })

    return {
        getToolCallStatus = function(arg1, arg2)
            return dataResolver.getCachedItem((cacheKey(arg1, arg2)))
        end,
        fetchToolCallStatus = function(arg1, arg2)
            return dataResolver.fetchItem((cacheKey(arg1, arg2)))
        end,
        getAndFetchToolCallStatus = function(arg1, arg2)
            return dataResolver.getAndFetchItem((cacheKey(arg1, arg2)))
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createAdCampaignToolCallStatusStore
