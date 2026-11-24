-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _CreatorInfoStoreTypes = require(script.Parent.CreatorInfoStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function createCreatorInfoStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getCreatorInfo = dataResolver.getCachedItem,
        getCreatorInfos = dataResolver.getCachedItems,
        updateCreatorInfo = cache.updateItem,
        updateCreatorInfos = cache.updateItems,
        clear = cache.clear,
        dispose = cache.dispose
    }
end

return createCreatorInfoStore
