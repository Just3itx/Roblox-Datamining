-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MarketplaceLookStoreTypes = require(script.Parent.MarketplaceLookStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)
local FFlagDataHydrationAccountReset = require(DataHydrationParent.SharedFlags).FFlagDataHydrationAccountReset

local function createMarketplaceLookStore()
    local cache = createDataCache(nil, nil, FFlagDataHydrationAccountReset and { observeLocalUser = false } or nil)

    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end,
        keepCacheOnAccountReset = if FFlagDataHydrationAccountReset then true else nil
    })

    return {
        getMarketplaceLookInfo = dataResolver.getCachedItem,
        getMarketplaceLookInfos = dataResolver.getCachedItems,
        updateMarketplaceLookInfo = cache.updateItem,
        updateMarketplaceLookInfos = cache.updateItems,
        clear = cache.clear,
        dispose = cache.dispose
    }
end

return createMarketplaceLookStore
