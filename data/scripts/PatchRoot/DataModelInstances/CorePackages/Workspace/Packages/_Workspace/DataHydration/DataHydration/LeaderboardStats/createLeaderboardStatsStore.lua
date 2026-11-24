-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _LeaderboardStatsStoreTypes = require(script.Parent.LeaderboardStatsStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function createLeaderboardStatsStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getLeaderboardStats = dataResolver.getCachedItem,
        getLeaderboardStatsBatch = dataResolver.getCachedItems,
        updateLeaderboardStats = cache.replaceItem,
        updateLeaderboardStatsBatch = cache.replaceItems,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createLeaderboardStatsStore
