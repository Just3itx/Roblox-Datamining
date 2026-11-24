-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _CommunityInfoStoreTypes = require(script.Parent.CommunityInfoStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function createCommunityInfoStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getCommunityInfo = dataResolver.getCachedItem,
        getCommunityInfos = dataResolver.getCachedItems,
        updateCommunityInfo = cache.updateItem,
        updateCommunityInfos = cache.updateItems,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createCommunityInfoStore
