-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MediaAssetStoreTypes = require(script.Parent.MediaAssetStoreTypes)

local function createMediaAssetStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getMediaAsset = dataResolver.getCachedItem,
        getMediaAssets = dataResolver.getCachedItems,
        updateMediaAssets = cache.updateItems,
        updateMediaAsset = cache.updateItem,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createMediaAssetStore
